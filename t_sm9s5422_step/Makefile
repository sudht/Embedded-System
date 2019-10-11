.SILENT:

include C:/AndroXStudio/Tools/make_adb

export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

ifneq ($(KERNELRELEASE),)
obj-m := t_sm9s5422_step.o
else
KDIR := /platform/linux
all:
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules

	echo 
	echo "**** Install:" /system/lib/modules/t_sm9s5422_step.ko "****"
	$(ADB) push t_sm9s5422_step.ko /system/lib/modules/
	$(ADB) shell chmod 644 /system/lib/modules/t_sm9s5422_step.ko
	echo 
	echo "**** Load Module:" /system/lib/modules/t_sm9s5422_step.ko "****"
	$(ADB) shell toolbox rmmod t_sm9s5422_step > /dev/null
	$(ADB) shell insmod /system/lib/modules/t_sm9s5422_step.ko
	$(ADB) shell lsmod | grep t_sm9s5422_step
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
