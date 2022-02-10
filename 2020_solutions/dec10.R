## Solution to Dec. 10 2020 ##

x <- read.table(file = "dec10.txt", sep = '\n')
x <- x[order(x[,1]),]
x <- c(0,x,max(x)+3)
other <- c(x[2:length(x)],0)  
diff <- other - x
length(diff[diff == 3])*length(diff[diff == 1])
