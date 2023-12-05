#!/bin/python3

#Solution for day ____


import sys


#Part 1
def parse_input(file):
    input = open(file, "r")
    lines = []
    for line in input:
        line = line.strip()
        lines.append(line)
    input.close()
    return lines


def do_task(data):
    pass

data = parse_input(sys.argv[1])

print(do_task(data))

#Part 2