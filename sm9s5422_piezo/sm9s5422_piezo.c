#include <linux/miscdevice.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/types.h>
#include <linux/delay.h>
#include <linux/ioport.h>
#include <asm/uaccess.h>
#include <mach/gpio.h>
#include <plat/gpio-cfg.h>
#include <linux/pwm.h>
#include <linux/delay.h>
#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <mach/regs-gpio.h>
#include <linux/of_gpio.h>
#include <hanback/gpios.h>

struct sm9s5422_piezo {
	struct pwm_device *pwm;
	int pwm_id;
	int pwm_period_ns;
	int pwm_max;
	int pwm_default;
};

struct sm9s5422_piezo *piezo;

#define PIEZO_PWM_CH 2
#define PERIOD_NS 38265 /* 1000000000 / 35714 => 28 Khz //38265 => 30Khz*/
#define DUTY_NS 1000*18 /* 1000(1 us) * 18 => 18 us */

static int period_table[] =
{
		956022, 902527, 851788, 803858,
		758725, 716332, 676132, 638162,
		602046, 568181, 536480, 506329,
		477783, 451059, 425713, 401767,
		379218, 358037, 337952, 318979,
		301023, 284090, 268168, 253100
};

static int sm9s5422_piezo_open(struct inode * inode, struct file * file){
	printk("sm9s5422_piezo_open, \n");

	return 0;
}

static int sm9s5422_piezo_release(struct inode * inode, struct file * file){
	printk("sm9s5422_piezo_release, \n");

	pwm_config(piezo->pwm,0,PERIOD_NS);
	pwm_disable(piezo->pwm);
	pwm_free(piezo->pwm);

	return 0;
}

static ssize_t sm9s5422_piezo_write(struct file * file, const char * buf, size_t length, loff_t * ofs){
	int period;
	int ret;

	printk("sm9s5422_piezo_write, \n");

	ret = copy_from_user(&period,buf,length);
	pwm_config(piezo->pwm,PERIOD_NS,period_table[period]);
	pwm_enable(piezo->pwm);
	mdelay(500);
	pwm_config(piezo->pwm,0,PERIOD_NS);

	return 0;
}

static struct file_operations sm9s5422_piezo_fops = {
		.owner = THIS_MODULE,
		.open = sm9s5422_piezo_open,
		.release = sm9s5422_piezo_release,
		.write = sm9s5422_piezo_write,
};

static struct miscdevice sm9s5422_piezo_misc_driver = {
		.minor = MISC_DYNAMIC_MINOR,
		.name = "sm9s5422_piezo",
		.fops = &sm9s5422_piezo_fops,
};

static int sm9s5422_piezo_parse_dt(struct platform_device *pdev, struct sm9s5422_piezo *piezo)
{
	struct device *dev = &pdev->dev;
	struct device_node *np = dev->of_node;
	unsigned int rdata;

	dev->platform_data = piezo;
	if(of_property_read_u32(np, "pwm_id", &rdata))
		return -1;
	piezo->pwm_id = rdata;
	if(of_property_read_u32(np, "pwm_period_ns", &rdata))
		return -1;
	piezo->pwm_period_ns = rdata;
	if(of_property_read_u32(np, "pwm_max", &rdata))
		return -1;
	piezo->pwm_max = rdata;
	if(of_property_read_u32(np, "pwm_default", &rdata))
		return -1;
	piezo->pwm_default = rdata;
	return 0;
}

static int sm9s5422_piezo_probe(struct platform_device *pdev)
{
	int ret = 0;

	piezo = devm_kzalloc(&pdev->dev, sizeof(*piezo), GFP_KERNEL);
	if (!piezo) {
		dev_err(&pdev->dev, "no memory for state\n");
		ret = -ENOMEM;
		goto err_alloc;
	}

	if (!pdev->dev.of_node) {
		ret = -ENODEV;
		dev_err(&pdev->dev, "failed to dev.of_node!\n");
		goto err_alloc;
	}

	if(sm9s5422_piezo_parse_dt(pdev, piezo)) {
		ret = -ENODEV;
		dev_err(&pdev->dev, "failed to sm9s5422_piezo_parse_dt!\n");
		goto err_alloc;
	}

	piezo->pwm = pwm_request(piezo->pwm_id, "pwm-piezo");

	if (IS_ERR(piezo->pwm)) {
		ret = -ENODEV;
		dev_err(&pdev->dev, "unable to request legacy PWM!\n");
		goto err_alloc;
	}

	pwm_config(piezo->pwm, piezo->pwm_period_ns * piezo->pwm_default / piezo->pwm_max, piezo->pwm_period_ns);
	pwm_enable(piezo->pwm);

	misc_register(&sm9s5422_piezo_misc_driver);

	return 0;

	err_alloc:
	return ret;
}

static int sm9s5422_piezo_remove(struct platform_device *pdev)
{
	return 0;
}

#if defined(CONFIG_OF)
static const struct of_device_id sm9s5422_piezo_dt[] = {
		{ .compatible = "sm9s5422-piezo" },
		{ },
};
MODULE_DEVICE_TABLE(of, sm9s5422_piezo_dt);
#endif

static struct platform_driver sm9s5422_piezo_driver = {
		.driver = {
				.name = "sm9s5422-piezo",
				.owner = THIS_MODULE,
#if defined(CONFIG_OF)
				.of_match_table = of_match_ptr(sm9s5422_piezo_dt),
#endif
		},
		.probe = sm9s5422_piezo_probe,
		.remove = sm9s5422_piezo_remove,
};

static int __init sm9s5422_piezo_init(void) {
	printk("sm9s5422_piezo_init, \n");

	return platform_driver_register(&sm9s5422_piezo_driver);
}

static void __exit sm9s5422_piezo_exit(void){
	printk("sm9s5422_piezo_exit, \n");

	platform_driver_unregister(&sm9s5422_piezo_driver);
}

module_init(sm9s5422_piezo_init);
module_exit(sm9s5422_piezo_exit);
