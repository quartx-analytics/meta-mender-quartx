### Manifest files

The google repo tool and associated manifest files are used for managing the
list of repositories needed for these builds.


### Templates and configuration fragments
1. Download the source:
```shell
$ mkdir yocto-quartx && cd yocto-quartx
$ repo init \
       -u https://github.com/quartx-analytics/meta-quartx.git \
       -m manifests/raspberrypi4/scripts/manifest-raspberrypi.xml
$ repo sync
```

2. Setup environment:
```shell
$ source setup-environment calllogger
```

3. Build:
```shell
$ bitbake core-image-base
```
