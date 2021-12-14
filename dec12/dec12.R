## Solution to Day 12 Puzzle ##
#Execution time is ~ 32.34 seconds in total
#Need to find a more efficient algorithm 


library(stringr)
library(tictoc)


input <- read.table("test.txt",sep = '-')



# Part 1 #

pathfinder <- function(cur_path,visited = c("start"),paths,count = 0){
  cur <- cur_path[length(cur_path)]
  if (cur == "end"){
    #print(paste(cur_path,collapse = "-"))
    return(1)
  }
  #store the options from your given position
  choices <- c(paths[paths[,1] == cur,2],paths[paths[,2] == cur,1])
  for (choice in choices){
    #if the choice is a lowercase AND has not been visited yet
    if (str_to_upper(choice) != choice & length(visited[visited == choice]) == 0 ){
      count <- count + pathfinder(c(cur_path,choice),visited = c(visited,choice),paths)
    }
    else if (str_to_upper(choice) == choice) {
      count <- count  +pathfinder(c(cur_path,choice),visited = c(visited,choice),paths)
    }
  }
  return(count)
}


# Part 2 #

outlander <- function(cur_path,visited = c("start","start"),paths,count = 0,revisited = FALSE){
  cur <- cur_path[length(cur_path)]
  if (cur == "end"){
    #print(paste(cur_path,collapse = ","))
    return(1)
  }
  #store the options from your given position
  choices <- c(paths[paths[,1] == cur,2],paths[paths[,2] == cur,1])
  for (choice in choices){
    #if the current choice is a small cave
    if (str_to_upper(choice) != choice){
      #If we have already wandered then we only go to small caves we have not visited
      if (revisited & length(visited[visited == choice]) == 0 ){
        count <- count + outlander(c(cur_path,choice),visited = c(visited,choice),paths,revisited = TRUE)
      }
      #If we are yet to revisit a small cave and the current small cave has been visited
      else if (!revisited & length(visited[visited == choice]) == 1){
        count <- count + outlander(c(cur_path,choice),visited = c(visited,choice),paths,revisited = TRUE)
      }
      else if (length(visited[visited == choice]) == 0){
        if (revisited){
          count <- count + outlander(c(cur_path,choice),visited = c(visited,choice),paths,revisited = TRUE)
        }
        else{
          count <- count + outlander(c(cur_path,choice),visited = c(visited,choice),paths)
        }
      }
      
    }
    #if the next choice is a large cave
    else if (str_to_upper(choice) == choice) {
      if (revisited){
        count <- count  +outlander(c(cur_path,choice),visited = c(visited,choice),paths,revisited = TRUE)
      }
      else{
        count <- count  +outlander(c(cur_path,choice),visited = c(visited,choice),paths)
      }
    }
  }
  return(count)
}

tic()
pathfinder(c("start"),visited = c("start"),paths = input)
outlander(c("start"),paths = input)
toc()


