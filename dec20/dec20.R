### Solution to Day 20 Puzzle ###
#Note --> Need to optimize my solution for part 2
#As is the algorithm used takes ~8000 seconds to execute

library(tidyverse)
library(tictoc)
options(scipen = 1000, digits = 7)
##   Data Prep
input <- file("test.txt","r")
algo <- readLines(input,n = 1)
image <- readLines(input)
close(input)
image <- image[which(image != "")]
image <- matrix(data = image, nrow = length(image),ncol = 1)
image <- data.frame(t(sapply( image, function(a) unlist( strsplit( a, "" )))),row.names = NULL)




# Helper functions
sqr2bin <- function(x){
  x[x == "."] <- "0"
  x[x== "#"] <- "1"
  return(paste(paste(x[1,],collapse = ''),paste(x[2,],collapse = ''),paste(x[3,],collapse = ''),collapse = '', sep = ''))
  #out <- str_c(x)
  #return(out)
  
}
bin2dec <- function(x){
  dec <- 0
  for (i in str_length(x):1){
    dec <- dec + (2**(str_length(x)-i))*as.numeric(str_sub(x,i,i))
  }
  return(dec)
}

# Function 1
enlarge <- function(im,fill){
  row <- nrow(im)
  col <- ncol(im)
  # Fill based on what the infinite region of image currently is
  out <- data.frame(matrix(data = fill, nrow = row + 10, ncol = col + 10 ))
  out[6:(row+5),6:(col+5)] <- im
  return(out)
}

pixel_change <- function(im,r,c,algo){
  pixels <- im[(r-1):(r+1),(c-1):(c+1)]
  pixels <- sqr2bin(pixels)
  #need to shift by one because R loooves indices that start by 1 instead of 0
  i <- bin2dec(pixels) + 1
  return(str_sub(algo,i,i))
}



enhance <- function(im,alg,fill = '.'){
  #here: only enhance CURRENT pixels in input image (the infinite pixels is an excuse to make algorithm work)
  #run it on dimensions of current image only (and their extremities)
  #make a copy of grid to transfer algorith output to 
  rows <- nrow(im)
  cols <- ncol(im)
  big_frame <- enlarge(im,fill)
  new_frame <- data.frame(big_frame) #apply changes to this graph
  for (r in 4:(rows+7)){
    for (c in 4:(cols+7)){
      new_frame[r,c] <- pixel_change(big_frame,r,c,alg)
    }
  }
  #Swap enables me to finish filling in the simulated infinite region of the image in my grid (region guaranteed to be composed entirely of the same pixel)
  swap <- pixel_change(big_frame,2,2,algo)
  new_frame[c(1:3,nrow(big_frame):(nrow(big_frame)-2)),] <- swap
  new_frame[,c(1:3,ncol(big_frame):(ncol(big_frame)-2))] <- swap
  return(new_frame)
}

#Part 1
im2 <- enhance(image,algo,'.')
im3 <- enhance(im2,algo,'#')
length(which(im3 == '#'))

test <- image
tic()
#Part 2 
for (i in 1:50){
  x <- ifelse(i%%2 == 0,'#','.')
  test <- enhance(test,algo,x)
}
length(which(test == "#"))
toc()