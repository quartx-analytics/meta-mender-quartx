FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " file://mender-inventory-iot-type file://docker-compose file://artifact-verify-key.pem"

PACKAGECONFIG_append = " directory single-file script"
IMAGE_INSTALL_append = " mender-connect"

FILES_${PN} = "${datadir}/mender/modules/v3/docker-compose"

do_install_append() {
    install -d ${D}/${datadir}/mender/inventory
    install -d ${D}/${datadir}/mender/modules/v3
    install -m 755 ${WORKDIR}/mender-inventory-iot-type ${D}/${datadir}/mender/inventory/mender-inventory-iot-type
    install -m 755 ${WORKDIR}/docker-compose ${D}/${datadir}/mender/modules/v3/docker-compose
}
