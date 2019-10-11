.SILENT:

include C:/AndroXStudio/Tools/make_adb

export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

ifneq ($(KERNELRELEASE),)
obj-m := t_sm9s5422_interrupt.o
else
KDIR := /platform/linux
all:
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules

	echo 
	echo "**** Install:" /system/lib/modules/t_sm9s5422_interrupt.ko "****"
	$(ADB) push t_sm9s5422_interrupt.ko /system/lib/modules/
	$(ADB) shell chmod 644 /system/lib/modules/t_sm9s5422_interrupt.ko
	echo 
	echo "**** Load Module:" /system/lib/modules/t_sm9s5422_interrupt.ko "****"
	$(ADB) shell toolbox rmmod t_sm9s5422_interrupt > /dev/null
	$(ADB) shell insmod /system/lib/modules/t_sm9s5422_interrupt.ko
	$(ADB) shell lsmod | grep t_sm9s5422_interrupt
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
