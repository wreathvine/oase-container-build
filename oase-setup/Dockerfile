ARG OASE_VERSION

FROM exastro/oase-backyard:${OASE_VERSION}

# Add setup files
COPY --chown=oase:oase ./files/docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=oase:oase ./files/create_initial_record.py /exastro/OASE/oase-root/web_app/management/commands/
COPY --chown=oase:oase ./files/init_custom.yaml /exastro/OASE/oase-root/web_app/fixtures/
COPY --chown=oase:oase ./files/__init__.py /exastro/OASE/oase-root/web_app/models/

RUN chmod a+x /docker-entrypoint.sh

USER 49152
ENTRYPOINT ["/docker-entrypoint.sh"]
