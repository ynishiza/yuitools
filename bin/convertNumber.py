#!/usr/bin/env python
import sys

BINARY = 'binary'
HEX = 'hex'
DECIMAL = 'decimal'


def get_mode(c):
    if len(c) != 1:
        raise Exception('Invalid length')
    if c == 'b':
        return BINARY
    elif c == 'h':
        return HEX
    elif c == 'd':
        return DECIMAL
    else:
        raise Exception('Invalid mode %s. Has to be one of: bhd' % c)


def run(inmode, outmode, invalue):
    if inmode == BINARY:
        base = 2
    elif inmode == DECIMAL:
        base = 10
    elif inmode == HEX:
        base = 16
    else:
        raise Exception('Invalid mode %s ' % inmode)

    outvalue = int(invalue, base)

    if outmode == BINARY:
        outvalue = bin(outvalue)[2:]
    elif outmode == DECIMAL:
        outvalue = outvalue
    elif outmode == HEX:
        outvalue = hex(outvalue)

    return outvalue


def print_usage():
    msg = """convertNumber [bhd][bhd] value

where
    b = binary
    h = hex
    d = decimal
    """
    print(msg)


def main(argv):
    if len(argv) < 2:
        print_usage()
        return
    if len(argv[0]) < 2:
        print_usage()
        return

    inmode = get_mode(argv[0][0])
    outmode = get_mode(argv[0][1])
    print(run(inmode, outmode, argv[1]))

main(sys.argv[1:])
