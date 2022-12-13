## Solution to Day 14 Puzzle ##
# Execution time is ~ 0.92 seconds
library(tidyverse)
library(tictoc)


#Load in initial polymer and chart
input <- read.table("test.txt", skip = 2, sep = ',')
input2 <- file("test.txt","r")
polymer <- readLines(input2,n = 1)
close(input2)

## Build freq table
freq <- data.frame(matrix(data = 0, nrow = nrow(input),ncol = 2))
#Storing dimers (i.e.: "CH") and their two corresponding output dimers into the data frame
freq[,1] <- input$V1
freq$first <- str_c(str_sub(freq$X1,1,1),input$V2)
freq$second <- str_c(input$V2,str_sub(freq$X1,2,2))

#Storing first and last element of polymer for use in the monomer counting function
first <- str_sub(polymer,1,1)
last <- str_sub(polymer,str_length(polymer),str_length(polymer))





## Initial Frequency table of dimers in polymer
for (i in 1:str_length(polymer)-1){
  freq[freq$X1 == str_sub(polymer,i,i+1),2] <- as.numeric(freq[freq$X1 == str_sub(polymer,i,i+1),2])  + 1
}


#Step function to identify all output dimers based on prior instance of the polymer
shift <- function(table,change){
  temp <- table
  temp[,2] <- 0
  for (i in 1:nrow(change)){
    temp[temp$X1 == change[i,2] ,2] <- temp[temp$X1 == change[i,2] ,2] + change[i,1]
    temp[temp$X1 == change[i,3] ,2] <- temp[temp$X1 == change[i,3] ,2] + change[i,1]
  }
  return(temp)
}

#Function that runs the desired number of iterations of shift()
iterate <- function(table,steps){
  for (i in 1:steps){
    table <- shift(table,table[,2:4])
  }
  return(table)
}

# Function to count the occurence of each monomer/element
mono_count <- function(table,first,last){
  counts <- data.frame(matrix(data = 0,nrow = length(unique(input$V2)),ncol = 2))
  # Create a frequency table for all the elements found in our chart
  counts[,1] <- unique(input$V2)
  for (i in 1:nrow(counts)){
    #finds the sum of all the occurences of a dimer that includes the monomer
    #The sum is halved as every element is counted twice in this plot
    #An additional count is added to the sum if the monomer was at the start or end of the polymer for it to be counted twice like the other instances
    #the number of occurences for homo-dimers does not have to be changed (double the occurrence of homo-dimer to have number of monomers counted but then half it which negates the manipulation)
    counts[i,2] <- 0.5*(sum(table[str_count(table[,1],counts[i,1]) == 1,2]) + ifelse(counts[i,1] == first | counts[i,1] == last,1,0)) + table[str_count(table[,1],counts[i,1]) == 2,2]
  }
  return(counts)
}

tic()
# Part 1 #
new_freq <- iterate(freq,10)
elements <- mono_count(new_freq,first,last)
max(elements[,2]) - min(elements[,2])

# Part 2 #

#Changing Scientific notation settings to accommodate for AoC answer format
options("scipen"=100, "digits"=4)

new_freq <- iterate(freq,40)
elements <- mono_count(new_freq,first,last)
max(elements[,2]) - min(elements[,2])
toc()

#Reset scientific notation settings
options("scipen"=0, "digits"=7)

