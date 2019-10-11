#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

#include <linux/fs.h>
#include <linux/miscdevice.h>
#include <linux/mutex.h>
	
static int kdriver_open(struct inode * inode, struct file * file){
	printk("kdriver_open, \n");
	
	return 0;
}

static int kdriver_release(struct inode * inode, struct file * file){
	printk("kdriver_release, \n");
	
	return 0;
}

static ssize_t kdriver_read(struct file * file, char * buf, size_t length, loff_t * ofs){
	printk("kdriver_read, \n");
	
	return 0;
}

static ssize_t kdriver_write(struct file * file, const char * buf, size_t length, loff_t * ofs){
	printk("kdriver_write, \n");
	
	return 0;
}

static DEFINE_MUTEX(kdriver_mutex);
static long kdriver_ioctl(struct file * file, unsigned int cmd, unsigned long arg){
	printk("kdriver_ioctl, \n");
	
	switch(cmd){
		default:
			mutex_unlock(&kdriver_mutex);
			return ENOTTY;
	}
	
	mutex_unlock(&kdriver_mutex);
	return 0;
}

static struct file_operations kdriver_fops = {
	.owner = THIS_MODULE,
	.open = kdriver_open,
	.release = kdriver_release,
	.read = kdriver_read,
	.write = kdriver_write,
	.unlocked_ioctl = kdriver_ioctl,
};

static struct miscdevice kdriver_driver = {
	.minor = MISC_DYNAMIC_MINOR,
	.name = "kdriver",
	.fops = &kdriver_fops,
};

static int kdriver_init(void){
	printk("kdriver_init, \n");
	
	return misc_register(&kdriver_driver);
}

static void kdriver_exit(void){
	printk("kdriver_exit, \n");

	misc_deregister(&kdriver_driver);
	
}

module_init(kdriver_init);
module_exit(kdriver_exit);

MODULE_AUTHOR("Author of the kdriver to put it here.");
MODULE_DESCRIPTION("Description of the kdriver to put it here.");
MODULE_LICENSE("Dual BSD/GPL");
