#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/types.h>
#include <linux/ioport.h>
#include <asm/uaccess.h>
#include <linux/delay.h>
#include <linux/miscdevice.h>
#include <mach/gpio.h>
#include <plat/gpio-cfg.h>
#include <linux/of_gpio.h>
#include <hanback/gpios.h>
#include "m2_textlcd.h"

void setcommand(unsigned char command)
{
	int i;

	gpio_direction_output(gpb1(2),0);
	gpio_direction_output(gpb1(0),0);

	udelay(10);
	for(i=0; i<8; i++)
	{
		if (command & 0x01)
			gpio_direction_output(gpf1(i),1);
		else
			gpio_direction_output(gpf1(i),0);

		command >>= 1;
	}
	udelay(10);
	gpio_direction_output(gpb1(0),1);
	udelay(10);
	gpio_direction_output(gpb1(0),0);
	udelay(41);
}
void writebyte(unsigned char cData)
{
	int i;

	gpio_direction_output(gpb1(2),1);
	gpio_direction_output(gpb1(0),0);

	udelay(10);
	for(i=0; i<8; i++)
	{
		if (cData & 0x01)
			gpio_direction_output(gpf1(i),1);
		else
			gpio_direction_output(gpf1(i),0);

		cData >>= 1;
	}
	udelay(10);

	gpio_direction_output(gpb1(0),1);
	udelay(10);
	gpio_direction_output(gpb1(0),0);
	udelay(41);
}
void initialize_textlcd()
{
	setcommand(0x38);
	setcommand(0x38);
	setcommand(0x38);
	setcommand(0x0c);
	setcommand(0x01);
	udelay(1960);
	setcommand(0x06);
}
int function_set()
{
	setcommand(0x38);
	return 1;
}

int display_control(int display_enable)
{
	if(display_enable == 0)
		setcommand(0x0c);
	else
		setcommand(0x08);

	return 1;
}
int cursor_control(int cursor_enable)
{
	if(cursor_enable == 0)
		setcommand(0x0e);
	else
		setcommand(0x0C);

	return 1;
}

int cursor_shift(int set_shift)
{
	if (set_shift == 0)
		setcommand(0x14);
	else
		setcommand(0x10);

	return 1;
}
int entry_mode_set()
{
	setcommand(0x06);
	return 1;
}

int return_home()
{
	setcommand(0x02);
	return 1;
}
int clear_display()
{
	setcommand(0x01);
	return 1;
}

int set_ddram_address(int pos)
{
	if (pos == 0)
		setcommand(0x80);
	else
		setcommand(0xC0);

	return 1;
}
static int sm9s5422_textlcd_open(struct inode * inode, struct file * file){
	int err,i;

	unsigned char pStr[] = "Hello!!!";
	unsigned char pStr1[] = "Welcome!";

	printk("sm9s5422_textlcd_open, \n");

	for(i=0;i<3;i++)
	{
		err = gpio_request(gpb1(i), "GPB1");
		if(err)
			printk("m2_textlcd.c failed to request GPB1(%d) \n",i);
		else{
			s3c_gpio_setpull(gpb1(i), S3C_GPIO_PULL_NONE);
			gpio_direction_output(gpb1(i), 0);
		}
	}

	for(i=0;i<8;i++)
	{
		err = gpio_request(gpf1(i), "GPF1");
		if(err)
			printk("m2_textlcd.c failed to request GPF1(%d) \n",i);
		else{
			s3c_gpio_setpull(gpf1(i), S3C_GPIO_PULL_NONE);
			gpio_direction_output(gpf1(i), 0);
		}
	}
	initialize_textlcd();

	set_ddram_address(0);

	for(i=0; i<8; i++)
		writebyte(pStr[i]);

	set_ddram_address(1);

	for(i=0; i<8; i++)
		writebyte(pStr1[i]);

	return 0;
}
static int sm9s5422_textlcd_release(struct inode * inode, struct file * file){
	int i;

	for(i=0;i<8;i++)
		gpio_free(gpf1(i));
	for(i=0;i<3;i++)
		gpio_free(gpb1(i));
	printk("sm9s5422_textlcd_release, \n");
	return 0;
}
static DEFINE_MUTEX(sm9s5422_textlcd_mutex);
static long sm9s5422_textlcd_ioctl(struct file * file,
		unsigned int cmd, unsigned char cData){
	printk("sm9s5422_textlcd_ioctl, \n");

	switch(cmd) {
	case M2_TEXTLCD_FUNCTION_SET:
		function_set();
		break;
	case M2_TEXTLCD_DISPLAY_ON:
		display_control(0);
		break;
	case M2_TEXTLCD_DISPLAY_OFF:
		display_control(1);
		break;
	case M2_TEXTLCD_DISPLAY_CURSOR_ON:
		cursor_control(0);
		break;
	case M2_TEXTLCD_DISPLAY_CURSOR_OFF:
		cursor_control(1);
		break;
	case M2_TEXTLCD_CURSOR_SHIFT_RIGHT:
		cursor_shift(0);
		break;
	case M2_TEXTLCD_CURSOR_SHIFT_LEFT:
		cursor_shift(1);
		break;
	case M2_TEXTLCD_ENTRY_MODE_SET:
		entry_mode_set();
		break;
	case M2_TEXTLCD_RETURN_HOME:
		return_home();
		break;
	case M2_TEXTLCD_CLEAR:
		clear_display();
		break;
	case M2_TEXTLCD_DD_ADDRESS_1:
		set_ddram_address(0);
		break;
	case M2_TEXTLCD_DD_ADDRESS_2:
		set_ddram_address(1);
		break;
	case M2_TEXTLCD_WRITE_BYTE:
		writebyte(cData);
		break;
	default:
		printk("driver : no such command!\n");
		return -ENOTTY;
	}

	return 0;
}
static struct file_operations sm9s5422_textlcd_fops = {
		.owner = THIS_MODULE,
		.open = sm9s5422_textlcd_open,
		.release = sm9s5422_textlcd_release,
		.unlocked_ioctl = sm9s5422_textlcd_ioctl,
};

static struct miscdevice sm9s5422_textlcd_driver = {
		.minor = MISC_DYNAMIC_MINOR,
		.name = "sm9s5422_textlcd",
		.fops = &sm9s5422_textlcd_fops,
};
static int sm9s5422_textlcd_init(void){
	printk("sm9s5422_textlcd_init, \n");

	return misc_register(&sm9s5422_textlcd_driver);
}

static void sm9s5422_textlcd_exit(void){
	printk("sm9s5422_textlcd_exit, \n");

	misc_deregister(&sm9s5422_textlcd_driver);
}
module_init(sm9s5422_textlcd_init);
module_exit(sm9s5422_textlcd_exit);

MODULE_AUTHOR("Hanback");
MODULE_DESCRIPTION("Textlcd Control");
MODULE_LICENSE("Dual BSD/GPL");
