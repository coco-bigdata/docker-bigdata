### deploy user
# deployUser=hadoop

### Linkis_VERSION
LINKIS_VERSION=1.0.2

### DSS Web
DSS_NGINX_IP=127.0.0.1
DSS_WEB_PORT=8088

### DSS VERSION
DSS_VERSION=1.0.0


############## ############## linkis的其他默认配置信息 start ############## ##############
### Specifies the user workspace, which is used to store the user's script files and log files.
### Generally local directory
WORKSPACE_USER_ROOT_PATH=file:///tmp/linkis/ ##file:// required
### User's root hdfs path
HDFS_USER_ROOT_PATH=hdfs:///tmp/linkis ##hdfs:// required
### Path to store job ResultSet:file or hdfs path
RESULT_SET_ROOT_PATH=hdfs:///tmp/linkis ##hdfs:// required

### Path to store started engines and engine logs, must be local
ENGINECONN_ROOT_PATH=/appcom/tmp

#ENTRANCE_CONFIG_LOG_PATH=hdfs:///tmp/linkis/ ##hdfs:// required

###HADOOP CONF DIR #/appcom/config/hadoop-config
HADOOP_CONF_DIR=
###HIVE CONF DIR  #/appcom/config/hive-config
HIVE_CONF_DIR=
###SPARK CONF DIR #/appcom/config/spark-config
SPARK_CONF_DIR=
# for install
LINKIS_PUBLIC_MODULE=lib/linkis-commons/public-module


##YARN REST URL  spark engine required
YARN_RESTFUL_URL=http://127.0.0.1:8088

## Engine version conf
#SPARK_VERSION
#SPARK_VERSION=2.4.3
##HIVE_VERSION
#HIVE_VERSION=2.3.3
#PYTHON_VERSION=python2

## LDAP is for enterprise authorization, if you just want to have a try, ignore it.
#LDAP_URL=ldap://localhost:1389/
#LDAP_BASEDN=dc=webank,dc=com
#LDAP_USER_NAME_FORMAT=cn=%s@xxx.com,OU=xxx,DC=xxx,DC=com

################### The install Configuration of all Linkis's Micro-Services #####################
#
#    NOTICE:
#       1. If you just wanna try, the following micro-service configuration can be set without any settings.
#            These services will be installed by default on this machine.
#       2. In order to get the most complete enterprise-level features, we strongly recommend that you install
#          the following microservice parameters
#

###  EUREKA install information
###  You can access it in your browser at the address below:http://${EUREKA_INSTALL_IP}:${EUREKA_PORT}
###  Microservices Service Registration Discovery Center
#LINKIS_EUREKA_INSTALL_IP=127.0.0.1
LINKIS_EUREKA_PORT=20303
#LINKIS_EUREKA_PREFER_IP=true

###  Gateway install information
#LINKIS_GATEWAY_INSTALL_IP=127.0.0.1
LINKIS_GATEWAY_PORT=9001

### ApplicationManager
#LINKIS_MANAGER_INSTALL_IP=127.0.0.1
LINKIS_MANAGER_PORT=9101

### EngineManager
#LINKIS_ENGINECONNMANAGER_INSTALL_IP=127.0.0.1
LINKIS_ENGINECONNMANAGER_PORT=9102

### EnginePluginServer
#LINKIS_ENGINECONN_PLUGIN_SERVER_INSTALL_IP=127.0.0.1
LINKIS_ENGINECONN_PLUGIN_SERVER_PORT=9103

### LinkisEntrance
#LINKIS_ENTRANCE_INSTALL_IP=127.0.0.1
LINKIS_ENTRANCE_PORT=9104

###  publicservice
#LINKIS_PUBLICSERVICE_INSTALL_IP=127.0.0.1
LINKIS_PUBLICSERVICE_PORT=9105

### cs
#LINKIS_CS_INSTALL_IP=127.0.0.1
LINKIS_CS_PORT=9108

########## Linkis微服务配置完毕#####

################### The install Configuration of all DataSphereStudio's Micro-Services #####################
#
#    NOTICE:
#       1. If you just wanna try, the following micro-service configuration can be set without any settings.
#            These services will be installed by default on this machine.
#       2. In order to get the most complete enterprise-level features, we strongly recommend that you install
#          the following microservice parameters
#

# Used to store the azkaban project transformed by DSS
WDS_SCHEDULER_PATH=file:///appcom/tmp/wds/scheduler

### This service is used to provide dss-framework-project-server capability.
#DSS_FRAMEWORK_PROJECT_SERVER_INSTALL_IP=127.0.0.1
#DSS_FRAMEWORK_PROJECT_SERVER_PORT=9002

### This service is used to provide dss-framework-orchestrator-server capability.
#DSS_FRAMEWORK_ORCHESTRATOR_SERVER_INSTALL_IP=127.0.0.1
#DSS_FRAMEWORK_ORCHESTRATOR_SERVER_PORT=9003

### This service is used to provide dss-apiservice-server capability.
#DSS_APISERVICE_SERVER_INSTALL_IP=127.0.0.1
#DSS_APISERVICE_SERVER_PORT=9004

### This service is used to provide dss-workflow-server capability.
#DSS_WORKFLOW_SERVER_INSTALL_IP=127.0.0.1
#DSS_WORKFLOW_SERVER_PORT=9005

### This service is used to provide flow execution capability.
#DSS_FLOW_EXECUTION_SERVER_INSTALL_IP=127.0.0.1
#DSS_FLOW_EXECUTION_SERVER_PORT=9006

### This service is used to provide dss-datapipe-server capability.
#DSS_DATAPIPE_SERVER_INSTALL_IP=127.0.0.1
#DSS_DATAPIPE_SERVER_PORT=9008
########## DSS微服务配置完毕#####



############## ############## other default configuration 其他默认配置信息  ############## ##############

## java application minimum jvm memory
export SERVER_HEAP_SIZE="128M"


##sendemail配置，只影响DSS工作流中发邮件功能
EMAIL_HOST=smtp.163.com
EMAIL_PORT=25
EMAIL_USERNAME=xxx@163.com
EMAIL_PASSWORD=xxxxx
EMAIL_PROTOCOL=smtp

### Save the file path exported by the orchestrator service
ORCHESTRATOR_FILE_PATH=/appcom/tmp/dss
### Save DSS flow execution service log path
EXECUTION_LOG_PATH=/appcom/tmp/dss
############## ############## other default configuration 其他默认配置信息  ############## ##############