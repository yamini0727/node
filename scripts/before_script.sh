#!/bin/bash
set -x
echo "** (sample-nodejs)-api-prod process status **" >> /tmp/(sample-nodejs)-api-prod_deploy_logs
runuser -l ubuntu -c 'sudo pm2 status' | grep -wo nodejs
if [  $? -ne 0 ];
then
   echo "############################## pm2 not running #################################" >> /tmp/(sample-nodejs)-api-prod_deploy_logs
else
   echo "############################## pm2 already running Deleting ####################" >> /tmp/(sample-nodejs)-api-prod_deploy_logs
    runuser -l ubuntu -c 'sudo pm2 delete nodejs'
fi

rm -rf /home/ubuntu/(sample-nodejs)

if [ ! -d /home/ubuntu/(sample-nodejs) ]; then
runuser -l ubuntu -c 'mkdir -p /home/ubuntu/(sample-nodejs)' >> /tmp/(sample-nodejs)-prod_deploy_logs
fi
