#include <linux/miscdevice.h>
#include <asm/uaccess.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/types.h>
#include <linux/ioport.h>
#include <linux/delay.h>
#include <mach/gpio.h>
#include <plat/gpio-cfg.h>
#include <linux/of_gpio.h>
#include <hanback/gpios.h>

unsigned int ibuf[8];

int Getsegmentcode_base(int x)
{
	unsigned int i;

	for (i = 0; i < 8; i++)
		ibuf[i] = 0;

	switch (x) {
	case 0:
		for (i = 0; i < 6; i++) ibuf[i] = 1;
		break;

	case 1: ibuf[1] = 1; ibuf[2] = 1; break;

	case 2:
		for (i = 0; i < 2; i++) ibuf[i] = 1;
		for (i = 3; i < 5; i++) ibuf[i] = 1;
		ibuf[6] = 1;
		break;
	case 3:
		for (i = 0; i < 4; i++) ibuf[i] = 1;
		ibuf[6] = 1;
		break;

	case 4:
		for (i = 1; i < 3; i++) ibuf[i] = 1;
		for (i = 5; i < 7; i++) ibuf[i] = 1;
		break;
	case 5:
		ibuf[0] = 1;
		for (i = 2; i < 4; i++) ibuf[i] = 1;
		for (i = 5; i < 7; i++) ibuf[i] = 1;
		break;
	case 6:
		for (i = 2; i < 7; i++) ibuf[i] = 1;
		break;

	case 7:
		for (i = 0; i < 3; i++) ibuf[i] = 1;
		ibuf[5] = 1;
		break;
	case 8:
		for (i = 0; i < 7; i++) ibuf[i] = 1;
		break;

	case 9:
		for (i = 0; i < 4; i++) ibuf[i] = 1;
		for (i = 5; i < 7; i++) ibuf[i] = 1;
		break;

	case 10:
		for (i = 0; i < 3; i++) ibuf[i] = 1;
		for (i = 4; i < 8; i++) ibuf[i] = 1;
		break;
	case 11:
		for (i = 0; i < 8; i++) ibuf[i] = 1;
		break;
	case 12:
		for (i = 3; i < 6; i++) ibuf[i] = 1;
		ibuf[0] = 1;
		ibuf[7] = 1;
		break;
	case 13:
		ibuf[7] = 1;
		for (i = 0; i < 6; i++) ibuf[i] = 1;
		break;
	case 14:
		for (i = 3; i < 8; i++) ibuf[i] = 1;
		ibuf[0] = 1;
		break;
	case 15:
		for (i = 4; i < 8; i++) ibuf[i] = 1;
		ibuf[0] = 1;
		break;

	default:
		for (i = 0; i < 8; i++) ibuf[i] = 1;
		break;
	}
	return 0;
}
static int t_sm9s5422_segment_open(struct inode * inode,
	struct file * file) {
	int err, i;

	printk("t_sm9s5422_segment_open, \n");

	for (i = 0; i < 8; i++)
	{
		err = gpio_request(gpe0(i), "GPE0");
		if (err)
			printk("segment.c failed to request GPE0(%d)\n", i);
		s3c_gpio_setpull(gpe0(i), S3C_GPIO_PULL_NONE);
		gpio_direction_output(gpe0(i), 0);
	}

	for (i = 0; i < 7; i++)
	{
		if (i != 5)
		{
			err = gpio_request(gpg1(i), "GPG1");
			if (err)
				printk("segment.c failed to request GPG1(%d)\n", i);
			s3c_gpio_setpull(gpg1(i), S3C_GPIO_PULL_UP);
			gpio_direction_output(gpg1(i), 1);
		}
	}

	return 0;
}

static int t_sm9s5422_segment_release(struct
	inode * inode, struct file * file) {
	int i;

	printk("t_sm9s5422_segment_release, \n");

	for (i = 0; i < 8; i++)
		gpio_free(gpe0(i));

	for (i = 0; i < 7; i++)
	{
		if (i != 5)
			gpio_free(gpg1(i));
	}

	return 0;
}
static ssize_t t_sm9s5422_segment_write(struct file * file,
	const char * buf,
	size_t length, loff_t * ofs) {
	unsigned int ret, i;
	unsigned char data[6];

	printk("t_sm9s5422_segment_write, \n");

	ret = copy_from_user(data, buf, 6);

	Getsegmentcode_base((unsigned int)data[0]);

	gpio_direction_output(gpg1(0), 0);
	gpio_direction_output(gpg1(1), 1);
	for (i = 0; i < 8; i++) {
		gpio_direction_output(gpe0(i), (unsigned int)ibuf[i]);
	}
	mdelay(5);

	Getsegmentcode_base((unsigned int)data[1]);

	gpio_direction_output(gpg1(0), 1);
	gpio_direction_output(gpg1(1), 0);
	for (i = 0; i < 8; i++) {
		gpio_direction_output(gpe0(i), (unsigned int)ibuf[i]);
	}
	mdelay(5);

	Getsegmentcode_base((unsigned int)data[2]);

	gpio_direction_output(gpg1(1), 1);
	gpio_direction_output(gpg1(2), 0);
	for (i = 0; i < 8; i++) {
		gpio_direction_output(gpe0(i), (unsigned int)ibuf[i]);
	}
	mdelay(5);
	Getsegmentcode_base((unsigned int)data[3]);

	gpio_direction_output(gpg1(2), 1);
	gpio_direction_output(gpg1(3), 0);
	for (i = 0; i < 8; i++) {
		gpio_direction_output(gpe0(i), (unsigned int)ibuf[i]);
	}
	mdelay(5);


	gpio_direction_output(gpg1(3), 1);
	gpio_direction_output(gpg1(4), 0);
	for (i = 0; i < 8; i++) {
		gpio_direction_output(gpe0(i), (unsigned int)ibuf[i]);
	}
	mdelay(5);

	Getsegmentcode_base((unsigned int)data[5]);

	gpio_direction_output(gpg1(4), 1);
	gpio_direction_output(gpg1(6), 0);
	for (i = 0; i < 8; i++) {
		gpio_direction_output(gpe0(i), (unsigned int)ibuf[i]);
	}
	mdelay(1);
	gpio_direction_output(gpg1(6), 1);

	return length;
}


static struct file_operations t_sm9s5422_segment_fops = {
.owner = THIS_MODULE,
.open = t_sm9s5422_segment_open,
.release = t_sm9s5422_segment_release,
.write = t_sm9s5422_segment_write,
};

static struct miscdevice t_sm9s5422_segment_driver = {
.minor = MISC_DYNAMIC_MINOR,
.name = "t_sm9s5422_segment",
.fops = &t_sm9s5422_segment_fops,
};

static int t_sm9s5422_segment_init(void) {
	printk("t_sm9s5422_segment_init, \n");

	return misc_register(&t_sm9s5422_segment_driver);
}

static void t_sm9s5422_segment_exit(void) {
	printk("t_sm9s5422_segment_exit, \n");

	misc_deregister(&t_sm9s5422_segment_driver);

}

module_init(t_sm9s5422_segment_init);
module_exit(t_sm9s5422_segment_exit);

MODULE_AUTHOR("Hanback");
MODULE_DESCRIPTION("Segment Control");
MODULE_LICENSE("Dual BSD/GPL");
