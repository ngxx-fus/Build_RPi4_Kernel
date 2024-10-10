obj-m := helloworld_rpi3.o

KERNEL_DIR = /home/msnp/Desktop/ubuntu_backup/stuffthings/linux 

all:
	make -C $(KERNEL_DIR) \
		ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
		M=$(PWD) modules

clean:
	make -C $(KERNEL_DIR) \
		ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
		M=$(PWD) clean

deploy:
	@echo "Copy file *.ko\n"
	cp -rf *.ko ~/Desktop/KO_files


