FROM devsrv:5000/web/uveye-node:v0.6.0-3

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
