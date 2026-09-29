# IPL [GeoServer](https://geoserver.org) Docker image

This repo contains a Dockerfile to build a **custom [`geoserver/docker` Docker image](https://repo.osgeo.org/#browse/browse:geoserver-docker:v2%2Fgeoserver%2Ftags)** that includes [plugins/extensions](https://docs.geoserver.org/stable/en/user/extensions/index.html#extensions) which we need for the [*MobiData BW* *Intergrationsplattform* (IPL)](https://github.com/mobidata-bw/ipl-orchestration).

In addition to the upstream image, a custom var `GEOSERVER_DATA_TEMPLATE_DIR` can be provided. The directory specified by this var is copied before server startup to `GEOSERVER_DATA_DIR`. This way, version managed configuration files can be prevented from being changed by geoserver.