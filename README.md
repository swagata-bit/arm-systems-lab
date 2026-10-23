# ARM Systems Lab

Hands-on exploration of the ARMv8-A (AArch64) boot process, built from
scratch and run on QEMU's `virt` machine — from a bare-metal startup
sequence up through a full Trusted Firmware-A (TF-A) + U-Boot boot chain.

Built as part of interview preparation for embedded/firmware roles
focused on ARM system architecture.

## What this covers

- Writing a linker script and startup assembly (`start.S`) from scratch:
  stack setup, `.bss` zeroing, and handoff to C — the same fundamentals
  as Cortex-M startup code, adapted to AArch64's exception-level model
  and 64-bit addressing.
- Understanding AArch64 fixed-width (32-bit) instruction encoding,
  including why loading a 64-bit address requires a literal pool
  (`bare-metal/experiments/literal_test.S`).
- Building and booting a real firmware chain: BL1 → BL2 → BL31 (TF-A)
  → BL33 (U-Boot), matching how real ARM-A hardware boots —
  from on-chip Boot ROM/SRAM through DRAM initialization to a running
  bootloader shell.

## Structure

- `bare-metal/` — linker script, startup assembly, and small experiments
  run directly via QEMU's `-kernel` flag (no bootloader involved).
- `boot-chain/` — build instructions and a captured boot log for the full
  TF-A + U-Boot chain, run via QEMU's `-bios` flag (a real boot sequence,
  starting from reset).

## Why two approaches

`bare-metal/` uses QEMU's `-kernel` flag, which loads an ELF directly
and skips the boot process entirely — useful for isolating and
understanding startup fundamentals (stack, `.bss`, entry point) without
the complexity of a full boot chain.

`boot-chain/` uses `-bios`, which tells QEMU to start executing from
reset, the same as real hardware — exercising the actual BL1 → BL2 →
BL31 → BL33 sequence, DRAM initialization, and the EL3/Secure split.

## Requirements

- `qemu-system-aarch64`
- `aarch64-linux-gnu-gcc` / `binutils` (AArch64 cross toolchain)
- See `boot-chain/build-instructions.md` for TF-A/U-Boot build steps