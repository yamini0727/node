#!/bin/bash
set -x
echo "** (samplenodejs)-api-prod process status **" >> /tmp/(samplenodejs)-api-prod_deploy_logs
runuser -l ubuntu -c 'sudo pm2 status' | grep -wo nodejs
if [  $? -ne 0 ];
then
   echo "############################## pm2 not running #################################" >> /tmp/(samplenodejs)-api-prod_deploy_logs
else
   echo "############################## pm2 already running Deleting ####################" >> /tmp/(samplenodejs)-api-prod_deploy_logs
    runuser -l ubuntu -c 'sudo pm2 delete nodejs'
fi

rm -rf /home/ubuntu/(samplenodejs)

if [ ! -d /home/ubuntu/(samplenodejs) ]; then
runuser -l ubuntu -c 'mkdir -p /home/ubuntu/(samplenodejs)' >> /tmp/(samplenodejs)-prod_deploy_logs
fi
