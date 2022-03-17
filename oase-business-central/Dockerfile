FROM quay.io/kiegroup/business-central-workbench:7.63.0.Final

ENV KIE_SERVER_PROFILE standalone
ENV JAVA_OPTS -Xms256m -Xmx2048m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=512m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8

ADD ./files/etc/kie-fs-realm-users $JBOSS_HOME/standalone/configuration/kie-fs-realm-users
ADD ./files/etc/jbpm-custom.cli $JBOSS_HOME/bin/jbpm-custom.cli

USER root
RUN chown -R jboss:jboss $JBOSS_HOME/standalone/configuration/kie-fs-realm-users


USER jboss
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/jbpm-custom.cli && \
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current

WORKDIR $JBOSS_HOME/bin/
CMD ["./start_business-central-wb.sh"]
