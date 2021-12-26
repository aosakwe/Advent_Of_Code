## Solution to Day 8 Puzzle ##
#Runs in 1.83 seconds
#IMPORTANT#
# I used sed to convert the input file to csv format and replace the '|' characters with '\n'
# Therefore all the odd rows stored the signals and the even rows stored the corresponding values 
library(tidyverse)
library(tictoc)


patterns <- data.frame(t(read.csv("test.txt",header = FALSE)[c(TRUE,FALSE),]))


values <- read.csv("test.txt",header = FALSE)[c(FALSE,TRUE),]
values <- data.frame(t(values[,1:4]))

tic()
# Part 1 #

#Brute force solution 
occurences <- 0
for (col in 1:ncol(values)){
  for (row in 1:4){
    if (nchar(values[row,col]) == 2 | nchar(values[row,col]) == 3 | nchar(values[row,col]) == 4 | nchar(values[row,col]) == 7){
      occurences <- occurences + 1
    }
  }
}
occurences


# Part 2 #

#Find anagram (needed as the characters in the provided code may not be ordered the same way as in the corresponding signal)
anagram <- function(x,y){
  if (str_length(x) != str_length(y)){
    return(FALSE)
  }
  for (let in letters){
    if (str_count(x,let) != str_count(y,let)){
      return(FALSE)
    }
  }
  return(TRUE)
}



#Reading over the signals  made me realize that we can use the intersects between the deciphered signals 
#and the unknown ones to figure out the missing digits


decode <- function(signals,codes){
  digit <- data.frame(cbind(seq(from = 0, to = 9),matrix(10,ncol = 1,nrow = 10)))
  
  digit[digit$X1 == 1,2] <- signals[nchar(signals) == 2]
  digit[digit$X1 == 4,2] <- signals[nchar(signals) == 4]
  digit[digit$X1 == 7,2] <- signals[nchar(signals) == 3]
  digit[digit$X1 == 8,2] <- signals[nchar(signals) == 7]
  fives <- signals[nchar(signals) == 5]
  sixes <- signals[nchar(signals) == 6] 
  
  for (segment in fives){
    if (sum(nchar(Reduce(intersect,strsplit(c(digit[digit$X1 == 1,2],segment),"")))) == 2){
      digit[digit$X1 == 3,2] <- segment
      fives <- fives[fives != segment]
    }
  }
  for (segment in sixes){
    if (sum(nchar(Reduce(intersect,strsplit(c(digit[digit$X1 == 4,2],segment),"")))) == 4){
      digit[digit$X1 == 9,2] <- segment
      sixes <- sixes[sixes != segment]
    }
  }
  for (segment in fives){
    if (sum(nchar(Reduce(intersect,strsplit(c(digit[digit$X1 == 9,2],segment),"")))) == 4){
      digit[digit$X1 == 2,2] <- segment
      digit[digit$X1 == 5,2] <- fives[fives != segment]
      
    }
  }
  for (segment in sixes){
    if (sum(nchar(Reduce(intersect,strsplit(c(digit[digit$X1 == 1,2],segment),"")))) == 2){
      digit[digit$X1 == 0,2] <- segment
      digit[digit$X1 == 6,2] <- sixes[sixes != segment]
      
    }
  }
  out <- c()
  for (output in codes){
    digit$choice <- as.matrix(sapply(digit$X2, function(a) anagram(a,output)))
    out <- c(out,digit$X1[digit$choice])
  }
  return(paste(out,collapse = ''))
}


output <- c()
for (i in 1:ncol(patterns)){
  output <- c(output,decode(patterns[,i],values[,i]))
}
sum(as.numeric(output))
toc()
