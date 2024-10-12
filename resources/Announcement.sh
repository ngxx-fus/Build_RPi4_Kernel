#!/bin/bash

__01="
    References:
        https://www.raspberrypi.com/documentation/computers/linux_kernel.html
    This script is made in other to build the kernel 
    for Raspberry Pi 4. Include installing requirement 
    packages, clone linux.img. This script using cross-
    compile, which is much quicker than  build locally 
    on a Raspberry Pi, but requires more setup. During 
    the intallation, Anytime you want to stop the script, 
    just spam <ctrl+z>.
"

__02="
    References:
        https://www.raspberrypi.com/documentation/computers/linux_kernel.html
    This script is made in other to copy and replace your built 
    kernel to the installed kernel (by Pi-Imager) on. During 
    the intallation, Anytime you want to stop the script, just 
    spam <ctrl+z>.
"

mnt_tree="
    linux
    ├──── mnt
    │     ├─ boot
    │     └─ root
    └──── ...
"