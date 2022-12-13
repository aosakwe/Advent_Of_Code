#!/bin/python3

import sys
## Solution for Dec 1

## Part 1 and 2

input = open(sys.argv[1],'r')

max_cal = 0
total_cal = 0
all_cal = []
for line in input:
    if line != "\n":
        total_cal += int(line)
    else:
        if total_cal > max_cal:
            max_cal = total_cal
        all_cal.append(total_cal)
        total_cal = 0    

input.close()
all_cal.sort(reverse = True)

print(str(max_cal))

print(sum(all_cal[0:3]))
