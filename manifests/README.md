### Manifest files

The google repo tool and associated manifest files are used for managing the
list of repositories needed for these builds.


### Templates and configuration fragments
1. Download the source:
```
    $ mkdir mender-<vendor/soc name>
    $ cd mender-<vendor/soc name>
    $ repo init \
           -u https://github.com/mendersoftware/meta-mender-community \
           -m meta-mender-<vendor/soc name>/scripts/manifest-<vendor/soc name>.xml \
           -b dunfell
    $ repo sync
```

2. Setup environment:
```
    $ . ./setup-environment <vendor/soc name>
```

3. Build:
```
    $ bitbake core-image-base
```

The `setup-environment` script provided is a wrapper for the Yocto `oe-init-build-env` script.
