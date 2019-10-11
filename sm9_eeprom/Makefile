.SILENT:

include C:/AndroXStudio/Tools/make_adb

export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

ifneq ($(KERNELRELEASE),)
obj-m := sm9_eeprom.o
else
KDIR := /platform/linux
all:
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules

	echo 
	echo "**** Install:" /system/lib/modules/sm9_eeprom.ko "****"
	$(ADB) push sm9_eeprom.ko /system/lib/modules/
	$(ADB) shell chmod 644 /system/lib/modules/sm9_eeprom.ko
	echo 
	echo "**** Load Module:" /system/lib/modules/sm9_eeprom.ko "****"
	$(ADB) shell toolbox rmmod sm9_eeprom > /dev/null
	$(ADB) shell insmod /system/lib/modules/sm9_eeprom.ko
	$(ADB) shell lsmod | grep sm9_eeprom
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
