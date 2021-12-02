#!/bin/python3

import sys

input = open(sys.argv[1],'r')
current_depth = None 
increases = 0
for line in input:
	if current_depth != None:
		if int(line) > current_depth:
			increases += 1
	current_depth = int(line)
print(str(increases)) 



