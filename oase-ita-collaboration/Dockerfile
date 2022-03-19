ARG OASE_VERSION

FROM exastro/oase-backyard:${OASE_VERSION}

CMD ["/bin/sh", "-c", "while true; do python3 /exastro/OASE/oase-root/backyards/exastro_collaboration/exastro_ITA_collaboration.py; sleep ${INTERVAL_TIME_ITA_COL:-10}; done"]