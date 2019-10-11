#include <linux/miscdevice.h>
#include <asm/uaccess.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/types.h>
#include <linux/ioport.h>
#include <mach/gpio.h>
#include <plat/gpio-cfg.h>
#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <linux/of_gpio.h>
#include <hanback/gpios.h>
#include <linux/delay.h>
	
static int t_sm9s5422_step_open(struct inode * inode, struct file * file){
	int err,i;
		for(i=0;i<4;i++)
		{
			err = gpio_request(gpb0(i), "step");
			if (err)
				printk("t_sm9s5422_perivib.c failed to request gpb0(%d) \n",i);

			s3c_gpio_setpull(gpb0(i), S3C_GPIO_PULL_NONE);
			gpio_direction_output(gpb0(i), 0);
		}
		printk("t_sm9s5422_step_open, \n");
		return 0;
}

static int t_sm9s5422_step_release(struct inode * inode, struct file * file){
	int i;
		printk("t_sm9s5422_step_release, \n");
		for(i=0;i<4;i++)
			gpio_free(gpb0(i));
		return 0;
	
}

static ssize_t t_sm9s5422_step_write(struct file * file, const char * buf, size_t length, loff_t * ofs){
	int ret; unsigned char cbuf[8];
		ret = copy_from_user(cbuf,buf,length);

		gpio_direction_output(gpb0(0), cbuf[0]);
		gpio_direction_output(gpb0(1), cbuf[1]);
		gpio_direction_output(gpb0(2), cbuf[2]);
		gpio_direction_output(gpb0(3), cbuf[3]);

		return 0;
}

static struct file_operations t_sm9s5422_step_fops = {
	.owner = THIS_MODULE,
	.open = t_sm9s5422_step_open,
	.release = t_sm9s5422_step_release,
	.write = t_sm9s5422_step_write,
};

static struct miscdevice t_sm9s5422_step_driver = {
	.minor = MISC_DYNAMIC_MINOR,
	.name = "t_sm9s5422_step",
	.fops = &t_sm9s5422_step_fops,
};

static int t_sm9s5422_step_init(void){
	printk("t_sm9s5422_step_init, \n");
	
	return misc_register(&t_sm9s5422_step_driver);
}

static void t_sm9s5422_step_exit(void){
	printk("t_sm9s5422_step_exit, \n");

	misc_deregister(&t_sm9s5422_step_driver);
	
}

module_init(t_sm9s5422_step_init);
module_exit(t_sm9s5422_step_exit);

MODULE_AUTHOR("Author of the sm9s5422_step to put it here.");
MODULE_DESCRIPTION("Description of the sm9s5422_step to put it here.");
MODULE_LICENSE("Dual BSD/GPL");
