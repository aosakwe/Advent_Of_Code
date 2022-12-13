#!/bin/python3

import sys

input = open(sys.argv[1],'r')
increases = 0
depths = []
for line in input:
	depths.append(int(line))
i = 0
while i+4 <= len(depths):
	if sum(depths[i+1:i+4]) > sum(depths[i:i+3]):
		increases += 1  
	i += 1
input.close()
print(str(increases)) 



