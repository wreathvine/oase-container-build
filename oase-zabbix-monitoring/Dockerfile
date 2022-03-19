ARG OASE_VERSION

FROM exastro/oase-backyard:${OASE_VERSION}

CMD ["/bin/sh", "-c", "while true; do python3 /exastro/OASE/oase-root/backyards/monitoring_adapter/ZABBIX_monitoring.py; sleep ${INTERVAL_TIME_ZBX_MON:-10}; done"]