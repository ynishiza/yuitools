#!/bin/bash
LOCALPORT="11113"
MONGOHOST="cognet-prod-shard-00-01-delh7.mongodb.net"
# MONGOHOST="cognet-prod-shard-00-01-delh7"
MONGOPORT="27017"

echo "Tunnelling to $MONGOHOST:$MONGOPORT at localhost:$LOCALPORT"
ssh -N -L "$LOCALPORT:$MONGOHOST:$MONGOPORT" yui@cognitive.exaptive.city
