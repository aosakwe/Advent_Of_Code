## Solution to Day 7 Puzzle ##

input <- as.numeric(read.table(file = 'test.txt',sep = ',',))
val <- data.frame(input)
pos <- unique(input)
# Part 1 #

shortest_dist <- 99999999999
position <- 9999999999
for (num in 1:max(pos)){
  val$shift <- abs(num - val$input)
  if (sum(val$shift) <= shortest_dist){
    shortest_dist <- sum(val$shift)
    position <- num
  }
}
shortest_dist


# Part 2 #
shortest_dist <- 99999999999
position <- 9999999999
for (num in 1:max(pos)){
  val$shift <- abs(num - val$input)*(1+abs(num - val$input))/2
  if (sum(val$shift) <= shortest_dist){
    shortest_dist <- sum(val$shift)
    position <- num
  }
}
shortest_dist

