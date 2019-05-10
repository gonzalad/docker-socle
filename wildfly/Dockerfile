# from https://github.com/jboss-dockerfiles/keycloak/blob/master/server/Dockerfile
FROM jboss/wildfly:10.1.0.Final

ADD customization /opt/jboss/wildfly/customization/
ADD modules /opt/jboss/wildfly/modules/

RUN /opt/jboss/wildfly/customization/execute.sh