.SILENT:

include C:/AndroXStudio/Tools/make_comm

all: $(OBJECTS)
	$(CC) $(CFLAGS) $(EXEC_LDFLAGS) -save-temps -O2 -o t_sm9s5422_step_test $(OBJECTS) \
		$(LLIB)/libgcc.a

	echo 
	echo "**** Install:" /data/local/tmp/t_sm9s5422_step_test "****"
	$(ADB) push t_sm9s5422_step_test /data/local/tmp
	$(ADB) shell chmod 755 /data/local/tmp/t_sm9s5422_step_test

clean:
	rm -f *.o
	rm -f *.i
	rm -f *.s
	rm -f t_sm9s5422_step_test
