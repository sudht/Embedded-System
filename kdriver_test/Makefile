.SILENT:

include C:/AndroXStudio/Tools/make_comm

all: $(OBJECTS)
	$(CC) $(CFLAGS) $(EXEC_LDFLAGS) -save-temps -O2 -o kdriver_test $(OBJECTS) \
		$(LLIB)/libgcc.a

	echo 
	echo "**** Install:" /data/local/tmp/kdriver_test "****"
	$(ADB) push kdriver_test /data/local/tmp
	$(ADB) shell chmod 755 /data/local/tmp/kdriver_test

clean:
	rm -f *.o
	rm -f *.i
	rm -f *.s
	rm -f kdriver_test
