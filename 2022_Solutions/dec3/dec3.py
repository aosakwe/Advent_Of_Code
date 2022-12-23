#!/bin/python3
import sys


input = open(sys.argv[1],'r')

overlap = []
group = []
group_overlap = []
counter = 0
for line in input:
	counter += 1
	group.append(line.strip())
	half = int(len(line)/2)
	value = set(line[0:half]).intersection(line[half:len(line)])
	val = value.pop()
	if ord(val) >= 97:
		overlap.append(ord(val) - 96)
	else:
		overlap.append(ord(val) - 38)
	if counter == 3:
		first = set(group[0]).intersection(group[1])
		final = first.intersection(group[2])
		val = final.pop()
		if ord(val) >= 97:
			group_overlap.append(ord(val) - 96)
		else:
			group_overlap.append(ord(val) - 38)
		counter = 0
		group = []
		
print(str(sum(overlap)))
print(str(sum(group_overlap)))
input.close()

