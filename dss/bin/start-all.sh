#!/bin/sh
#Actively load user env

#source ~/.bash_profile

if [ -f "~/.bashrc" ];then
  echo "Warning! user bashrc file does not exist."
else
  source ~/.bashrc
fi

shellDir=`dirname $0`
LINKIS_DSS_HOME=`cd ${shellDir}/..;pwd`

function isSuccess(){
if [ $? -ne 0 ]; then
    echo "Failed to " + $1
    exit 1
else
    echo "Succeed to" + $1
fi
}

source ${LINKIS_DSS_HOME}/conf/config.sh
source ${LINKIS_DSS_HOME}/conf/db.sh

echo "########################################################################"
echo "###################### Begin to start Linkis #####################"
echo "########################################################################"
sh ${LINKIS_DSS_HOME}/linkis/sbin/linkis-start-all.sh
isSuccess "start Linkis"

echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start DSS Service #####################"
echo "########################################################################"
sh ${LINKIS_DSS_HOME}/dss/sbin/dss-start-all.sh
echo ""

echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start DSS web #######################"
echo "########################################################################"

function startDssWeb(){
version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
# centos 6
if [[ $version -eq 6 ]]; then
    sudo /etc/init.d/nginx start
    isSuccess "start DSS Web"
fi

# centos 7
if [[ $version -eq 7 ]]; then
    sudo systemctl start nginx
    isSuccess "start DSS Web"
fi
echo "You can acess DSS Web by http://${DSS_NGINX_IP}:${DSS_WEB_PORT}"
}
startDssWeb