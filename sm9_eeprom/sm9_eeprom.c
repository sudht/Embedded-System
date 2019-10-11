#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/i2c.h>
#include <linux/init.h>
#include <linux/input.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/workqueue.h>
#include <linux/slab.h>
#include <linux/gpio.h>
#include <mach/gpio.h>
#include <mach/regs-gpio.h>
#include <mach/regs-pmu.h>
#include <plat/gpio-cfg.h>
#include <linux/spi/spi.h>
#include <linux/miscdevice.h>
#include <linux/delay.h>
#include <asm/uaccess.h>
#include <linux/fs.h>
#include <linux/ioport.h>


#define EEPROM_WREN 0x6 // Set Write Enable Latch
#define EEPROM_WRDI 0x4 // Reset Write Enable Latch
#define EEPROM_RDSR 0x5 // Read status Register
#define EEPROM_WRSR 0x1 // Write status Register
#define EEPROM_READ 0x3 // Read Data from Memory Array
#define EEPROM_WRITE 0x2 // Write Data to Memory Array

struct sm9_spi {
	struct miscdevice *misc;
	struct spi_device *spi;
};

struct spi_device *gSPI;

static int sm9_eeprom_open(struct inode *inode, struct file *file)
{
	struct sm9_spi *spi = dev_get_drvdata(&gSPI->dev);

	file->private_data = spi;

	return 0;
}

static ssize_t sm9_eeprom_read(struct file * file, uint8_t * buf, size_t length, loff_t * ofs){

	struct sm9_spi *spi = (struct sm9_spi *)file->private_data;

	int ret;
	uint8_t read_packet=0;
	uint8_t tx_packet_write[4];

	ret = copy_from_user(tx_packet_write,buf,length);

	spi_write_then_read(spi->spi, &tx_packet_write[0], length, &read_packet, 1);

	return read_packet;
}

static ssize_t sm9_eeprom_write(struct file * file, uint8_t * buf, size_t length, loff_t * ofs){

	struct sm9_spi *spi = (struct sm9_spi *)file->private_data;

	int ret;
	uint8_t tx_packet_write[4];

	ret = copy_from_user(tx_packet_write,buf,length);

	spi_write_then_read(spi->spi, &tx_packet_write[0], length, NULL, 0);

	return 0;
}


static const struct file_operations sm9_eeprom_fops = {
		.owner = THIS_MODULE,
		.open = sm9_eeprom_open,
		.read = sm9_eeprom_read,
		.write = sm9_eeprom_write,
};

int sm9_eeprom_probe(struct spi_device *spi)
{
	int rc;

	struct sm9_spi *sm9_spi = dev_get_drvdata(&spi->dev);

	if(!(sm9_spi->misc = kzalloc(sizeof(struct miscdevice), GFP_KERNEL))) {
		printk("ioboard-spi misc struct malloc error!\n");
		return -ENOMEM;
	}

	sm9_spi->misc->minor = MISC_DYNAMIC_MINOR;
	sm9_spi->misc->name = "sm9_eeprom";
	sm9_spi->misc->fops = &sm9_eeprom_fops;

	gSPI = spi;

	if((rc = misc_register(sm9_spi->misc)) < 0) {
		printk("%s : spi misc register fail!\n", __func__);
		kfree(sm9_spi->misc);
		return rc;
	}

	return 0;
}

void sm9_eeprom_remove(struct device *dev)
{
	struct sm9_spi *sm9_spi = dev_get_drvdata(dev);

	misc_deregister(sm9_spi->misc);

	kfree(sm9_spi->misc);
}

static int sm9_spi_probe (struct spi_device *spi)
{
	int ret;
	struct sm9_spi *sm9_spi;

	if(!(sm9_spi = kzalloc(sizeof(struct sm9_spi), GFP_KERNEL))) {
		printk("ioboard-spi struct malloc error!\n");
		return -ENOMEM;
	}

	sm9_spi->spi = spi;
	sm9_spi->spi->mode = SPI_MODE_0;
	sm9_spi->spi->bits_per_word = 8;
	sm9_spi->spi->max_speed_hz = 10000;

	dev_set_drvdata(&spi->dev, sm9_spi);

	if((ret = spi_setup(spi)) < 0) {
		printk("%s(%s) fail!\n", __func__, "sm9-spi");
		goto err;
	}

	if((ret = sm9_eeprom_probe(spi)) < 0) {
		printk("%s : misc driver added fail!\n", __func__);
		goto err;
	}

	printk("\n=================== %s ===================\n\n", __func__);
	return 0;

	err:
	printk("\n=================== %s FAIL! ===================\n\n", __func__);
	kfree(sm9_spi);

	return ret;

}

static int sm9_spi_remove (struct spi_device *spi)
{
	return 0;
}

static const struct of_device_id sm9_spi_dt[] = {
		{ .compatible = "sm9-spi" },
		{ },
};
MODULE_DEVICE_TABLE(of, sm9_spi_dt);

static struct spi_driver sm9_spi_driver = {
		.driver = {
				.name = "sm9-spi",
				.bus = &spi_bus_type,
				.owner = THIS_MODULE,
				.of_match_table = of_match_ptr(sm9_spi_dt),
		},
		.probe = sm9_spi_probe,
		.remove = sm9_spi_remove,
};

static int __init sm9_spi_init(void)
{
	return spi_register_driver(&sm9_spi_driver);
}
module_init(sm9_spi_init);

static void __exit sm9_spi_exit(void)
{
	spi_unregister_driver(&sm9_spi_driver);
}
module_exit(sm9_spi_exit);

MODULE_DESCRIPTION("EEPROM Driver");
MODULE_AUTHOR("Hanback.Elec");
MODULE_LICENSE("GPL");
