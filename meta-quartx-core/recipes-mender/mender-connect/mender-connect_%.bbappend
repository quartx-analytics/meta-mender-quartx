# Bash is a better shell to work with
RDEPENDS_${PN}_append = " bash"

# These will be added to mender-connect.conf
MENDER_CONNECT_USER = "root"
MENDER_CONNECT_SHELL = "/bin/bash"
