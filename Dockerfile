FROM ahri/nodejs:0.12.2-r0

ENV KIBANA_VERSION 4.2.0

RUN su -s /bin/sh -c "cd /tmp && wget -O - http://download.elastic.co/kibana/kibana/kibana-$KIBANA_VERSION-linux-x64.tar.gz | tar xz" daemon && \
        mv /tmp/kibana-$KIBANA_VERSION-linux-x64 /kibana && \
        rm -rf /kibana/node && \
        find /kibana \( -type d -or \( -type f -and -perm +1 \) \) -exec chmod 755 {} \; && \
        find /kibana \( -type f -and -not -perm +1 \) -exec chmod 644 {} \;

EXPOSE 5601

USER nobody
ENV HOME /tmp
ENTRYPOINT ["/kibana/bin/kibana"]
CMD ["--elasticsearch", "http://elasticsearch"]
