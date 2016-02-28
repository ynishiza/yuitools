#!/usr/bin/env python
import sys

if len(sys.argv) != 4: raise Exception("%s file fromEncoding toEncoding" % (sys.argv[0]))
filename = sys.argv[1]
fromEncoding = sys.argv[2]
toEncoding = sys.argv[3]

with open(filename, 'r') as f:
    s = f.read()
    print s.decode(fromEncoding).encode(toEncoding)
