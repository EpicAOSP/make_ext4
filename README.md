make_ext4
=========

How to create a flashable EXT4 img

From a linux terminal
	git clone https://github.com/EpicAOSP/make_ext4 -b master

From a linux terminal
	dd if=/dev/zero of=temp.img bs=4096 count=122803
	sudo losetup /dev/loop0 temp.img
	sudo mkfs.ext4 /dev/loop0
	sudo mount -t ext4 /dev/loop0 ./system
	cd system
	sudo dd if=/dev/zero of=big_zero bs=1048576
	sudo rm big_zero
	
Now, on your phone.. from an adb shell or terminal
	tar -H ustar -c /system/* > /sdcard/factoryfs.tar
	
Then copy the tar file to the system directory you have on the pc..
From the linux terminal, inside the system directory...	
	sudo tar xvf factoryfs.tar
	sudo rm factoryfs.tar
	cd ..
	sudo ./bin/mkuserimg.sh -s system factoryfs.img ext4 /system 503mb
	sudo umount ./system
	sudo losetup -d /dev/loop0
	sudo rm temp.img
	
After that you will have a flashable, sparse ext4 image in you directory
called factoryfs.img

To edit it again, from a linux terminal...
	sudo ./bin/simg2img factoryfs.img temp.img
	sudo rm factoryfs.img
	sudo losetup /dev/loop0 temp.img
	sudo mount -t ext4 /dev/loop0 ./system
	
Make your changes in the system directory, then... in a linux terminal..
	sudo ./bin/mkuserimg.sh -s system factoryfs.img ext4 /system 503mb
	sudo umount ./system
	sudo losetup -d /dev/loop0
	sudo rm temp.img
	
Done..
