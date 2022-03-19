ARG OASE_VERSION

FROM exastro/oase-backyard:${OASE_VERSION}

CMD ["/bin/sh", "-c", "while true; do python3 /exastro/OASE/oase-root/backyards/agent_driver/oase_agent.py; sleep ${INTERVAL_TIME_AGENT:-10}; done"]
