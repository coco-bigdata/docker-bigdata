#!/bin/sh
#Actively load user env

if [ -f "~/.bashrc" ];then
  echo "Warning! user bashrc file does not exist."
else
  source ~/.bashrc
fi

shellDir=`dirname $0`
export LINKIS_DSS_HOME=`cd ${shellDir}/..;pwd`

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
echo "###################### Begin to stop Linkis ############################"
echo "########################################################################"
sh ${LINKIS_DSS_HOME}/linkis/sbin/linkis-stop-all.sh
isSuccess "stop Linkis"


echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to stop DSS Service #####################"
echo "########################################################################"
sh ${LINKIS_DSS_HOME}/dss/sbin/dss-stop-all.sh
echo ""

echo ""
echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to stop DSS Web #######################"
echo "########################################################################"
function stopDssWeb(){
version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
# centos 6
if [[ $version -eq 6 ]]; then
    sudo /etc/init.d/nginx stop
    isSuccess "stop DSS Web"
fi

# centos 7
if [[ $version -eq 7 ]]; then
    sudo systemctl stop nginx
    isSuccess "stop DSS Web"
fi
}
stopDssWeb