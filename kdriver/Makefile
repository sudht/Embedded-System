.SILENT:

include C:/AndroXStudio/Tools/make_adb

export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

ifneq ($(KERNELRELEASE),)
obj-m := kdriver.o
else
KDIR := /platform/linux
all:
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules

	echo 
	echo "**** Install:" /system/lib/modules/kdriver.ko "****"
	$(ADB) push kdriver.ko /system/lib/modules/
	$(ADB) shell chmod 644 /system/lib/modules/kdriver.ko
	echo 
	echo "**** Load Module:" /system/lib/modules/kdriver.ko "****"
	$(ADB) shell toolbox rmmod kdriver > /dev/null
	$(ADB) shell insmod /system/lib/modules/kdriver.ko
	$(ADB) shell lsmod | grep kdriver
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
