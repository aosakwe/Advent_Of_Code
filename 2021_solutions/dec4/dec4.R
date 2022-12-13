## Solution to Day 4 Puzzle ##

# Part 1 #

#Function to identify a winning table 
bingo <- function(bingo_cards,nums){
  for (n in nums){
    bingo_cards <- lapply(bingo_cards,num_find,num = n)
    winners <- lapply(bingo_cards,winner)
    winners <- winners[!is.na(winners)]
    if (length(winners) >= 1){
      print(winners[1])
      print(n)
      return(sum(winners[[1]],na.rm = TRUE) *n)
    }
  }
}

#Function to split data frame into tables
make_tables <- function(x,data_list,rows){
  n <- (rows/5)
  for (i in 1:n){
    data_list[[i]] <- x %>% slice(1:5)
    x <- x %>% slice(6:nrow(x))
  }
  return(data_list)
}

# Function to search table for number
num_find <- function(x,num){
  x[x == num] <- NA
  return(x)
}

#Function to identify winning card
winner <- function(card){
  for (i in 1:ncol(card)){
    if (sum(is.na(card[i,])) == nrow(card)){
      return(card)
    }
    else if (sum(is.na(card[,i]))== ncol(card)){
      return(card)
    }
  }
  return(NA)
}
# Store list of numbers called
nums <- as.numeric(read.table(file = "test.txt",header = F,nrows = 1, sep = ','))

# Store all cards
input <- read.table(file = "test.txt",skip = 1,sep = '')
#Split cards into individual data frames
tables <- make_tables(input,data_list = list(),nrow(input))
tables
#Run bingo algorithm to find first card to win
bingo(tables,nums)

# Part 2 #

#Modified bingo function to identify last card to win
bingo_loser <- function(bingo_cards,nums){
  total <- length(bingo_cards)
  winners <- list()
  for (n in nums){
    #break loop if all cards have won before all numbers were called
    if (length(bingo_cards) == 0){
      break
    }
    bingo_cards <- lapply(bingo_cards,num_find,num = n)
    winners <- lapply(bingo_cards,winner)
    #remove cards that have won
    bingo_cards <- bingo_cards[is.na(winners)]
    #remove cards that have yet to win from winners list
    winners <- winners[!is.na(winners)]
    #if there is a winner, store the last winning card from this round
    if (length(winners) >= 1){
      last_winner <- winners[length(winners)]
      last_n <- n
    }
    #reset winners list
    winners <- list()
  }
  print(last_winner)
  print(last_n)
  return(sum(last_winner[[1]],na.rm = TRUE) *last_n)
}
#Run bingo algorithm to find last card to win
bingo_loser(tables,nums)
