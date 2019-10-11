.SILENT:

include C:/AndroXStudio/Tools/make_comm

all: $(OBJECTS)
	$(CC) $(CFLAGS) $(EXEC_LDFLAGS) -save-temps -O2 -o sm9s5422_sht20_test $(OBJECTS) \
		$(LLIB)/libgcc.a

	echo 
	echo "**** Install:" /data/local/tmp/sm9s5422_sht20_test "****"
	$(ADB) push sm9s5422_sht20_test /data/local/tmp
	$(ADB) shell chmod 755 /data/local/tmp/sm9s5422_sht20_test

clean:
	rm -f *.o
	rm -f *.i
	rm -f *.s
	rm -f sm9s5422_sht20_test
