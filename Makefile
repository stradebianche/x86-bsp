# $@ = target file
# $< = first dependency
# $^ = all dependencies

all: mbr.bin

mbr.bin: mbr.asm
	nasm $< -f bin -o $@
#   nasm mbr.asm -f bin -o mbr.bin

run: mbr.bin
	qemu-system-i386 -nographic $<

clean:
	rm *.bin
