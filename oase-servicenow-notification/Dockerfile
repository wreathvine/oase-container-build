ARG OASE_VERSION

FROM exastro/oase-backyard:${OASE_VERSION}

CMD ["/bin/sh", "-c", "while true; do python3 /exastro/OASE/oase-root/backyards/servicenow_notification/ServiceNow_notification.py; sleep ${INTERVAL_TIME_SNOW_NOT:-10}; done"]