FROM geosolutionsit/geoserver:2.27.1@sha256:b137aaf5c00a9e8d7758027425917dba6dde72ea64352afaf44b20fff7e291ab

LABEL org.opencontainers.image.title="Geoserver"
LABEL org.opencontainers.image.description="Geoserver, customized with additional plugins for the MobiData BW IPL"
LABEL org.opencontainers.image.authors="MobiData BW IPL contributors <mobidata-bw@nvbw.de>"
LABEL org.opencontainers.image.source="https://github.com/mobidata-bw/ipl-geoserver"

# We currently depend on our custom fixed download script.
# todo: use the upstream one again once https://github.com/geosolutions-it/docker-geoserver/pull/169 is merged
COPY geoserver-plugin-download.sh /usr/local/bin/geoserver-plugin-download.sh

# The upstream Docker image build process is so involved that, instead of using their built-in plugin mechanism while building the "original" image [0], we rather copy the instructions here. Other than us doing this *after* the original image has been built, we strive to follow the upstream design as closely as possible.
# [0] https://github.com/geosolutions-it/docker-geoserver/blob/fb6a5197b19c60cf9a4b83b440281e2110a021a0/Dockerfile#L46-L50
ARG PLUG_IN_URLS='https://sourceforge.net/projects/geoserver/files/GeoServer/2.27.1/extensions/geoserver-2.27.1-vectortiles-plugin.zip https://sourceforge.net/projects/geoserver/files/GeoServer/2.27.1/extensions/geoserver-2.27.1-inspire-plugin.zip'
RUN /usr/local/bin/geoserver-plugin-download.sh "${CATALINA_BASE}/webapps/geoserver/WEB-INF/lib" ${PLUG_IN_URLS}
