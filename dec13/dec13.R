## Solution to Day 13 Puzzle ## runs in ~1.44 seconds
library(tidyverse)
library(tictoc)


coords <- read.table("test.txt",sep = ",")
folds <- read.table("order.txt",sep = ',')

#Shifting line of fold by one as R indices start at 1 instead of 0 *sigh*
folds$V2 <- folds$V2 + 1
Grid <- data.frame(matrix(data = '',nrow = max(coords[,2])+1,ncol = max(coords[,1])+1))


#Add all the Xs to the grid
for (i in 1:nrow(coords)){
  Grid[coords[i,2]+1,coords[i,1]+1] <- 'X'
}


##Function to fold the grid, Splits grid into two along fold line, inverses the grid that gets folded onto the other
## and then merges both grids
folder <- function(grid,vert = TRUE, line = 0){
  if (vert){
    new_grid <- grid[1:(line-1),]
    #immediately invert second grid when generating it
    inverted <- grid[nrow(grid):(line+1),]
    #finding all the  O coordinates in new_grid that match X coordinates in inverted
    #this tells us where the new Xs will be
    swaps <- inner_join(data.frame(which(new_grid == '',arr.ind = TRUE)), data.frame(which(inverted == 'X', arr.ind = TRUE)))
    for (i in 1:nrow(swaps)){
      new_grid[swaps[i,1],swaps[i,2]] <- 'X'
    }
    return(new_grid)
  }
  else{
    new_grid <- grid[,1:(line-1)]
    inverted <- grid[,ncol(grid):(line+1)]
    swaps <- inner_join(data.frame(which(new_grid == '',arr.ind = TRUE)), data.frame(which(inverted == 'X', arr.ind = TRUE)))
    for (i in 1:nrow(swaps)){
      new_grid[swaps[i,1],swaps[i,2]] <- 'X'
    }
    return(new_grid)
  }
}


length(Grid[Grid == 'X'])

tic()
# Part 1 #
if (folds[1,1] == 'y'){
  first_fold <- folder(Grid,vert = TRUE, line = folds[1,2]) 
} else {
  first_fold <- folder(Grid,vert = FALSE,line = folds[1,2])
}
length(first_fold[first_fold == 'X'])


# Part 2 #
#Same solution as Part 1 but iterating through every fold instruction
fold <- Grid
for (i in 1:nrow(folds)){
  if (folds[i,1] == 'y'){
    fold <- folder(fold,vert = TRUE, line = folds[i,2]) 
  } else {
    fold <- folder(fold,vert = FALSE,line = folds[i,2])
  }
}
fold
write.table(fold,file = "dec13_output.txt",sep = '\t',col.names = FALSE,row.names = FALSE)
toc()