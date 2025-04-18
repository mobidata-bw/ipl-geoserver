#!/usr/bin/env bash

# Note: This is a (temporary) fixed version of the upstream geoserver-plugin-download.sh as submitted in https://github.com/geosolutions-it/docker-geoserver/pull/169.

set -e
set -u

[ "$#" -le "1" ] && ( echo "no plugin urls passed, exiting" ) && exit 0

PLUGIN_INSTALL_PATH=$1

for url in "${@:2}"
do
    # support specifying SourceForge URLs without the `/download` part at the end necessary for downloading
    if [[ "$url" == *sourceforge* ]]; then
        url="$url/download"
    fi

    wget \
        --no-verbose \
        -U 'geosolutionsit/geoserver Docker image build' \
        -O ./download "$url"
    unzip -o ./download -d "${PLUGIN_INSTALL_PATH}"
    rm ./download
done
