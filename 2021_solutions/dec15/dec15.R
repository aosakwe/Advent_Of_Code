## Solution to Day 15 Puzzle ##
library(tidyverse)
library(tictoc)


## FUNCTION 1
find_choices <- function(i,j){
  if( i < nrow & j < ncol & i > 1 & j > 1 ) { return( list(c(i+1, j), c(i-1, j), c(i, j+1), c(i, j-1)) ) }
  else if( i == nrow & j > 1 & j < ncol ) {    return( list(c(i-1, j), c(i, j+1), c(i, j-1)) ) }
  else if( i == 1 & j > 1 & j < ncol ) {       return( list(c(i+1, j), c(i, j-1), c(i, j+1)) ) }
  else if( i == nrow & j == 1 ) {              return( list(c(i-1, j), c(i, j+1) ) ) }
  else if( i == nrow & j == ncol ) {           return( list(c(i-1, j), c(i, j-1) ) ) }
  else if( i == 1 & j == 1 ) {                 return( list(c(i+1, j), c(i, j+1) ) ) }
  else if( i == 1 & j == ncol) {               return( list(c(i+1, j), c(i, j-1) ) ) }
  else if( i > 1 & i < nrow & j == 1 ) {       return( list(c(i-1, j), c(i+1, j), c(i, j+1) ) ) }
  else if( i > 1 & i < nrow & j == ncol ) {    return( list(c(i-1, j), c(i+1, j), c(i, j-1) ) ) }
  else if( TRUE ) { print( paste( i, j, print( "PANIC" ))) } }

## 
find_choices <- function(r,c){
  neighbors <- data.frame(rbind(c(r,c+1),c(r,c-1),c(r+1,c),c(r-1,c)))
  colnames(neighbors) <- c("row","col")
  neighbors <- inner_join(neighbors,valid_coord)
  return(neighbors)
}
## FUNCTION 2
find_next <- function(dists,have_visited){
  dists[dists == Inf] = 999999
  dists[have_visited] = Inf
  node <- which(dists == min(dists), arr.ind = TRUE)
  return(node[1,])
}



#Changing Scientific notation settings to accommodate for AoC answer format
options("scipen"=100, "digits"=4)

#Part 1
grid = read.table( "test.txt", colClasses="character" )[[1]]
grid = t(sapply( grid, function(a) unlist( strsplit( a, "" ))))
mode( grid ) = "numeric"; rownames( grid ) = NULL

# Part 2 (Comment out this section to get Part 1 answer)
wide_grid <- grid
next_grid <- grid

for (i in 1:4){
  next_grid <- next_grid + 1
  next_grid[next_grid == 10] <- 1
  wide_grid <- cbind(wide_grid,next_grid)
}

next_grid <- wide_grid
big_grid <- wide_grid
for (i in 1:4){
  next_grid <- next_grid + 1
  next_grid[next_grid == 10] <- 1
  big_grid <- rbind(big_grid,next_grid)
}
grid <- big_grid

### Code to find shortest path

valid_coord <- data.frame(which(!is.na(grid),arr.ind = TRUE))
visited <-  matrix(data = FALSE,nrow = nrow(grid), ncol = ncol(grid))
risks <- matrix(data = Inf,nrow = nrow(grid), ncol = ncol(grid))
risks[1,1] = 0
nrow = nrow(grid)
ncol = ncol(grid)



while(!all(visited)){
  choice <- find_next(risks,visited)
  visited[choice[[1]],choice[[2]]] <- TRUE
  choices <- find_choices(choice[[1]],choice[[2]])
  cur_risk <- risks[choice[[1]],choice[[2]]]
  for (path in choices){
    if (!(visited[path[1],path[2]])){
      path_risk <- as.numeric(grid[path[1],path[2]])
      if (cur_risk + path_risk < risks[path[1],path[2]]){
        risks[path[1],path[2]] <- cur_risk + path_risk
      }
    }
  }
}

risks[nrow(risks),ncol(risks)]
beep()
#Reset scientific notation settings
#options("scipen"=0, "digits"=7)




