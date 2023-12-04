#!/bin/python3
 # Day 3 Solution

import sys

input = open(sys.argv[1], 'r')

def build_grid(input):
    grid = []
    for line in input:
        grid.append([*line.strip()])
    return grid

def check_neighbors(x,y,grid,grid_col,grid_row):
    is_part = False
    x_coords = [x-1,x,x+1]
    y_coords = [y-1,y,y+1]
    for xc in x_coords:
        for yc in y_coords:
            if xc >= 0 and xc < grid_row and yc >=0 and yc < grid_col:
                if not grid[xc][yc].isdigit() and grid[xc][yc] != '.':
                    is_part = True
    return is_part

def reset_search():
    return False, True, None

def search_grid(grid):
    is_part,no_num,cur_num = reset_search()
    part_sum = 0
    for row in range(len(grid)):
        for col in range(len(grid[row])):
            if grid[row][col].isdigit():
                if no_num:
                    cur_num = grid[row][col]
                    no_num = False
                else:
                    cur_num += grid[row][col]
                if not is_part:
                    is_part = check_neighbors(row,col,grid,len(grid[row]),len(grid))              
            elif is_part:
                #print(cur_num)
                part_sum += int(cur_num)
                is_part,no_num,cur_num = reset_search()
            else:
                is_part,no_num,cur_num = reset_search()
    return part_sum

grid = build_grid(input)
input.close()
#Part 1
print(search_grid(grid))


#Part 2
#returns list of coord tuples
def check_gears(x,y,grid,grid_col,grid_row):
    is_gear = None
    x_coords = [x-1,x,x+1]
    y_coords = [y-1,y,y+1]
    for xc in x_coords:
        for yc in y_coords:
            if xc >= 0 and xc < grid_row and yc >=0 and yc < grid_col:
               
                if grid[xc][yc] == '*':
                    
                    is_gear = (xc,yc)
    
    return is_gear


def find_gears(grid):
    is_gear,no_num,cur_num = reset_search()
    gear_sum = 0
    gears = {}
    for row in range(len(grid)):
        for col in range(len(grid[row])):
            if grid[row][col].isdigit():
                if no_num:
                    cur_num = grid[row][col]
                    no_num = False
                else:
                    cur_num += grid[row][col]
                if not is_gear:
                    gear_coords = check_gears(row,col,grid,len(grid[row]),len(grid))
                    if gear_coords != None:
                        is_gear = True
            
            elif cur_num != None:
                if gear_coords != None:
                    if gear_coords not in gears.keys():
                        gears[gear_coords] = [cur_num]
                    else:
                        gears[gear_coords].append(cur_num)
                is_gear,no_num,cur_num = reset_search()
                gear_coords = None
            else:
                is_gear,no_num,cur_num = reset_search()
                gear_coords = None      
     
    #Calculate ratios
    for coords in gears.keys():
        if len(gears[coords]) > 1:
            gear_sum += int(gears[coords][0])*int(gears[coords][1])          
                    
    
    return gear_sum

print(find_gears(grid))