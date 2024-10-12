## Build RPi4 Kernel
### Information
| | |
| :----: | :----: |
| Author     | Nguyen Thanh Phu|
| Hardware   | Raspberry Pi 4 |
| Reference  | [RPi Doc](https://www.raspberrypi.com/documentation/computers/linux_kernel.html) |

### User-guide
| Step | - |
| :----: | :---- |
| 1 | Clone this **repo**. |
| 2 | Jump in to the **dir** has cloned below. ``` cd BUILD_RPI4_KERNEL  ``` | 
| 3 | Change mode for **build.sh** by running ``` sudo chmod +x build.sh ``` |
| 4 | Run the build script, follow instructions of **buid.sh**.  ``` ./build.sh ``` |
| 5 | Insert your SDcard (installed a Raspberry Pi OS) |
| 6 | Change mode for **install.sh** by running ``` sudo chmod +x install.sh ``` |
| 7 | Run the install script, follow instructions of **install.sh**.  ``` ./install.sh ``` |
| 8 | Eject your SDcard, then put into Raspberry Pi 4, then power-up! (and test :v) |

### Working-tree

        build_rpi4_kernel
        ├──── linux         (kernel directory)
        │     ├──── mnt     (SDcard mount directory)
        │     │     ├─ boot
        │     │     └─ root
        │     └──── ...
        ├──── resources
        │     ├──── Announcement.sh
        │     ├──── Branch.sh
        │     ├──── Cores.sh
        │     ├──── Installation_Vars.sh
        │     ├──── Support_Functions.sh
        │     └──── Text_Effects.sh
        ├──── test
        │     └──── ...      (modules test directory)
        ├──── build.sh       (Build kernel script)
        └──── install.sh     (Install kernel script)