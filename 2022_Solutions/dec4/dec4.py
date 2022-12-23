#!/bin/python3

import sys

input = open(sys.argv[1],'r')

counter = 0
counter2 = 0
#increment if length of intersection == length of one range in pair
for line in input:
	vals = list(map(int,line.replace("-",",").split(",")))
	range1 = set(range(int(vals[0]),int(vals[1]) + 1))
	range2 = set(range(int(vals[2]),int(vals[3]) + 1))
	overlap = range1.intersection(range2)
	if len(overlap) == len(range1) or len(overlap) == len(range2):
		counter += 1
	#	print(overlap)
	if len(overlap) > 0:
		counter2 += 1
print(counter)
print(counter2)
input.close()
