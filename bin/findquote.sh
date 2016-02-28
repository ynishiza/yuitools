#!/bin/bash
TEMPFILE=
find . | sed -e 's/\(.*\)/“\1”/'
