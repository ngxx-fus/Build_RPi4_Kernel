## Build RPi4 Kernel
### Information
| | |
| :----: | :----: |
| Author     | Nguyen Thanh Phu|
| Hardware   | Raspberry Pi 4 |
| Reference  | [RPi Doc](https://www.raspberrypi.com/documentation/computers/linux_kernel.html) |

### User-guide
| Step | - |
| :----: | :------------------- |
| 1 | Clone this **repo**. |
| 2 | Jump in to the **dir** has cloned below. ``` cd BUILD_RPI4_KERNEL  ``` | 
| 3 | Change mode for **build.sh** by running ``` sudo chmod +x build.sh ``` |
| 4 | Run the build script, follow instructions of **buid.sh**.  ``` ./build.sh ``` |
| 5 | Insert your SDcard (installed a Raspberry Pi OS) |
| 6 | Change mode for **install.sh** by running ``` sudo chmod +x install.sh ``` |
| 7 | Run the install script, follow instructions of **install.sh**.  ``` ./install.sh ``` |
| 8 | Eject your SDcard, then put into Raspberry Pi 4, then power-up! (and test :v) |

### Config the script
All config variables is stored in **resources** folder!<br>
Config table:
| Variable   | Location (./)| Default value | Descriptions |
| :----: | :------------------------------ | :----: | :---- |
| CORES  | Cores.sh | 12 | #cores is used for run **make**, x1.5 times #cores you have. (check it by run ```nproc```) |
|    BRANCH    |  Branch.sh     |  rpi-6.6.y     |  Kernel version (check it at [linux]( https://github.com/raspberrypi/linux) and [RPi Doc](https://www.raspberrypi.com/documentation/computers/linux_kernel.html))      | 
|  boot_dev      |  Installation_Vars.sh     |  mmcblk0p1     |  Address (in host device, /dev/*) of boot partition in your SDcard (USB)     | 
|  root_dev      |  Installation_Vars.sh     |  mmcblk0p2     |  Address (in host device, /dev/* ) of boot partition in your SDcard (USB)     | 
|  kernel_dir    |  Installation_Vars.sh     | ./linux      |  Link to the folder which is your linux kernel       | 
|  KERNEL        |  Installation_Vars.sh    |  kernel8     |  Image file (for backup current kernel in your SDcard), check it by find kernel*.img in boot partition in your SDcard.      | 

Note:<br>
| Symbol   | Equivalent to |
| :----: | :----: |
| #      | A number of |
| .      | .../resources/ |
| ./Cores.sh | .../resources/Cores.sh |


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
        ├──── install.sh     (Install kernel script)
        └──── Terminal.log   (Output of terminal)

### Screenshots

This kernel has been built and copy by run the script.
![image](https://github.com/user-attachments/assets/fba70115-fe91-4030-a1a6-4add96d6f5c7)
