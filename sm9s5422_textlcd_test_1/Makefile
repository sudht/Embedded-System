.SILENT:

include C:/AndroXStudio/Tools/make_comm

all: $(OBJECTS)
	$(CC) $(CFLAGS) $(EXEC_LDFLAGS) -save-temps -O2 -o sm9s5422_textlcd_test_1 $(OBJECTS) \
		$(LLIB)/libgcc.a

	echo 
	echo "**** Install:" /data/local/tmp/sm9s5422_textlcd_test_1 "****"
	$(ADB) push sm9s5422_textlcd_test_1 /data/local/tmp
	$(ADB) shell chmod 755 /data/local/tmp/sm9s5422_textlcd_test_1

clean:
	rm -f *.o
	rm -f *.i
	rm -f *.s
	rm -f sm9s5422_textlcd_test_1
