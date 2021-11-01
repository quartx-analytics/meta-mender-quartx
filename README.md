# Meta-Quartx
This repo contains Yocto Project meta layers for building and configuring an Embedded OS.
This os is built to be as minimal as possible with full support for docker on the Raspberry Pi 3/4.

## Preparing build env
Before we can do any building we need a powerful machine with at least 4 cores and lots of disk space,
about 50GB should be enough. A minimum of 4GB of ram is also required.

The Google repo tool and associated manifest files are used for managing the
list of repositories needed for these builds.

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
