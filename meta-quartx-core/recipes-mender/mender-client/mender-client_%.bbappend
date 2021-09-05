FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " \
    file://artifact-verify-key.pem \
"

# Add standard upload modules
PACKAGECONFIG_append = " modules"

# Mender polling intervals
MENDER_UPDATE_POLL_INTERVAL_SECONDS = "60"
