#!/usr/local/bin/bash
#
# Need Bash 4
# - associative array
#

###################################
##		Exaptive's servers
###################################
HOME="/Users/yuinishizawa"
EXAPTIVEAWS="$HOME/AWS"
BASE="$HOME/.tools_yui/scripts/Exaptive"

declare -A SERVER_HOSTS=()
declare -A SERVER_USERS=()
declare -A SSH_IDENTITY=()
declare -A SERVER_HOMES=()

SERVER_HOSTS[exaptive_staging]="staging.exaptive.com"
SERVER_USERS[exaptive_staging]="exaptive"
# password: rtest
SERVER_HOSTS[fmi_p4_rtest]="p4-node001"
SERVER_USERS[fmi_p4_rtest]="rtest"

# password: Exaptive3
SERVER_HOSTS[fmi_p4_ynishizawa]="p4-node001"
SERVER_USERS[fmi_p4_ynishizawa]="ynishizawa"

# password: Exaptive3
SERVER_HOSTS[fmi_kbdev004_ynishizawa]="kbdev004"
SERVER_USERS[fmi_kbdev004_ynishizawa]="ynishizawa"

SERVER_HOSTS[aws_jira]="54.84.14.56"
SERVER_USERS[aws_jira]="ec2-user"
SSH_IDENTITY[aws_jira]="${EXAPTIVEAWS}/AWS PEM keys/aws-jira.pem"
SSH_OPTIONS[aws_seracare]=""

SERVER_HOSTS[aws_seracare]="seracare.exaptive.com"
SERVER_USERS[aws_seracare]="ubuntu"
SSH_IDENTITY[aws_seracare]="${EXAPTIVEAWS}/AWS PEM Keys/ubuntu-micro.pem"
SSH_OPTIONS[aws_seracare]=""

SERVER_HOSTS[aws_rserve]="54.235.243.130"
SERVER_USERS[aws_rserve]="ubuntu"
SSH_IDENTITY[aws_rserve]="${EXAPTIVEAWS}/pem/UbuntuServerKey.pem"

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

SERVER_HOSTS[aws_city]="city.exaptive.com"
SERVER_USERS[aws_city]="yui"
SSH_IDENTITY[aws_city]="${HOME}/.ssh/id_rsa"

SERVER_HOSTS[home_yui]="yui-home.local"
SERVER_USERS[home_yui]=nishizawayui

SERVER_HOSTS[home]="180.220.94.181"
SERVER_USERS[home]=nishizawayui

SERVER_HOSTS[home_midori]="midorin-macbook.local"
SERVER_USERS[home_midori]="midorin"

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

