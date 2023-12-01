#!/bin/python3

## Day 1 Solution
import sys
import re
##Part 1

input = open(sys.argv[1], "r")
first_digit = False
digit1 = None
cur_digit = None
digits = []

#Part 1
for line in input:
    for char in range(len(line)):
        if line[char].isdigit():
            if not first_digit:
                first_digit = True
                digit1 = int(line[char])
                cur_digit = int(line[char])
            else:
                cur_digit = int(line[char])
    digits.append(int(str(digit1) + str(cur_digit)))
    first_digit = False
    cur_digit = None

input.close()
print(sum(digits))

#Part 2 
str_int = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
input = open(sys.argv[2], "r")
first_digit = False
digit1 = None
cur_digit = None
digits = []
cur_str = ''
for line in input:
    idx2 = 0
    idx1 = len(line)
    for char in range(len(line)):
        if line[char].isdigit():
            if not first_digit:
                first_digit = True
                digit1 = int(line[char])
                cur_digit = int(line[char])
            else:
                cur_digit = int(line[char])
            continue
        cur_str += line[char]    
        
        for acter in range(char+1,len(line)):
            cur_str += line[acter]
            if cur_str in str_int:
                if not first_digit:
                    first_digit = True
                    digit1 = str_int.index(cur_str) + 1
                    cur_digit = digit1
                else:
                    cur_digit = str_int.index(cur_str) + 1
        cur_str = ''
    digits.append(int(str(digit1) + str(cur_digit)))
    first_digit = False
    cur_digit = None
    digit1 = None
                


       
       
input.close()
print(digits[0:20])
print(sum(digits))
