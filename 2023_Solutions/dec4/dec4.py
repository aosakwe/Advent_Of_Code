#!/bin/python3

#Solution for day 4

import sys

input = open(sys.argv[1], "r")

#Part 1
def parse_cards(input):
    game_set ={}
    for line in input:
        game = line.split(": ")[0]
        cards = line.split(": ")[1].strip()
        win_num,draws = cards.split(" | ")
        win_num = [card for card in win_num.split(" ") if card != ""]
        draws = [card for card in draws.split(" ") if card != ""]
        game_set[game] = [win_num,draws]
    return game_set

def get_score(game_set):
    score = 0
    hits = 0
    for game in game_set:
        win_num = game_set[game][0]
        draws = game_set[game][1]
        for draw in draws:
            if draw in win_num:
                hits += 1
        if hits > 0:
            score += pow(2,hits-1)
            hits = 0
    return score

game_set = parse_cards(input)
input.close()

print(get_score(game_set))

#Part 2

def get_cards(game_set):
    total_cards = len(game_set)
    copies = {}
    for card in game_set:
        copies[card] = 1
    card_names = list(copies.keys())
    for card in game_set:
        game = game_set[card]
        win_num = game[0]
        draws = game[1]
        next_copy = 0
        for draw in draws:
            if draw in win_num:
                next_copy += 1
                next_card = card_names[card_names.index(card) + next_copy]
                copies[next_card] += copies[card]

    total_cards = sum(copies.values())
    return total_cards


print(get_cards(game_set))