# Meta-Quartx
This repo contains Yocto Project meta layers for building and configuring an Embedded OS.
This os is built to be as minimal as possible with full support for docker on the Raspberry Pi 3/4.


## Requirements
The Google repo tool and associated manifest files are used for managing the
list of repositories needed for these builds.

[Repo tool](https://gerrit.googlesource.com/git-repo/)

The Yocto project is made up of lots of smaller dependencies.

Arch Linux is not one of the supported distributions but still works, just might have a few unexpected issues.
You might also need to enable the multilib repository to install `multilib-devel`.
```shell
pacman -S git diffstat unzip texinfo python chrpath wget xterm sdl rpcsvc-proto socat cpio inetutils multilib-devel
```

Ubuntu is the recommended distribution for the Yocto project.
```shell
sudo apt install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm
```


## Preparing build env
Before we can do any building we need a powerful machine with at least 4 cores and lots of disk space,
about 50GB should be enough. A minimum of 4GB of ram is also required.

1. Download the source:
This will download the yocto layers that we depend on for the OS.
When running the repo tool you need to specify the path to the system you are building for.
Here we are building for the ``raspberrypi4``.
```shell
$ mkdir -p ~/yocto/{pi3-calllogger,pi4-calllogger} && cd ~/yocto/pi4-calllogger
$ repo init -u https://github.com/quartx-analytics/meta-quartx.git -m manifests/raspberrypi4/scripts/manifest-raspberrypi.xml
$ repo sync
```

2. Setup environment:
Here we must specify the app that the OS is being built for. This adds the correct layers to build the OS with.
It will ask some questions first to set up the yocto build properly. This command will also move you into the build directory.
```shell
$ source setup-environment calllogger
```

3. Build:
This part will take a while to complete, about 4 hours on a standard computer.
```shell
$ bitbake core-image-base
```


## Deployment
After bitbake finishes, it will put the build images to the Yocto project tmp folder.
There is 2 files that we need from the tmp folder.
```shell
$ ~/yocto/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi3.mender
$ ~/yocto/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi3.sdimg      # Uncompressed
$ ~/yocto/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi3.sdimg.bz2  # Compressed
```
