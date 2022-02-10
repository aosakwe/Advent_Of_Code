#!/bin/python3

## Solutions to 25 Dec. 2020 Advent of code puzzle ##

import sys

## Part 1 ##

# Storing public keys
door = int(sys.argv[1]) 
card = int(sys.argv[2])
# initializing subject number transformation
x = 1
y = 1
# initializing loop size to 0 for card and door
xloops = 0
yloops = 0

# loop to determine loop size
while x != door: 
	xloops += 1
	x = x * 7
	x = x % 20201227
	
while y != card:
	yloops += 1
	y = y * 7
	y = y % 20201227

# storing public key to compute encryption key
z = x
x = 1
for i in range(yloops):
	x = x * z
	x = x % 20201227
print(str(x))		
