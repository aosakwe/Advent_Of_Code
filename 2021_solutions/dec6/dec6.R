## Solution to day 6 Puzzle ##
fish <- as.numeric(read.table("test.txt",sep = ','))
fish2 <- fish
# Part 1 #

#Used to measure execution time
library(tictoc)
tic()

#Initial, less time and memory efficient approach. 80 iterations took ~ 0.14 seconds for large dataset
iterate_day <- function(x){
  births <- length(x[x == 0])
  #For every fish at time 0 , add a fish at time 9 at end of list
  x <- c(x,seq.int(9,9,length.out = births))
  #Replace every fish at time 0 with a fish at time 7
  x[x == 0] <- 7
  #Drop time of each fish by 1
  x <- x - 1
  return(x)
}

print(paste(c("Initial state: ",fish),collapse = ','))
for (day in 1:80){
  fish <- iterate_day(fish)
  #print(paste(c("After Day",day,":",fish),collapse = ' '))
}
print(length(fish))
toc()

# Part 2 #

fish_pop <- data.frame(matrix(0,ncol = 9,nrow = 1))
colnames(fish_pop) <- seq(0,8)
for (i in 1:9){
  #store values as numeric which allows for larger values than the integer type
  fish_pop[,i] <- as.numeric(length(fish2[fish2 == i -1]))
}
fish_pop
#New and improved approach. Realized I did not have to deal with each fish individually but by age cohort which saves a lot of time and memory
# 256 iterations took ~  0.13 seconds for large dataset 
fast_iterate_day <- function(x){
  births <- x[,1]
  #Shift all fish to the left of data frame by 1
  for (i in 1:8){
    x[,i] <- x[,i+1]
  }
  #Add births to column 9
  x[,9] <- births
  #add the number of fish that were at time 0 to time 6
  x[,7] <- x[,7] + births
  return(x)
}

tic()
for (day in 1:256){
  fish_pop <- fast_iterate_day(fish_pop)
}
format(sum(fish_pop[1,]),scientific = FALSE)
toc()
