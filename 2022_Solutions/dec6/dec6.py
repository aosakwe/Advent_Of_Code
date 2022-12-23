#!/bin/python3

## Script for Dec 6

import sys

input = sys.argv[1]
# Part 1
for i in range(len(input)):
	# Store current four character window
	temp = [*input[i:i+4]]
#	print(temp)
	#convert to set to have unique characters
	if len(set(temp)) == 4:
		# if all four are unique, print the position of the last character in the window	
		print(str(i + 4))
		break

# Part 2

for i in range(len(input)):
        # Store current four character window
        temp = [*input[i:i+14]]
#       print(temp)
        #convert to set to have unique characters
        if len(set(temp)) == 14:
                # if all four are unique, print the position of the last character in the window
                print(str(i + 14))
                break



