FROM docker.osgeo.org/geoserver:2.28.5

LABEL org.opencontainers.image.title="Geoserver"
LABEL org.opencontainers.image.description="Geoserver, customized with additional plugins for the MobiData BW IPL"
LABEL org.opencontainers.image.authors="MobiData BW IPL contributors <mobidata-bw@nvbw.de>"
LABEL org.opencontainers.image.source="https://github.com/mobidata-bw/ipl-geoserver"

# https://github.com/geoserver/docker/blob/68a2144f863cba741de05fb6ed58738a7ddc0e77/README.md#how-to-start-a-geoserver-without-sample-data
ENV SKIP_DEMO_DATA=true

# https://github.com/geoserver/docker/blob/68a2144f863cba741de05fb6ed58738a7ddc0e77/README.md#how-to-download-and-install-additional-extensions-on-startup
ARG STABLE_EXTENSIONS='vectortiles,inspire,ogcapi-features'
ENV STABLE_EXTENSIONS=${STABLE_EXTENSIONS}

# todo: remove debugging commands
RUN sed -i -e "2i set -x" /opt/install-extensions.sh
RUN sed -i -e "2i env | sort" /opt/install-extensions.sh

# We don't want to run the container with `INSTALL_EXTENSIONS=true`.
# todo: /opt/install-extensions.sh doesn't download them, but still unpacks them *again* during runtime
ENV INSTALL_EXTENSIONS=false
RUN env INSTALL_EXTENSIONS=true /opt/install-extensions.sh

# todo: remove debugging commands
RUN ls -alh /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/

# todo: remove debugging commands
RUN sed -i -e "2i id" /opt/startup.sh
RUN sed -i -e "2i set -x" /opt/startup.sh
RUN sed -i -e "2i set -x" /usr/local/tomcat/bin/catalina.sh
