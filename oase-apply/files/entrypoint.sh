#!/bin/bash

source /etc/profile
export CLASSPATH=$JAVA_HOME/lib
export PATH=$PATH:/opt/apache-maven/bin:$JAVA_HOME/bin

cd /exastro/OASE/oase-root
python3 /exastro/OASE/oase-root/backyards/apply_driver/oase_apply.py

