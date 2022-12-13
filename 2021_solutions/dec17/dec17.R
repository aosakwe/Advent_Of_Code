### Solution to Day 17 Puzzle ###

# Mini_test target
target_x <- c(20,30)
target_y <- c(-10,-5)

# Test target
#target_x <- c(257,286)
#target_y <- c(-101,-57)


# Need to find min VX required to reach target --> based on the sum of an arithmetic sequence of d = 1 with n1 = 0
#this will define the maximum number of steps y can take to reach target_y
 

time_x <- c()
speeds_x <- c()
final_vx <- c()
max_vx <- max(target_x)
quad1 <- round(-0.5 + sqrt(1+(8*min(target_x)))*0.5)
quad2 <- round(-0.5 - sqrt(1+(8*min(target_x)))*0.5)
vals <- c(quad1,quad2)
if (min(target_x) > 0){
  min_vx <- min(vals[vals > 0])
} 
elif (min(target_x) < 0) {
  min_vx <- max(vals[vals < 0])
}

for (vx in min_vx:max_vx){
  t <- 0
  x <- 0
  speed <- vx
  while (x < max(target_x) & speed > 0) {
    x <- x + speed
    speed <- speed - 1
    t <- t + 1
    if (x >= min(target_x) & x <= max(target_x)){
      time_x <- c(time_x,t)
      speeds_x <- c(speeds_x,vx)
      final_vx <- c(final_vx,speed)
    }
    
  }
}
x_times <- cbind(time_x,speeds_x,final_vx)

  
time_y <- c()
speeds_y <- c()
max_vy <- max(abs(target_y))
for (vy in 0:max_vy){
  y = 0
  t <- 2*vy+1
  speed <- vy
  while (y > min(target_y)){
    y <- y - speed
    t <- t + 1
    speed <- speed + 1
    if (y >= min(target_y) & y <= max(target_y)){
      time_y <- c(time_y,t)
      speeds_y <- c(speeds_y,vy)
    }
  }
}
y_times <- cbind(time_y,speeds_y)

super_vx <- x_times[x_times[,3] == 0,1:2]
valid_y <- y_times[y_times[,1] %in% x_times[,1],]
super_vx
y_times
y_times
x_times

