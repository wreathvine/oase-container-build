FROM jboss/business-central-workbench:7.59.0.Final

USER root

ADD ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chown jboss:jboss /docker-entrypoint.sh && \
    chmod a+x /docker-entrypoint.sh

USER jboss

CMD ["./start_business-central-wb.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]