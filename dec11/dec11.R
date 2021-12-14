## Solution to Day 11 Puzzle ##
library(tidyverse)

input <- read.table("test.txt")



frame <- data.frame(sapply(input$V1, function(x) substring(x, first=seq(1:str_length(input[1,])), last=seq(1:str_length(input[1,])))))
frame <- mutate_all(frame, function(x) as.numeric(as.character(x)))
valid_coord <- data.frame(which(frame >= 0,arr.ind = TRUE))
##take in position of octopus above 9, change all surrounding values by one, and repeat for
## surrounding octopi that are now above 9 

## FUNCTION 1
check_neighbors <- function(r,c,grid){
  neighbors <- data.frame(cbind(c(r+1,r+1,r+1,r-1,r-1,r-1,r,r),c(c+1,c-1,c,c+1,c-1,c,c+1,c-1)))
  colnames(neighbors) <- c("row","col")
  neighbors <- inner_join(neighbors,valid_coord)
  flashed <- data.frame(which(is.na(grid),arr.ind = TRUE))
  return(anti_join(neighbors,flashed))
}

## FUNCTION 2
shift_neigh <- function(coords,grid){
  if (nrow(coords) > 0){
    for (i in 1:nrow(coords)){
      r <- coords[[i,1]]
      c <- coords[[i,2]]
      grid[r,c] <- grid[r,c] + 1
      
    }
  }
  return(grid)
}

## FUNCTION 3
reset <- function(grid){
  grid[is.na(grid)] <- 0
  return(grid)
}


##FUNCTION 4
flasher <- function(grid){
  points <- data.frame(which(grid > 9, arr.ind = TRUE))
  i <- 1
  while (length(grid[grid > 9 & !is.na(grid)]) > 0){
    row <- points[i,1]
    col <- points[i,2]
    grid[row,col] <- NA
    ## Need to adjust function to not use global variable...
    .GlobalEnv$flash <- .GlobalEnv$flash + 1
    neighbors <- check_neighbors(row,col,grid)
    grid <- shift_neigh(neighbors,grid)
    new_flashers <- data.frame(which(grid > 9, arr.ind = TRUE))
    colnames(new_flashers) <- c("row","col")
    points <- rbind(points,anti_join(new_flashers,points))
    i <- i + 1
  }
  
  return(grid)
}


## FUNCTION 5
iterate <- function(steps){
  for (i in 1:steps){
    frame <- frame + 1
    frame <- flasher(frame)
    frame <- reset(frame)
  }
}
## FUNCTION 6
iterate_simul <- function(){
  i = 0
  while (length(frame[frame == 0]) != 100){
    frame <- frame + 1
    frame <- flasher(frame)
    frame <- reset(frame)
    i <- i + 1
  }
  print(i)
  print(frame)
  
}
flash <- 0
iterate(100)
flash
iterate_simul()

