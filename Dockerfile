FROM openjdk:11-bullseye

LABEL maintainer="raimangsxr <raimangsxr@hotmail.com>" version="9.11.2"

ARG JIRA_VERSION=9.11.2
# Production: jira-software jira-core
ARG JIRA_PRODUCT=jira-software

ENV JIRA_USER=apps \
    JIRA_GROUP=apps \
    JIRA_HOME=/var/jira \
    JIRA_INSTALL=/opt/jira \
    JVM_MINIMUM_MEMORY=1g \
    JVM_MAXIMUM_MEMORY=3g \
    JVM_CODE_CACHE_ARGS='-XX:InitialCodeCacheSize=1g -XX:ReservedCodeCacheSize=2g' \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar

ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"

RUN mkdir -p ${JIRA_INSTALL} ${JIRA_HOME} ${AGENT_PATH}
RUN curl -k -o ${AGENT_PATH}/${AGENT_FILENAME} https://github.com/raimangsxr/jira/releases/download/1.0/atlassian-agent.jar -L
RUN curl -k -o /tmp/atlassian.tar.gz https://product-downloads.atlassian.com/software/jira/downloads/atlassian-${JIRA_PRODUCT}-${JIRA_VERSION}.tar.gz -L
RUN tar xzf /tmp/atlassian.tar.gz -C ${JIRA_INSTALL}/ --strip-components 1
RUN rm -f /tmp/atlassian.tar.gz
RUN curl -k -o ${JIRA_INSTALL}/conf/server.xml https://github.com/raimangsxr/jira/releases/download/1.0/server.xml -L
RUN echo "jira.home = ${JIRA_HOME}" > ${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties

RUN export CONTAINER_USER=$JIRA_USER
RUN export CONTAINER_GROUP=$JIRA_GROUP
RUN groupadd -r -g 568 $JIRA_GROUP && useradd -r -g $JIRA_GROUP -u 568 $JIRA_USER
RUN chown -R $JIRA_USER:$JIRA_GROUP ${JIRA_INSTALL} ${JIRA_HOME}/ ${AGENT_PATH}

VOLUME $JIRA_HOME
USER $JIRA_USER
WORKDIR $JIRA_INSTALL
EXPOSE 8080

RUN ls -lisah /var/agent
ENTRYPOINT ["/opt/jira/bin/start-jira.sh", "-fg"]
