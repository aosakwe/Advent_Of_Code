## Solution to Day 10 Puzzle ##

input <- read.table("test.txt")

corrupt_score <- 0
missing_scores <- c()
for (row in 1:nrow(input)){
  chunk <- input[row,]
  corrupt <- FALSE
  x <- ''
  missing_score <- 0
  for (i in 1:str_length(chunk)){
    if (str_sub(chunk,i,i) == '<' | str_sub(chunk,i,i) == '{' | str_sub(chunk,i,i) == '[' | str_sub(chunk,i,i) == '(' ){
      x <- c(x,str_sub(chunk,i,i))
    }
    else {
      if (str_sub(chunk,i,i) == '>'){
        if (x[length(x)] == '<'){
          x <- x[1:length(x)-1]
        }
        else{
          corrupt <- TRUE
          corrupt_score <- corrupt_score + 25137
          break
        }
      } 
      else if (str_sub(chunk,i,i) == '}'){
        if (x[length(x)] == '{'){
          x <- x[1:length(x)-1]
        }
        else{
          corrupt <- TRUE
          corrupt_score <- corrupt_score + 1197
          break
        }
      }
      else if (str_sub(chunk,i,i) == ']'){
        if (x[length(x)] == '['){
          x <- x[1:length(x)-1]
        }
        else{
          corrupt <- TRUE
          corrupt_score <- corrupt_score +57
          break
        }
      }
      else if (str_sub(chunk,i,i) == ')'){
        if (x[length(x)] == '('){
          x <- x[1:length(x)-1]
        }
        else{
          corrupt <- TRUE
          corrupt_score <- corrupt_score + 3
          break
        }
      }
    }
  }
  if (!corrupt & length(x) > 1){
     for (i in length(x):2){
       if (x[i] == "("){
         missing_score <- 5*missing_score + 1
       }
       else if(x[i] == "["){
         missing_score <- 5*missing_score + 2
       }
       else if(x[i] == "{"){
         missing_score <- 5*missing_score + 3
       }
       else if(x[i] == "<"){
         missing_score <- 5*missing_score + 4
       }
     }
    missing_scores <- c(missing_scores,missing_score)
  }
}
corrupt_score
missing_scores <- sort(missing_scores)
missing_scores[(length(missing_scores)+1)/2]

