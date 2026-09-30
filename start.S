.global _start

ldr x0, =__stack_top
mov sp, x0

ldr x1, =__bss_start
ldr x2, =__bss_end

zero_bss:
    cmp x1, x2
    b.ge exit_loop
    str xzr, [x1], #8
    b zero_bss

exit_loop:
bl main

b.
