#!/bin/python3

#Solution for day 5


import sys


#Part 1


#take line 1 and store seeds

# for each remaining line
# set dict key to map name
# create corresponding lists for source and destination


#iterate through for each seed


def get_seeds(file):
      input = open(file, "r")
      seeds = input.readline().strip().split(": ")[1].split(" ")
      seeds = [int(i) for i in seeds]
      input.close()
      return seeds



def build_map(file):
      input = open(file, "r")
      input.readline()
      map = {}
      for line in input:
            if line == '\n':
                cur_key = None
            elif not line[0].isdigit():
                cur_key = line.split(' ')[0]
                map[cur_key] = []
                continue

            else:
                line = line.strip().split(" ")
                dest_start= int(line[0])
                source_start = int(line[1])
                shift = int(line[2])
                map[cur_key].append([(dest_start,dest_start+shift),(source_start,source_start+shift)])
      input.close()
      return map


def traverse_map(seeds,map,conv_order):
    seed_location = []
    for seed in seeds:
        #if seed != seeds[1]:
        #    continue
        cur_loc = seed
        for key in conv_order:
            is_found = False
            for dest,source in map[key]:
                if source[0] <= cur_loc <= source[1]:
                    #print(key)
                    #print(cur_loc,dest,source,dest[0] + (cur_loc - source[0]))
                    cur_loc = dest[0] + (cur_loc - source[0])
                    is_found = True
                    break
        seed_location.append(cur_loc)
    return seed_location                 

seeds = get_seeds(sys.argv[1])
map = build_map(sys.argv[1])
conv_order = map.keys()

seed_locations = traverse_map(seeds,map,conv_order)

print(min(seed_locations))
#Part 2