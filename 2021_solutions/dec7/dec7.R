## Solution to Day 7 Puzzle ##

input <- as.numeric(read.table(file = 'test.txt',sep = ',',))
val <- data.frame(input)
# Part 1 #

#Storing the position with the least distance/fuel covered/used for all crabs to reach the point
shortest_dist <- 99999999999
position <- 9999999999
for (num in 1:max(val$input)){
  #store distance/fuel for all crabs to reach the position
  val$shift <- abs(num - val$input)
  #if the fuel/distance is smaller than current smallest value, update
  if (sum(val$shift) <= shortest_dist){
    shortest_dist <- sum(val$shift)
    position <- num
  }
}
shortest_dist


# Part 2 #
shortest_dist <- 99999999999
position <- 9999999999
for (num in 1:max(val$input)){
  #same solution as above except shift now stores to sum of a finite arithmetic series with a difference of 1
  #since each additional shift of 1 uses one more fuel than the previous shift, the fuel used follows an arithmetic sequence
  val$shift <- abs(num - val$input)*(1+abs(num - val$input))/2
  if (sum(val$shift) <= shortest_dist){
    shortest_dist <- sum(val$shift)
    position <- num
  }
}
shortest_dist

