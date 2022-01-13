#!/bin/sh
#Actively load user env
if [ -f "~/.bashrc" ];then
  echo "Warning! user bashrc file does not exist."
else
  source ~/.bashrc
fi

one_local_host="`hostname --fqdn`"

shellDir=`dirname $0`
LINKIS_DSS_HOME=`cd ${shellDir}/..;pwd`

# set default conf value
export deployUser=`whoami`

LINKIS_INSTALL_HOME=$LINKIS_DSS_HOME/linkis
DSS_INSTALL_HOME=$LINKIS_DSS_HOME/dss

function isSuccess() {
if [ $? -ne 0 ]; then
    echo "***********Error: failed to " + $1
    exit 1
else
    echo "Succeed to" + $1
fi
}

if test -e ${LINKIS_DSS_HOME}/conf; then
 dos2unix ${LINKIS_DSS_HOME}/conf/*.sh
fi
if test -e ${LINKIS_DSS_HOME}/bin; then
 dos2unix ${LINKIS_DSS_HOME}/bin/*.sh
fi


#chose install mode
echo "Welcome to DSS & Linkis Deployment Service!"
echo "Suitable for Linkis and DSS first installation, please be sure the environment is ready."

export DSS_WEB_HOME=${LINKIS_DSS_HOME}/web


#linkis file name
TMP_LINKIS_FILE_NAME=linkis-pre-install
TMP_LINKIS_FILE_PATH=${LINKIS_DSS_HOME}/${TMP_LINKIS_FILE_NAME}

#dss file name
TMP_DSS_FILE_NAME=dss-pre-install
TMP_DSS_FILE_PATH=${LINKIS_DSS_HOME}/${TMP_DSS_FILE_NAME}

source ${LINKIS_DSS_HOME}/conf/config.sh
source ${LINKIS_DSS_HOME}/conf/db.sh
source ${LINKIS_DSS_HOME}/bin/replace.sh

##DSS_FILE_NAME 这个参数是与dss的打包后的里面第一层的文件相同
DSS_FILE_NAME="dss-${DSS_VERSION}"


# valid config.sh parameter
function validConfig(){
if [ -z "$HADOOP_CONF_DIR" ]; then
 echo "Error! HADOOP_CONF_DIR is null."
 exit 1
fi
if [ -z "$HIVE_CONF_DIR" ]; then
  echo "Error! HIVE_CONF_DIR is null."
  exit 1
fi
if [ -z "$SPARK_CONF_DIR" ]; then
  echo "Error! SPARK_CONF_DIR is null."
  exit 1
fi
if [ -z "$ENGINECONN_ROOT_PATH" ]; then
  echo "Error! ENGINECONN_ROOT_PATH is null."
  exit 1
fi
if [ -z "$EXECUTION_LOG_PATH" ]; then
  echo "Error! EXECUTION_LOG_PATH is null."
  exit 1
fi
if [ -z "$ORCHESTRATOR_FILE_PATH" ]; then
  echo "Error! ORCHESTRATOR_FILE_PATH is null."
  exit 1
fi
}
validConfig

sh ${LINKIS_DSS_HOME}/bin/checkEnv.sh
isSuccess "check env"

#linkis deploy package
function linkisInstall(){
  #LINKIS_INSTALL_HOME
  # TMP_LINKIS_FILE_PATH 执行安装的目录需要删掉。
  if ! test -e ${TMP_LINKIS_FILE_PATH}; then
    sudo mkdir -p ${TMP_LINKIS_FILE_PATH};sudo chown -R $deployUser:$deployUser ${LINKIS_DSS_HOME};sudo chown -R $deployUser:$deployUser ${TMP_LINKIS_FILE_PATH}
    isSuccess "Create the dir of  ${LINKIS_DSS_HOME}/linkis"
  fi

  if ! test -e ${LINKIS_DSS_HOME}/wedatasphere-linkis-*.tar.gz; then
    echo "**********Error: please put wedatasphere-linkis-xxx.tar.gz in ${LINKIS_DSS_HOME}! "
    exit 1
  fi
  echo "Start to unzip linkis package."
  tar -xvf ${LINKIS_DSS_HOME}/wedatasphere-linkis-*.tar.gz -C ${TMP_LINKIS_FILE_PATH}/ > /dev/null 2>&1
  isSuccess " Unzip linkis package to ${TMP_LINKIS_FILE_PATH}."
  linkisReplace
}

#dss server deploy package
function dssServerInstall(){
  if ! test -e ${ORCHESTRATOR_FILE_PATH}; then
    sudo mkdir -p ${ORCHESTRATOR_FILE_PATH};sudo chown -R $deployUser:$deployUser ${ORCHESTRATOR_FILE_PATH}
    isSuccess "Create the dir of  ${ORCHESTRATOR_FILE_PATH}"
  fi
  if ! test -e ${EXECUTION_LOG_PATH}; then
    sudo mkdir -p ${EXECUTION_LOG_PATH};sudo chown -R $deployUser:$deployUser ${EXECUTION_LOG_PATH}
    isSuccess "Create the dir of  ${EXECUTION_LOG_PATH}"
  fi
  if ! test -e ${TMP_DSS_FILE_PATH}; then
    sudo mkdir -p ${TMP_DSS_FILE_PATH};sudo chown -R $deployUser:$deployUser ${TMP_DSS_FILE_PATH}
    isSuccess "Create the dir of  ${TMP_DSS_FILE_PATH}"
  fi
  if ! test -e ${TMP_DSS_FILE_PATH}; then
    sudo mkdir -p ${TMP_DSS_FILE_PATH};sudo chown -R $deployUser:$deployUser ${TMP_DSS_FILE_PATH}
    isSuccess "Create the dir of  ${TMP_DSS_FILE_PATH}"
  fi
  if ! test -e ${LINKIS_DSS_HOME}/wedatasphere-dss-*.tar.gz; then
    echo "**********Error: please put wedatasphere-dss-xxx.tar.gz in ${LINKIS_DSS_HOME}! "
    exit 1
  fi
  echo "Start to unzip dss server package."
  tar -xvf ${LINKIS_DSS_HOME}/wedatasphere-dss-*.tar.gz -C ${TMP_DSS_FILE_PATH}/ > /dev/null 2>&1
  isSuccess "Unzip dss server package to ${LINKIS_DSS_HOME}/dss"

  if test -e ${TMP_DSS_FILE_PATH}/bin; then
        dos2unix ${TMP_DSS_FILE_PATH}/bin/*.sh
  fi
  if test -e ${TMP_DSS_FILE_PATH}/$DSS_FILE_NAME/sbin; then
        dos2unix ${TMP_DSS_FILE_PATH}/$DSS_FILE_NAME/sbin/*
  fi
    if test -e ${TMP_DSS_FILE_PATH}/$DSS_FILE_NAME/sbin/ext; then
        dos2unix ${TMP_DSS_FILE_PATH}/$DSS_FILE_NAME/sbin/ext/*
  fi
  dssReplace
}

#dss web deploy package
function dssWebInstall(){
  #DSS_INSTALL_WEB
  if ! test -e ${LINKIS_DSS_HOME}/web; then
    rm -rf ${LINKIS_DSS_HOME}/web
    sudo mkdir -p ${LINKIS_DSS_HOME}/web;sudo chown -R $deployUser:$deployUser ${LINKIS_DSS_HOME}/web
    isSuccess "Create the dir of  ${LINKIS_DSS_HOME}/web"
  fi

  if ! test -e ${LINKIS_DSS_HOME}/wedatasphere-dss-web*.zip; then
    echo "**********Error: please put wedatasphere-dss-web-xxx.zip in ${LINKIS_DSS_HOME}! "
    exit 1
  fi
  echo "Start to unzip dss web package."
  unzip  -d ${LINKIS_DSS_HOME}/web/ -o ${LINKIS_DSS_HOME}/wedatasphere-dss-web-*.zip > /dev/null 2>&1
  isSuccess "Unzip dss web package to ${LINKIS_DSS_HOME}/web"

  if test -e ${LINKIS_DSS_HOME}/web/config.sh; then
        dos2unix ${LINKIS_DSS_HOME}/web/*.sh
  fi
  dssWebReplace
}


#transfer dss-gateway To linkis gateWay
function transferDssGatewayToLinkisGateWay(){
LINKIS_PLUGINS_PATH=${LINKIS_HOME}/lib/linkis-engineconn-plugins
if test -e ${LINKIS_PLUGINS_PATH}; then
  APP_CONN_FILE=${TMP_DSS_FILE_PATH}/${DSS_FILE_NAME}/dss-appconns/linkis-engineplugin-appconn.zip
  if test -e ${APP_CONN_FILE} ; then
    echo "transfer ${APP_CONN_FILE} To linkis ${LINKIS_PLUGINS_PATH} "
    cp -r ${APP_CONN_FILE} ${LINKIS_PLUGINS_PATH}
        unzip  -d ${LINKIS_PLUGINS_PATH} -o ${APP_CONN_FILE} > /dev/null 2>&1
        rm -rf ${LINKIS_PLUGINS_PATH}/linkis-engineplugin-appconn.zip
        sudo mv ${LINKIS_PLUGINS_PATH}/linkis-engineplugin-appconn ${LINKIS_PLUGINS_PATH}/appconn
        CONF_SERVER_PROPERTIES=${LINKIS_PLUGINS_PATH}/appconn/dist/v1/conf/linkis-engineconn.properties
        TMPE_JDBC_URL="jdbc:mysql://$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DB?characterEncoding=UTF-8"
    sed -i  s#wds.linkis.server.mybatis.datasource.url=.*#wds.linkis.server.mybatis.datasource.url=${TMPE_JDBC_URL}#g ${CONF_SERVER_PROPERTIES}
        sed -i  s#wds.linkis.server.mybatis.datasource.username=.*#wds.linkis.server.mybatis.datasource.username=${MYSQL_USER}#g ${CONF_SERVER_PROPERTIES}
        sed -i  s#wds.linkis.server.mybatis.datasource.password=.*#wds.linkis.server.mybatis.datasource.password=${MYSQL_PASSWORD}#g ${CONF_SERVER_PROPERTIES}
        sed -i  s#wds.linkis.gateway.ip=.*#wds.linkis.gateway.ip=${LINKIS_GATEWAY_INSTALL_IP}#g ${CONF_SERVER_PROPERTIES}
        sed -i  s#wds.linkis.gateway.port=.*#wds.linkis.gateway.port=${LINKIS_GATEWAY_PORT}#g ${CONF_SERVER_PROPERTIES}
        sed -i  s#wds.linkis.gateway.url=.*#wds.linkis.gateway.url=http://${LINKIS_GATEWAY_INSTALL_IP}:${LINKIS_GATEWAY_PORT}/#g ${CONF_SERVER_PROPERTIES}
  fi

  INIT_ROOT_PATH=${LINKIS_DSS_HOME}/init-files
  ENGINEPLUGIN_JAR_FILE=${INIT_ROOT_PATH}/linkis-appconn-engineplugin-${DSS_VERSION}.jar
  if test -e ${ENGINEPLUGIN_JAR_FILE} ; then
    cp -rfp ${ENGINEPLUGIN_JAR_FILE} ${LINKIS_HOME}/lib/linkis-engineconn-plugins/appconn/dist/v1/lib/
        cp -rfp ${ENGINEPLUGIN_JAR_FILE} ${LINKIS_HOME}/lib/linkis-engineconn-plugins/appconn/plugin/1/
    echo "transfer ${ENGINEPLUGIN_JAR_FILE} To linkis ${LINKIS_HOME}/lib/linkis-engineconn-plugins/appconn/ "
  fi
fi

if test -e ${LINKIS_HOME}/lib/linkis-spring-cloud-services/linkis-mg-gateway; then
  if test -e ${TMP_DSS_FILE_PATH}/${DSS_FILE_NAME}/lib/dss-plugins/linkis/dss-gateway/dss-gateway-support*.jar ; then
    echo "transfer dss-gateway To linkis gateWay "
    cp -r ${TMP_DSS_FILE_PATH}/${DSS_FILE_NAME}/lib/dss-plugins/linkis/dss-gateway/dss-gateway-support*.jar ${LINKIS_HOME}/lib/linkis-spring-cloud-services/linkis-mg-gateway/
  fi
fi
}

#######设置为当前路径，如果不需要直接注掉这执行函数##########
setCurrentRoot

echo "########################################################################"
echo "###################### Start to install Linkis #########################"
echo "########################################################################"
linkisInstall
sh ${TMP_LINKIS_FILE_PATH}/bin/install.sh
isSuccess "install Linkis"
echo ""

echo "########################################################################"
echo "###################### Start to install DSS Server #####################"
echo "########################################################################"
dssServerInstall
sh ${TMP_DSS_FILE_PATH}/bin/install.sh
isSuccess "install DSS Server"
echo ""

echo "########################################################################"
echo "###################### Start to install linkis plugins appconn #####################"
echo "########################################################################"
transferDssGatewayToLinkisGateWay
isSuccess "linkis plugins appconn"
echo ""


echo "########################################################################"
echo "###################### Start to install DSS Web ########################"
echo "########################################################################"
dssWebInstall
sudo sh ${LINKIS_DSS_HOME}/web/install.sh
echo "install DSS Web"

# Delete install directory
sudo rm -rf ${TMP_DSS_FILE_PATH}
sudo rm -rf ${TMP_LINKIS_FILE_PATH}