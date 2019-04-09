FROM keymetrics/pm2:8-alpine

RUN npm install -g pm2
RUN npm install -g esm
RUN apk update && apk add logrotate
RUN apk add --no-cache curl
RUN apk add gettext jq

 RUN   apk update \                                                                                                                                                                                                                        
  &&   apk add ca-certificates wget \                                                                                                                                                                                                      
  &&   update-ca-certificates    

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
RUN chmod +x /usr/local/bin/dumb-init

RUN apk add --update-cache curl bash libc6-compat && \
    rm -rf /var/cache/apk/*
    
RUN apk add --update supervisor && rm  -rf /tmp/* /var/cache/apk/*
ADD supervisord.conf /etc

ADD / filebeat    
ADD filebeat/filebeat /usr/bin
RUN rm -f filebeat/filebeat.yml

RUN echo "*/5 *	* * *	/usr/sbin/logrotate -fv /etc/logrotate.d/app" >> /etc/crontabs/root

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

ADD .npmrc package.json package-lock.json /app/
WORKDIR /app
RUN npm install

ADD filebeat.yml /filebeat/

COPY config/logrotate.d/app /etc/logrotate.d/

ADD . /app/

RUN ./parse-package-json.sh

RUN ln -s /logs/ /app/logs

HEALTHCHECK --interval=30s --timeout=5s \
    CMD /app/healthcheck/health.sh

CMD mkdir -p /logs/ && pm2-runtime process.yml & supervisord --nodaemon --configuration /etc/supervisord.conf
