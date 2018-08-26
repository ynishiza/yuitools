#!/bin/bash
EXPRESSION=$@
USER=cognetprod
PASSWORD=b.KuHOQd5yWctu.eRAmMp07kmQDz3JQ
HOST=localhost
PORT=13335

cypher-shell -a $HOST:$PORT -u $USER -p $PASSWORD "$@"
