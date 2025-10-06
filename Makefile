NASM=nasm
QEMU=qemu-system-x86_64
IMG=disk.img

all: $(IMG)

bootloader.bin: bootloader.asm
	$(NASM) -f bin bootloader.asm -o bootloader.bin

second_stage.bin: second_stage.asm
	$(NASM) -f bin second_stage.asm -o second_stage.bin

$(IMG): bootloader.bin second_stage.bin
	dd if=/dev/zero of=$(IMG) bs=512 count=2880
	dd if=bootloader.bin of=$(IMG) conv=notrunc
	dd if=second_stage.bin of=$(IMG) bs=512 seek=1 conv=notrunc

.PHONY: test clean

test: $(IMG)
	$(QEMU) -fda $(IMG)

# -drive format=raw,file=$(IMG)

clean:
	rm -f bootloader.bin second_stage.bin $(IMG)
