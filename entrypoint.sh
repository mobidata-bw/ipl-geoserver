#!/bin/bash

set -euo pipefail

# copy template config dir to the path expected by startup.sh/Geoserver
if [ -n "${GEOSERVER_DATA_TEMPLATE_DIR:-}" ]; then
	echo "mirroring $GEOSERVER_DATA_TEMPLATE_DIR/* to $GEOSERVER_DATA_DIR/"
	# We cannot mirror the entire template directory to the target directory (via `rsync -r -aE --del "${GEOSERVER_DATA_TEMPLATE_DIR%/}" "${GEOSERVER_DATA_DIR%/}"` because,
	# - we want to delete files not present (anymore) in the template directory, allowing for seamless upgrades, e.g. with a renamed layer's directory;
	# - running `--del` on $GEOSERVER_DATA_DIR does not work if we have other files/directories in there that can't (and shouldn't be) deleted, e.g. `datadir/logs` mounted from the host.
	# This is why we mirror the template directory's *child items* separately, to avoid collisions between `--del` and existing undeletable files in $GEOSERVER_DATA_DIR.
	rsync -r -aE --del \
		"${GEOSERVER_DATA_TEMPLATE_DIR%/}"/* "${GEOSERVER_DATA_TEMPLATE_DIR%/}"/.* "${GEOSERVER_DATA_DIR%/}/"
	echo "mirroring done!"
fi

exec /opt/startup.sh "$@"
