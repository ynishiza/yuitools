#!/usr/local/bin/bash
#
# Need Bash 4
# - associative array
#

###################################
##		Exaptive's servers
###################################
HOME="/Users/yuinishizawa"
EXAPTIVEAWS="$HOME/Dropbox (Exaptive, Inc.)/Exaptive/IT  (internal)/Amazon Web Services"
BASE="$HOME/.tools_yui/scripts/Exaptive"
echo "$EXAPTIVEAWS"

declare -A SERVER_HOSTS=()
declare -A SERVER_USERS=()
declare -A SSH_IDENTITY=()
declare -A SERVER_HOMES=()


#
# City
#
SERVER_HOSTS[city_prod]="exaptive.city"
SERVER_USERS[city_prod]="yui"
SERVER_HOSTS[city_staging]="staging.exaptive.city"
SERVER_USERS[city_staging]="yui"
SERVER_HOSTS[city_bamboo]="bamboo.exaptive.com"
SERVER_USERS[city_bamboo]="yui"
SERVER_HOSTS[city_dev]="dev.exaptive.city"
SERVER_USERS[city_dev]="yui"
SERVER_HOSTS[city_feature]="featurebranch.exaptive.city"
SERVER_USERS[city_feature]="yui"
SERVER_HOSTS[city_feature2]="featurebranch2.exaptive.city"
SERVER_USERS[city_feature2]="yui"
SERVER_HOSTS[city_emerald]="emerald.exaptive.city"
SERVER_USERS[city_emerald]="yui"
SERVER_HOSTS[city_labs]="labs.exaptive.city"
SERVER_USERS[city_labs]="yui"
SERVER_HOSTS[city_ppi]="ppi.exaptive.city"
SERVER_USERS[city_ppi]="yui"
SERVER_HOSTS[city_cvbio]="cvbio.exaptive.city"
SERVER_USERS[city_cvbio]="yui"

SERVER_HOSTS[cognet]="cognitive.exaptive.city"
SERVER_USERS[cognet]="yui"

SSH_IDENTITY[aws_jira]="${EXAPTIVEAWS}/AWS PEM keys/aws-jira.pem"

SERVER_HOSTS[dockerreg]="dockerreg.exaptive.com"
SERVER_USERS[dockerreg]="yui"
SERVER_HOSTS[jenkins]="jenkins.exaptive.com"
SERVER_USERS[jenkins]="exaptive"

SERVER_HOSTS[domainhost1]="domainhost1.exaptive.city"
SERVER_USERS[domainhost1]="ubuntu"
SSH_IDENTITY[domainhost1]="${EXAPTIVEAWS}/CityProdAccount/PemKeys/cityprod.pem"

SERVER_HOSTS[jenkins_ubuntu]="jenkins.exaptive.com"
SERVER_USERS[jenkins_ubuntu]="ubuntu"
SSH_IDENTITY[jenkins_ubuntu]="${EXAPTIVEAWS}/AWS PEM keys/jenkins.pem"

SERVER_HOSTS[city_rc]="rc.exaptive.city"
SERVER_USERS[city_rc]="ubuntu"
SSH_IDENTITY[city_rc]="${EXAPTIVEAWS}/CityProdAccount/PemKeys/cityprod.pem"


#
# Internal
#
SERVER_HOSTS[aws_jira]="54.84.14.56"
SERVER_USERS[aws_jira]="ec2-user"
SSH_IDENTITY[aws_jira]="${EXAPTIVEAWS}/AWS PEM keys/aws-jira.pem"
SSH_OPTIONS[aws_seracare]=""


#
# Home
#
SERVER_HOSTS[home_yui]="yui-home.local"
SERVER_USERS[home_yui]=nishizawayui

SERVER_HOSTS[home]="180.220.94.181"
SERVER_USERS[home]=nishizawayui

SERVER_HOSTS[home_midori]="midorin-macbook.local"
SERVER_USERS[home_midori]="midorin"


#
# FMI
#
# password: rtest
SERVER_HOSTS[fmi_p4_rtest]="p4-node001"
SERVER_USERS[fmi_p4_rtest]="rtest"

# password: Exaptive3
SERVER_HOSTS[fmi_p4_ynishizawa]="p4-node001"
SERVER_USERS[fmi_p4_ynishizawa]="ynishizawa"

# password: Exaptive3
SERVER_HOSTS[fmi_kbdev004_ynishizawa]="kbdev004"
SERVER_USERS[fmi_kbdev004_ynishizawa]="ynishizawa"

SERVER_HOSTS[aws_seracare]="seracare.exaptive.com"
SERVER_USERS[aws_seracare]="ubuntu"
SSH_IDENTITY[aws_seracare]="${EXAPTIVEAWS}/AWS PEM Keys/ubuntu-micro.pem"
SSH_OPTIONS[aws_seracare]=""

SERVER_HOSTS[aws_rserve]="54.235.243.130"
SERVER_USERS[aws_rserve]="ubuntu"
SSH_IDENTITY[aws_rserve]="${EXAPTIVEAWS}/pem/UbuntuServerKey.pem"


#
# GNS
#
SERVER_HOSTS[aws_gnsprod]="gnsinteractivemodeling.exaptive.com"
SERVER_USERS[aws_gnsprod]="ubuntu"
SSH_IDENTITY[aws_gnsprod]="${EXAPTIVEAWS}/AWS PEM Keys/ubuntu-micro.pem"

SERVER_HOSTS[aws_gnsdev]="gnsdev.exaptive.com"
SERVER_USERS[aws_gnsdev]="ubuntu"
SSH_IDENTITY[aws_gnsdev]="${EXAPTIVEAWS}/AWS PEM Keys/ubuntu-micro.pem"

SERVER_HOSTS[gns_sim]="54.172.8.29"
SERVER_USERS[gns_sim]="exaptive"
SSH_IDENTITY[gns_sim]="${BASE}/pem/exaptive-gns-privatekey.pem"

SERVER_HOSTS[gns_sim2]="52.21.60.201"
SERVER_USERS[gns_sim2]="exaptive"
SSH_IDENTITY[gns_sim2]="${BASE}/pem/exaptive-gns-privatekey.pem"


#
# Misc
#
SERVER_HOSTS[aws_city]="city.exaptive.com"
SERVER_USERS[aws_city]="yui"
SSH_IDENTITY[aws_city]="${HOME}/.ssh/id_rsa"

SERVER_HOSTS[aws_dev]="dev.exaptive.com"
SERVER_USERS[aws_dev]="ubuntu"
SSH_IDENTITY[aws_dev]="${EXAPTIVEAWS}/AWS PEM Keys/exaptive-git.pem"


###################################
# 				OLD				  #
# No longer used.

# AWS EarthChem server
EARTHCHEM_PEM="/Earthchem.pem"
EARTHCHEM_USER=ubuntu
EARTHCHEM_SERVER=54.173.40.91

# AWS JIRA server
JIRA_PEM="${EXAPTIVEAWS}/aws-jira.pem"
JIRA_USER="ec2-user"
JIRA_SERVER="54.84.14.56"

# AWS dev.exaptive.com
DEVEXAPTIVE_USER="ubuntu"
DEVEXAPTIVE_SERVER="dev.exaptive.com"
DEVEXAPTIVE_PEM="${EXAPTIVEAWS}/exaptive-git.pem"

# AWS Seracare
SERACARE_USER="ubuntu"
SERACARE_SERVER="seracare.exaptive.com"
SERACARE_PEM="${EXAPTIVEAWS}/ubuntu-micro.pem"

# AWS SciDB
SCIDB_USER="scidb"
SCIDB_SERVER="54.172.26.180"
SCIDB_PEM="${EXAPTIVEAWS}/scidb.pem"

# A smaller SciDB instance for testing.
SMALLSCIDB_SERVER="54.174.78.159"

RSERVE_USER="ubuntu"
RSERVE_SERVER="54.235.243.130"
RSERVE_PEM="${EXAPTIVEAWS}/UbuntuServerKey.pem"

GNS_USER="exaptive"
GNS_SERVER="54.172.8.29"
GNS_PEM="${BASE}/pem/exaptive-gns-privatekey.pem"

ORACLE_USER="root"
ORACLE_SERVER="ec2-52-0-56-21.compute-1.amazonaws.com"
ORACLE_PEM="${EXAPTIVEAWS}/Oracle.pem"

SPARK_USER="hadoop"
SPARK_SERVER="ec2-52-26-69-143.us-west-2.compute.amazonaws.com"
SPARK_PEM="${BASE}/pem/Spark.pem"

###################################
##		Other servers
###################################

# FMI's P4 server with SciDB data
P4_USER="ynishizawa"
P4_SERVER="p4-node001"

