FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " \
    https://raw.githubusercontent.com/quartx-analytics/mender-docker-compose/main/docker-compose \
"
SRC_URI[sha256sum] = "0f4bb2c5837e1d37ce154a3e4fd8798948d5aff1e7dbcc351877daf644456083"

# Add docker-compose module path to included files
FILES_${PN} += "${datadir}/mender/modules/v3/docker-compose"

# Upload module depends on "jq"
RDEPENDS_${PN} += "jq"

do_install_append() {
    # Install calllogger inventory
    install -d ${D}/${datadir}/mender/inventory
    install -m 755 ${WORKDIR}/mender-inventory-iot-type ${D}/${datadir}/mender/inventory/mender-inventory-iot-type

    # Install docker update module
    install -d ${D}/${datadir}/mender/modules/v3
    install -m 755 ${WORKDIR}/docker-compose ${D}/${datadir}/mender/modules/v3/docker-compose
}
