# About

This repository is a fork of the KoboLabs e-reader that provides a build
environment and a USB Host kernel for running XCSoar on a Kobo Mini.

# Caveats

This has only been tested on a Kobo Mini, but it will probably work on
other new kobo devices

At present you can't boot your device between e-Reader and XCSoar without 
reflashing the kernel.  This will be rectified with an 'auto-reflash' option
in the boot sequence

# Rebuilding 

## Kernel

Unfortunately the Kobo Kernel must be compiled with an older version of GCC (4.4) and XCSoar requires 4.6 or later.  To resolve this you will need to build chains - one for the XCSoar packages and one for the kernel.

### Setup

1. I used a new Ubuntu 12.04 Virtual Machine on my laptop

2. Install codesourcery GCC toolchain to /usr/arm-none-linux-gnueabi by untaring the downloaded archive into the /usr directory
> http://sources.buildroot.net/arm-2010q1-202-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

3. Changed the ownership of this directory to me (chown ...)

### Building

4. Change into the ./fw/imx507/linux-2.6.35.3-USBHOST directory

5. Run the make command
>make CROSS_COMPILE=arm-none-linux-gnueabi- ARCH=arm clean uImage

6. This will leave you a uImage file in arch/arm/boot/uImage

### Installing

7. To install to the boot SD card you have a few options
* dd if=arch/arm/boot/uImage of=/dev/[your memory card] bs=512 seek=2048
* copy to /mnt/onboard/.kobo/upgrade/uImage and touch /mnt/onboard/.kobo/KoboRoot.tgz then insert card and reboot kobo
* copy to SD card (XCSoar installed), or normal Kobo plugged into laptop in .kobo/upgrade/uImage touch .kobo/KoboRoot.tgz then reboot kobo

## Building XCSoar

This is a two part process - one is seting up the build environment, which can be done using this git repository.  The second is actually building XCSoar, which requires code from the XCSoar repository

### Setup

1. Use a new VM - it makes the buildchain easier as you can't have the same compilers on both...

2. Get a version of the CodeSourcery ARM GNU toolchain which contains 4.6 or later (I built using 4.7)
> http://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/request?id=478dff82-62bc-44b2-afe2-4684d83b19b9&downloadlite=scblite2012&fmpath=/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/form

[NOTE: You can build with a hardware float version of the compiler, which will probably work better, I will double check this and update as appropriate]

3. Install it into the /usr/arm-none-linux-gnueabi directory (will have ./bin etc)

4. Change ownership so you don't need to compile as root (as above)

5. Change into the <git>/packages directory

6. Run ../build/fetchxcsoarpackages.sh to download all the XCSoar specific packages

7. Install build tools that are needed
> sudo apt-get install  libfreetype6-dev imagemagick g++ librsvg2-bin

8. change into build directory

9. run buildsetup.sh, which will configure this and start a build.  

10.  Output for all the libraries will go into the /usr/arm-none-linux-gnueabi/[lib|include] directories

11. Clone the xcsoar repository somewhere

### Compiling XCSoar

12. Change into this directory and run make
> make TARGET=KOBO KOBO=/usr/arm-none-linux-gnueabi 

13. Output will be in output/KOBO/bin

