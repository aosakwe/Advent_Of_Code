#!/bin/python3
#Script for day 2

#Part 1

import sys

input = open(sys.argv[1], "r")

color_dict = {'red':12,'green':13,'blue':14}
game_sum = 0
valid = True
for line in input:
    contents = line.split(": ")[1].strip()
    game_num = line.split(":")[0].split(" ")[1]
    for game in contents.split('; '):
        cur_game = game.split(", ")
        for pick in cur_game:
            if int(pick.split(' ')[0]) > color_dict[pick.split(' ')[1]]:
                valid = False
                break
    if valid:
        game_sum += int(game_num)
    valid = True        
input.close()
print(game_sum)


#Part 2

#Min possible num
min_dict = {'red':0,'green':0,'blue':0}
pow_sum = 0
input = open(sys.argv[1], "r")
for line in input:
    contents = line.split(": ")[1].strip()
    game_num = line.split(":")[0].split(" ")[1]
    for game in contents.split('; '):
        cur_game = game.split(", ")
        for pick in cur_game:
            col = pick.split(' ')[1]
            count = int(pick.split(' ')[0])
            if count > min_dict[col]:
                min_dict[col] = count
    
    pow_sum += min_dict['red']*min_dict['green']*min_dict['blue']
    min_dict = {'red':0,'green':0,'blue':0}       

print(pow_sum)
