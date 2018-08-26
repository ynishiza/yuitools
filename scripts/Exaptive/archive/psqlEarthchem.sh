#!/bin/bash
source settings.sh
DB=mydb
HOST=$EARTHCHEM_SERVER
USER=$1
if [ -z "$USER" ]; then USER=postgres; fi

psql -d $DB -U $USER -p 5432 -h $HOST -W
