#!/bin/bash
##############################################################################
# COPYRIGHT Ericsson 2018
#
# The copyright to the computer program(s) herein is the property of
# Ericsson Inc. The programs may be used and/or copied only with written
# permission from Ericsson Inc. or in accordance with the terms and
# conditions stipulated in the agreement/contract under which the
# program(s) have been supplied.
##############################################################################
#This script is to check the health status of Openstack deployments

echo "Starting to check the Health Stack for all customers"

HOME_SCRIPT='/home/stack_health_check_local'
CLIENTS=$(cat $HOME_SCRIPT/map_clients.txt)

for i in $CLIENTS; do
	echo "Starting Customer: " `echo $i | cut -d: -f3`
	CLIENT_HOME=$(echo $i | cut -d: -f1)
	source /home/$CLIENT_HOME/rc/keystone.sh
	echo "Openstack key loaded (keystone.sh)"
	CLIENT_ID=$(echo $i | cut -d: -f2)
	cd $HOME_SCRIPT; ./stack-health-monitor.py $CLIENT_ID --no-update-inputs
done

 

