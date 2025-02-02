FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " \
    https://raw.githubusercontent.com/quartx-analytics/mender-docker-compose/main/docker-compose \
    file://mender-inventory-iot-type \
"
SRC_URI[sha256sum] = "99a806bfb8c208b7eb10cd44145808c32bf274702fa91d80787ad8dff57c4b22"

# Add docker-compose module path to included files
FILES_${PN} += "\
    ${datadir}/mender/modules/v3/docker-compose \
    /data/docker \
"

# Upload module depends on "jq"
RDEPENDS_${PN} += "jq docker-ce python3-docker-compose"

do_install_append() {
    # Install calllogger inventory
    install -d ${D}/${datadir}/mender/inventory
    install -m 755 ${WORKDIR}/mender-inventory-iot-type ${D}/${datadir}/mender/inventory/mender-inventory-iot-type

    # Install docker update module
    install -d ${D}/${datadir}/mender/modules/v3
    install -m 755 ${WORKDIR}/docker-compose ${D}/${datadir}/mender/modules/v3/docker-compose

    # Move docker data directory to persistent storage
    mkdir -p ${D}/data/docker
    ln -s /data/docker ${D}/var/lib/docker
}
