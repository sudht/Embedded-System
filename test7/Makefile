.SILENT:

include C:/AndroXStudio/Tools/make_comm

all: $(OBJECTS)
	$(CC) $(CFLAGS) $(EXEC_LDFLAGS) -save-temps -O2 -o test7 $(OBJECTS) \
		$(LLIB)/libgcc.a

	echo 
	echo "**** Install:" /data/local/tmp/test7 "****"
	$(ADB) push test7 /data/local/tmp
	$(ADB) shell chmod 755 /data/local/tmp/test7

clean:
	rm -f *.o
	rm -f *.i
	rm -f *.s
	rm -f test7
