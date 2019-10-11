#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/miscdevice.h>
#include <linux/mutex.h>
#include <linux/errno.h>
#include <linux/types.h>
#include <linux/ioport.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/sched.h>
#include <linux/gpio.h>
#include <mach/regs-gpio.h>
#include <plat/gpio-cfg.h>
#include <mach/irqs.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include <hanback/gpios.h>

static DECLARE_WAIT_QUEUE_HEAD(wait_queue);

int irq_num=0;
int irqNum[5];
int int_gpios[5];

static irqreturn_t button_interrupt(int irq,void *dev_id){
	irq_num=irq;
	wake_up_interruptible(&wait_queue);
	return IRQ_HANDLED;
}


static int t_sm9s5422_interrupt_open(struct inode * inode, struct file * file){

	printk("t_sm9s5422_interrupt_open, \n");

	return 0;
}

static int t_sm9s5422_interrupt_release(struct inode * inode, struct file * file){
	printk("t_sm9s5422_interrupt_release, \n");

	return 0;
}

static ssize_t t_sm9s5422_interrupt_read(struct file * file, char * buf, size_t length, loff_t * ofs){
	char msg[100];
	int ret=0;
	printk("t_sm9s5422_interrupt_read, \n");
	interruptible_sleep_on(&wait_queue);

	if(irq_num==irqNum[0])
		sprintf(msg,"Up");
	else if (irq_num==irqNum[1])
		sprintf(msg,"Down");
	else if (irq_num==irqNum[2])
			sprintf(msg,"Left");
	else if (irq_num==irqNum[3])
			sprintf(msg,"Right");
	else if (irq_num==irqNum[4])
			sprintf(msg,"Center");

	ret=copy_to_user(buf,&msg,sizeof(msg));
	if(ret<0)
		return -1;

	return 0;
}


static struct file_operations t_sm9s5422_interrupt_fops = {
	.owner = THIS_MODULE,
	.open = t_sm9s5422_interrupt_open,
	.release = t_sm9s5422_interrupt_release,
	.read = t_sm9s5422_interrupt_read,

};

static struct miscdevice t_sm9s5422_interrupt_driver = {
	.minor = MISC_DYNAMIC_MINOR,
	.name = "t_sm9s5422_interrupt",
	.fops = &t_sm9s5422_interrupt_fops,
};

static int t_sm9s5422_interrupt_init(void){
	int res;

	printk("t_sm9s5422_interrupt_init, \n");
	irqNum[0]=gpio_to_irq(gpx0(3));
	irqNum[1]=gpio_to_irq(gpx0(4));
	irqNum[2]=gpio_to_irq(gpx0(5));
	irqNum[3]=gpio_to_irq(gpx1(6));
	irqNum[4]=gpio_to_irq(gpx1(7));

	res=request_irq(irqNum[0],button_interrupt,IRQF_TRIGGER_FALLING,"GPIO",NULL);
	if(res<0)
		printk(KERN_ERR "%s : Request for IRQ %d failed\n",__FUNCTION__,irqNum[0]);

	res=request_irq(irqNum[1],button_interrupt,IRQF_TRIGGER_FALLING,"GPIO",NULL);
	if(res<0)
		printk(KERN_ERR "%s : Request for IRQ %d failed\n",__FUNCTION__,irqNum[1]);

	res=request_irq(irqNum[2],button_interrupt,IRQF_TRIGGER_FALLING,"GPIO",NULL);
	if(res<0)
		printk(KERN_ERR "%s : Request for IRQ %d failed\n",__FUNCTION__,irqNum[2]);
	res=request_irq(irqNum[3],button_interrupt,IRQF_TRIGGER_FALLING,"GPIO",NULL);
	if(res<0)
		printk(KERN_ERR "%s : Request for IRQ %d failed\n",__FUNCTION__,irqNum[3]);
	res=request_irq(irqNum[4],button_interrupt,IRQF_TRIGGER_FALLING,"GPIO",NULL);
	if(res<0)
		printk(KERN_ERR "%s : Request for IRQ %d failed\n",__FUNCTION__,irqNum[4]);


	return misc_register(&t_sm9s5422_interrupt_driver);
}

static void t_sm9s5422_interrupt_exit(void){
	printk("t_sm9s5422_interrupt_exit, \n");
	free_irq(irqNum[0],NULL);
	free_irq(irqNum[1],NULL);
	free_irq(irqNum[2],NULL);
	free_irq(irqNum[3],NULL);
	free_irq(irqNum[4],NULL);

	misc_deregister(&t_sm9s5422_interrupt_driver);

}

module_init(t_sm9s5422_interrupt_init);
module_exit(t_sm9s5422_interrupt_exit);

MODULE_AUTHOR("Author of the t_sm9s5422_interrupt to put it here.");
MODULE_DESCRIPTION("Description of the t_sm9s5422_interrupt to put it here.");
MODULE_LICENSE("Dual BSD/GPL");
