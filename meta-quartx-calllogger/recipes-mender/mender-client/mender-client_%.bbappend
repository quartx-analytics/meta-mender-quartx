FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " \
    git://github.com/quartx-analytics/mender-docker-compose.git;protocol=https;branch=main;destsuffix=dc_module;rev=3bab3187d20090d1a1b9b1c52431b08d4eae7b57 \
"

# Add docker-compose module path to included files
FILES_${PN} += "${datadir}/mender/modules/v3/docker-compose"

# Upload module depends on "jq"
RDEPENDS_${PN} += "jq docker-ce docker-compose"

do_install_append() {
    # Install calllogger inventory
    install -d ${D}/${datadir}/mender/inventory
    install -m 755 ${WORKDIR}/mender-inventory-iot-type ${D}/${datadir}/mender/inventory/mender-inventory-iot-type

    # Install docker update module
    install -d ${D}/${datadir}/mender/modules/v3
    install -m 755 ${WORKDIR}/dc_module/docker-compose ${D}/${datadir}/mender/modules/v3/docker-compose
}
