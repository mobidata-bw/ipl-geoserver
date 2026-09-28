#!/bin/bash

set -euo pipefail

# copy template config dir to the path expected by startup.sh/Geoserver
if [ -n "${GEOSERVER_DATA_TEMPLATE_DIR:-}" ]; then
	# mkdir -p "$GEOSERVER_DATA_DIR"
	echo "copying $GEOSERVER_DATA_TEMPLATE_DIR to $GEOSERVER_DATA_DIR"
	cp -r -a "${GEOSERVER_DATA_TEMPLATE_DIR%/}/." "$GEOSERVER_DATA_DIR"
fi

exec /opt/startup.sh "$@"
