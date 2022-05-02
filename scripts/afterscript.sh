#!/bin/bash
set -x
chown -R ubuntu:ubuntu /home/ubuntu/(sample-nodejs)/
echo  "***Installing npm package ***" >> /tmp/samplenode-api-prod_deploy_logs
echo >> /tmp/(sample-nodejs)-api-prod_deploys_logs
runuser -l ubuntu -c 'cd /home/ubuntu/(sample-nodejs) && npm install'
runuser -l ubuntu -c 'cd /home/ubuntu/(sample-nodejs) && npm install --unsafe-perm'
runuser -l ubuntu -c 'cd /home/ubuntu/(sample-nodejs) && npm run build'
sleep 10
echo "***starting (pm2 process name)-backend-admin-api-prod application ***" >> /tmp/(sample-nodejs)-api-prod_deploy_logs
runuser -l ubuntu -c 'cd /home/ubuntu/(sample-nodejs) && sudo pm2 start dist/src/server.js --name (pm2 process name)  --silent' >> /tmp/getty-backend-api-prod_deploy_logs
s1=`pm2 status | grep -we (pm2 process name) | awk '{print $12}'`
sleep 5
s2=`pm2 status | grep -we (pm2 process name) | awk '{print $12}'`
if [ $s1 == $s2 ]
then
echo "BUILD SUCCESSFUL" >> /tmp/(sample-nodejs)-api-prod_deploy_logs
echo >> /tmp/(sample-nodejs)-api-prod_deploy_logs
else
echo "Node process is restarting" >> /tmp/(sample-nodejs)-api-prod_deploy_logs
echo >> /tmp/(sample-nodejs)-api-prod_deploy_logs
fi
