## Solution to Day 25 Puzzle ##
library(tidyverse)
library(tictoc)

grid <- read.table("mini_test.txt")
grid <- as.matrix(grid)
grid <- data.frame(t(sapply( grid, function(a) unlist(strsplit(a,"")))), row.names = NULL)
