%.bin: %.asm
	nasm $< -o $@
	
master.img:boot.bin
ifeq ("$(wildcard master.img)", "")
	bximage -q -hd=16 -mode=create -sectsize=512 -imgmode=flat $@
endif
	dd if=boot.bin of=master.img bs=512 count=1 conv=notrunc

.PHONY:bochs
bochs:master.img
	bochs -q

.PHONY:clean
clean:
	rm *.img
	rm *.bin