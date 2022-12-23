#!/bin/python3

import sys

#Using Stack DS via list of lists
# Push: append, Pop: pop

input = open(sys.argv[1],"r")
#stacks = [["Z","N"],["M","C","D"],["P"]]
stacks = [["D","H","N","Q","T","W","V","B"],["D","W","B"],["T","S","Q","W","J","C"],["F","J","R","N","Z","T","P"],["G","P","V","J","M","S","T"],["B","W","F","T","N"],["B","L","D","Q","F","H","V","N"],["H","P","F","R"],["Z","S","M","B","L","N","P","H"]]
backup = list(map(list, stacks))
## Part 1
for line in input:
	com = line.split(" ")
	for i in range(int(com[1])):
		stacks[int(com[5])-1].append(stacks[int(com[3])-1].pop())
top_val = [stack.pop() for stack in stacks]
print(''.join(top_val))
input.close()
## Part 2
stacks = backup #pointing to backup
input = open(sys.argv[1],"r")

for line in input:
	com = line.split(" ")
	stacks[int(com[5])-1] = stacks[int(com[5])-1] + stacks[int(com[3])-1][-int(com[1]):]
	#stacks[int(com[3])-1] = stacks[int(com[3])-1][0:int(com[1])+1]	
	for i in range(int(com[1])):
		stacks[int(com[3])-1].pop()
input.close()
top_val = [stack.pop() for stack in stacks]
print(''.join(top_val))	
	
