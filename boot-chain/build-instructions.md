## Build TF-A + U-Boot for QEMU virt

1. Clone:
   git clone https://github.com/ARM-software/arm-trusted-firmware.git
   git clone https://github.com/u-boot/u-boot.git

2. Build U-Boot:
   cd u-boot
   make qemu_arm64_defconfig
   make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

3. Build TF-A (pointing at u-boot.bin):
   cd arm-trusted-firmware
   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=qemu BL33=~/u-boot/u-boot.bin all fip

4. Boot:
   qemu-system-aarch64 -machine virt,secure=on -cpu cortex-a57 -m 1024 \
     -nographic -bios build/qemu/release/qemu_fw.bios