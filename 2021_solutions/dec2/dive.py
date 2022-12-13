#!/bin/python3

## Code for Dec. 2 Solution ##

import sys

input = open(sys.argv[1], 'r')
print(input.read())
location = [0,0]

## Part 1 ##
# Calculate the horizontal position and depth you would have after following the planned course. What do you get if you multiply your final horizontal position by your final depth? #

for command in input:
	#Split command into direction and magnitude
	line = command.split() 
	#identify direction of command and apply change in position
	if line[0] == "forward":
		location[0] += int(line[1])
	elif line[0] == "down":
		location[1] += int(line[1])
	elif line[0] == "up":
		location[1] -= int(line[1])
	else:
		raise ValueError("Commands in input file must be forward, up or down")
input.close()
# Print product of vertical and horizontal position
print(str(location[0]*location[1]))







