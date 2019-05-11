# from https://github.com/jboss-dockerfiles/keycloak/blob/master/server/Dockerfile
FROM jboss/wildfly:10.1.0.Final

ENV LOGSTASH_GELF_VERSION=1.13.0

USER root

ADD bin /opt/jboss/wildfly/bin/
ADD customization /opt/jboss/wildfly/customization/
ADD modules /opt/jboss/wildfly/modules/
RUN cd $HOME \
    && curl http://central.maven.org/maven2/biz/paluch/logging/logstash-gelf/$LOGSTASH_GELF_VERSION/logstash-gelf-$LOGSTASH_GELF_VERSION-logging-module.zip -O \
    && unzip logstash-gelf-$LOGSTASH_GELF_VERSION-logging-module.zip \
    && mv logstash-gelf-$LOGSTASH_GELF_VERSION/biz $JBOSS_HOME/modules/biz \
    && rmdir logstash-gelf-$LOGSTASH_GELF_VERSION \
    && rm logstash-gelf-$LOGSTASH_GELF_VERSION-logging-module.zip \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && cd $JBOSS_HOME

USER jboss

RUN /opt/jboss/wildfly/customization/execute.sh standalone /opt/jboss/wildfly/customization/commands.cli

RUN curl -L https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war -o /opt/jboss/wildfly/standalone/deployments/sample.war

CMD ["/opt/jboss/wildfly/bin/start.sh", "-b", "0.0.0.0"]