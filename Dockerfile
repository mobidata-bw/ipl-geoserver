FROM geosolutionsit/geoserver:2.25.3@sha256:9576daef7a2813a2636a3ac82291af64eeb13ab4b9a886da7bade14371f16d61

LABEL org.opencontainers.image.title="Geoserver"
LABEL org.opencontainers.image.description="Geoserver, customized with additional plugins for the MobiData BW IPL"
LABEL org.opencontainers.image.authors="MobiData BW IPL contributors <mobidata-bw@nvbw.de>"
LABEL org.opencontainers.image.source="https://github.com/mobidata-bw/ipl-geoserver"

# The upstream Docker image build process is so involved that, instead of using their built-in plugin mechanism while building the "original" image [0], we rather copy the instructions here. Other than us doing this *after* the original image has been built, we strive to follow the upstream design as closely as possible.
# [0] https://github.com/geosolutions-it/docker-geoserver/blob/fb6a5197b19c60cf9a4b83b440281e2110a021a0/Dockerfile#L46-L50
ARG PLUG_IN_URLS=""
ARG PLUG_IN_PATHS=""
RUN /usr/local/bin/geoserver-plugin-download.sh "${CATALINA_BASE}/webapps/geoserver/WEB-INF/lib" ${PLUG_IN_URLS}
