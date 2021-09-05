FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " \
    file://artifact-verify-key.pem \
"

# Better defaults for storage size
# MENDER_STORAGE_TOTAL_SIZE_MB = "2048"
# MENDER_BOOT_PART_SIZE_MB = "40"
# MENDER_DATA_PART_SIZE_MB = "128"

# Add default upload modules
PACKAGECONFIG_append = " modules"

# Mender polling intervals
MENDER_UPDATE_POLL_INTERVAL_SECONDS = "60"
