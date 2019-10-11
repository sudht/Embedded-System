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
#include <mach/regs-gpio.h>
#include <linux/of_gpio.h>
#include <hanback/gpios.h>
#include <linux/delay.h>

static int t_sm9s5422_led_open(struct inode * inode, struct file * file){
	int err, i;

	printk("t_sm9s5422_led_open, \n");

	for (i=0; i<8; i++)
	{
		err = gpio_request(gpy7(i), "Led");

		if(err)
			printk("led.c failed to request gpy7(%d) \n", i);

		s3c_gpio_setpull(gpy7(i), S3C_GPIO_PULL_NONE);
		gpio_direction_output(gpy7(i), 0);
	}

	return 0;
}

static int t_sm9s5422_led_release(struct inode * inode, struct file * file){
	int i;

	printk("t_sm9s5422_led_release, \n");

	for (i=0; i<8; i++)
		gpio_free(gpy7(i));

	return 0;
}

static ssize_t t_sm9s5422_led_write(struct file * file, const char * buf, size_t length, loff_t * ofs){
	int ret;
	unsigned char cbuf[8];

	printk("t_sm9s5422_led_write, \n");
	
	ret = copy_from_user(cbuf, buf, length);
	
	gpio_direction_output(gpy7(0), (unsigned int) cbuf[0]);
	gpio_direction_output(gpy7(1), (unsigned int) cbuf[1]);
	gpio_direction_output(gpy7(2), (unsigned int) cbuf[2]);
	gpio_direction_output(gpy7(3), (unsigned int) cbuf[3]);
	gpio_direction_output(gpy7(4), (unsigned int) cbuf[4]);
	gpio_direction_output(gpy7(5), (unsigned int) cbuf[5]);
	gpio_direction_output(gpy7(6), (unsigned int) cbuf[6]);
	gpio_direction_output(gpy7(7), (unsigned int) cbuf[7]);
	
	return 0;
}

static struct file_operations t_sm9s5422_led_fops = {
		.owner = THIS_MODULE,
		.open = t_sm9s5422_led_open,
		.release = t_sm9s5422_led_release,
		.write = t_sm9s5422_led_write,
};

static struct miscdevice t_sm9s5422_led_driver = {
		.minor = MISC_DYNAMIC_MINOR,
		.name = "t_sm9s5422_led",
		.fops = &t_sm9s5422_led_fops,
};

static int t_sm9s5422_led_init(void){
	printk("t_sm9s5422_led_init, \n");
	return misc_register(&t_sm9s5422_led_driver);
}

static void t_sm9s5422_led_exit(void){
	printk("t_sm9s5422_led_exit, \n");
	misc_deregister(&t_sm9s5422_led_driver);
}

module_init(t_sm9s5422_led_init);
module_exit(t_sm9s5422_led_exit);

MODULE_AUTHOR("Hanback");
MODULE_DESCRIPTION("Led Control");
MODULE_LICENSE("Dual BSD/GPL");
