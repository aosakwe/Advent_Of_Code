## Solution to Day 9 Puzzle ##
# Execution time for both parts is ~ 3.33 seconds

library(stringr)
library(tictoc)

tic()
# Part 1 #
input <- read.table("test.txt", colClasses = "character")

low_point_risk <- 0

#using this to store coordinates for all points for part 2
rows <- c()
cols <- c()

for (row in 1:nrow(input)){
  
  for (col in 1:str_length(input[1,])){
    cur <- str_sub(input[row,],col,col)
    low <- TRUE # this logic variable us used to identify a low point
    if(col+1 <= str_length(input[1,])){
      if (str_sub(input[row,],col+1,col+1) <= cur ){
        low <- FALSE
        next
      }
    }
    if (col-1 >= 1){
      if (str_sub(input[row,],col-1,col-1) <= cur ){
        low <- FALSE
        next
      }
    }
    if (row+1 <= nrow(input)){
      if (str_sub(input[row+1,],col,col) <= cur ){
        low <- FALSE
        next
      }
    }
    if (row-1 >= 1){
      if (str_sub(input[row-1,],col,col) <= cur ){
        low <- FALSE
        next
      }
    }
    if (low){
      #print(cur)
      low_point_risk <- low_point_risk + 1 + as.numeric(cur)
      rows <- c(rows,row)
      cols <- c(cols,col)
    }
  }
  
}
low_point_risk

# Part 2 #

#function takes a low point and finds the size of its corresponding basin

basin_fill <- function(row,col){
  size <- 0
  Rows <- c(row)
  Cols <- c(col)
  i <- 1
  while (i <= length(Rows)) {
    row <- Rows[i]
    col <- Cols[i]
    if(col+1 <= str_length(input[1,])){
      if (str_sub(input[row,],col+1,col+1) != '9' & str_sub(input[row,],col+1,col+1) != 'X'){
        str_sub(input[row,],col+1,col+1) <- 'X'
        Rows <- c(Rows,row)
        Cols <- c(Cols,col+1)
        size <- size + 1
      }
    }
    if (col-1 >= 1){
      if (str_sub(input[row,],col-1,col-1) != '9' & str_sub(input[row,],col-1,col-1) != 'X'){
        str_sub(input[row,],col-1,col-1) <- 'X'
        Rows <- c(Rows,row)
        Cols <- c(Cols,col-1)
        size <- size + 1
      }
    }
    if (row+1 <= nrow(input)){
      if (str_sub(input[row+1,],col,col) != '9' & str_sub(input[row+1,],col,col) != 'X' ){
        str_sub(input[row+1,],col,col) <- 'X'
        Rows <- c(Rows,row+1)
        Cols <- c(Cols,col)
        size <- size + 1
      }
    }
    if (row-1 >= 1){
      if (str_sub(input[row-1,],col,col) != '9' & str_sub(input[row-1,],col,col) != 'X' ){
        str_sub(input[row-1,],col,col) <- 'X'
        Rows <- c(Rows,row-1)
        Cols <- c(Cols,col)
        size <- size + 1
      }
    }
    #look at next set of coordinates
    i <- i + 1
  }
  return(size)
}

#Taking advantage of the nested for loop in part 1, we can skip having to iterate through every point again by using the list of low point coordinates
basins <- c()
for (i in 1:length(rows)){
  basins <- c(basins,basin_fill(rows[i],cols[i]))
}
basins <- sort(basins,decreasing = TRUE)
basins[1]*basins[2]*basins[3]
toc()

