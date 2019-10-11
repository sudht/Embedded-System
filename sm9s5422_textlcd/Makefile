.SILENT:

include C:/AndroXStudio/Tools/make_adb

export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

ifneq ($(KERNELRELEASE),)
obj-m := sm9s5422_textlcd.o
else
KDIR := /platform/linux
all:
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules

	echo 
	echo "**** Install:" /system/lib/modules/sm9s5422_textlcd.ko "****"
	$(ADB) push sm9s5422_textlcd.ko /system/lib/modules/
	$(ADB) shell chmod 644 /system/lib/modules/sm9s5422_textlcd.ko
	echo 
	echo "**** Load Module:" /system/lib/modules/sm9s5422_textlcd.ko "****"
	$(ADB) shell toolbox rmmod sm9s5422_textlcd > /dev/null
	$(ADB) shell insmod /system/lib/modules/sm9s5422_textlcd.ko
	$(ADB) shell lsmod | grep sm9s5422_textlcd
	echo

endif

clean:
	rm -f *.symvers
	rm -f *.ko
	rm -f *.o
	rm -f *.mod.c
	rm -f *.order
	rm -f .*.cmd
	rm -rf .tmp_versions
