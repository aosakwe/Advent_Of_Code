#!/bin/python3

import sys

input = open(sys.argv[1],"r")
score = 0
score2 = 0
for line in input:
	#part 1
	if line[0] == "A":
		if line[2] == "X":
			score += 4
		elif line[2] == "Y":
			score += 8
		else:
			score += 3
	
	elif line[0] == "B":
		if line[2] == "Y":
			score += 5
		elif line[2] == "X":
			score += 1
		else:
			score += 9
	
	elif line[0] == "C":
		if line[2] == "Z":
			score += 6
		elif line[2] == "Y":
			score += 2
		else:
			score += 7
	
	#part 2
	if line[0] == "A":
                if line[2] == "X":
                        score2 += 3
                elif line[2] == "Y":
                        score2 += 4
                else:
                        score2 += 8
	elif line[0] == "B":
                if line[2] == "Y":
                        score2 += 5
                elif line[2] == "X":
                        score2 += 1
                else:
                        score2 += 9
	elif line[0] == "C":
                if line[2] == "Z":
                        score2 += 7
                elif line[2] == "Y":
                        score2 += 6
                else:
                        score2 += 2
input.close()
print(str(score))
print(str(score2))

