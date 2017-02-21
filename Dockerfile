FROM orientdb:2.2.16

LABEL maintainer "Aquabiota Solutions AB <mapcloud@aquabiota.se>"

ENV ORIENTDB_DOWNLOAD_SPATIAL_MD5 41a5b88b6bcea73e6037732ed6977c39
ENV ORIENTDB_DOWNLOAD_SPATIAL_SHA1 937ed8c4990bd1ac27534449a8517a3ac7999a80

ENV ORIENTDB_DOWNLOAD_SPATIAL_URL ${ORIENTDB_DOWNLOAD_SERVER:-http://central.maven.org/maven2/com/orientechnologies}/orientdb-spatial/$ORIENTDB_VERSION/orientdb-spatial-$ORIENTDB_VERSION-dist.jar

RUN wget $ORIENTDB_DOWNLOAD_SPATIAL_URL \
    && echo "$ORIENTDB_DOWNLOAD_SPATIAL_MD5 *orientdb-spatial-$ORIENTDB_VERSION-dist.jar" | md5sum -c - \
    && echo "$ORIENTDB_DOWNLOAD_SPATIAL_SHA1 *orientdb-spatial-$ORIENTDB_VERSION-dist.jar" | sha1sum -c - \
    && mv orientdb-spatial-*-dist.jar /orientdb/lib/

EXPOSE 2424
EXPOSE 2480

WORKDIR /orientdb
VOLUME ["/orientdb/config","/orientdb/databases"]
ENTRYPOINT ["/orientdb/bin/server.sh"]

CMD ["-Ddistributed=true"]
