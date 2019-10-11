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


static int two_sm9s5422_perivib_open(struct inode * inode, struct file * file){
	int err;
	err = gpio_request(gpb0(4), "Vib");
	if (err)
		printk("t_sm9s5422_perivib.c failed to request gpb0(4) \n");

	s3c_gpio_setpull(gpb0(4), S3C_GPIO_PULL_NONE);
	gpio_direction_output(gpb0(4), 0);
	printk("t_sm9s5422_perivib_open, \n");

	return 0;
}

static int two_sm9s5422_perivib_release(struct inode * inode, struct file * file){
	printk("two_sm9s5422_perivib_release, \n");
	gpio_free(gpb0(4));
	return 0;
}

static ssize_t two_sm9s5422_perivib_write(struct file * file, const char * buf, size_t length, loff_t * ofs){
	int ret;
	unsigned char cbuf[8];
	ret = copy_from_user(cbuf,buf,length);
	if(cbuf[0]==1)
		gpio_direction_output(gpb0(4), 1);
	else
		gpio_direction_output(gpb0(4), 0);
	return 0;
}


static struct file_operations two_sm9s5422_perivib_fops = {
		.owner = THIS_MODULE,
		.open = two_sm9s5422_perivib_open,
		.release = two_sm9s5422_perivib_release,

		.write = two_sm9s5422_perivib_write,

};

static struct miscdevice two_sm9s5422_perivib_driver = {
		.minor = MISC_DYNAMIC_MINOR,
		.name = "two_sm9s5422_perivib",
		.fops = &two_sm9s5422_perivib_fops,
};

static int two_sm9s5422_perivib_init(void){
	printk("two_sm9s5422_perivib_init, \n");

	return misc_register(&two_sm9s5422_perivib_driver);
}

static void two_sm9s5422_perivib_exit(void){
	printk("two_sm9s5422_perivib_exit, \n");

	misc_deregister(&two_sm9s5422_perivib_driver);

}

module_init(two_sm9s5422_perivib_init);
module_exit(two_sm9s5422_perivib_exit);

MODULE_AUTHOR("Author of the two_sm9s5422_perivib to put it here.");
MODULE_DESCRIPTION("Description of the two_sm9s5422_perivib to put it here.");
MODULE_LICENSE("Dual BSD/GPL");
