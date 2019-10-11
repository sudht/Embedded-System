.SILENT:

include C:/AndroXStudio/Tools/make_adb

export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

ifneq ($(KERNELRELEASE),)
obj-m := two_sm9s5422_perivib.o
else
KDIR := /platform/linux
all:
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules

	echo 
	echo "**** Install:" /system/lib/modules/two_sm9s5422_perivib.ko "****"
	$(ADB) push two_sm9s5422_perivib.ko /system/lib/modules/
	$(ADB) shell chmod 644 /system/lib/modules/two_sm9s5422_perivib.ko
	echo 
	echo "**** Load Module:" /system/lib/modules/two_sm9s5422_perivib.ko "****"
	$(ADB) shell toolbox rmmod two_sm9s5422_perivib > /dev/null
	$(ADB) shell insmod /system/lib/modules/two_sm9s5422_perivib.ko
	$(ADB) shell lsmod | grep two_sm9s5422_perivib
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
