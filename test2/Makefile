.SILENT:

include C:/AndroXStudio/Tools/make_comm

all: $(OBJECTS)
	$(CC) $(CFLAGS) $(EXEC_LDFLAGS) -save-temps -O2 -o test2 $(OBJECTS) \
		$(LLIB)/libgcc.a

	echo 
	echo "**** Install:" /data/local/tmp/test2 "****"
	$(ADB) push test2 /data/local/tmp
	$(ADB) shell chmod 755 /data/local/tmp/test2

clean:
	rm -f *.o
	rm -f *.i
	rm -f *.s
	rm -f test2
