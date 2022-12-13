## Solution to day 5 puzzle ##

## Prior to loading dataset into R, ran sed 's/ -> /,/g' raw.txt > test.txt in terminal to replace the ' -> ' with commas
values <- read.table("test.txt",sep = ',')

# Part 1 #

#Storing horizontal and vertical lines in their own tables
#transpose table so each column is composed of x1,y1,x2,y2
horizontals <- data.frame(t(values[values$V2 == values$V4,-2]))
verticals <- data.frame(t(values[values$V1 == values$V3,-3]))

# Generate diagram 
diagram <- matrix(data = 0,nrow = max(c(values$V2,values$V4))+1,ncol = max(c(values$V1,values$V3))+1)

# Function that reads diagram and updates values according to location of lines
update_diag <- function(x,vert = TRUE, tables,diag = FALSE){
  if (vert){
    for (i in 1:ncol(tables)){ # each line
      table <- tables[,i] 
      c <- table[1]+1
      start <- table[2]+1
      end <- table[3]+1
      x[start:end,c] <-  x[start:end,c] + 1 #increment all values on line
    }
    return(x) # return updated diagram
  }
  else if (diag){
    for (i in 1:ncol(tables)) {
      table <- tables[,i]
      xstart <- table[1]+1
      xend <- table[3]+1
      ystart <- table[2]+1
      yend <- table[4]+1
      diag(x[ystart:yend,xstart:xend]) <-  diag(x[ystart:yend,xstart:xend])+1 #identify diagonal by defining a sub-matrix in diagram and increment values
    }
    return(x)
  }
  else {
    for (i in 1:ncol(tables)){
      table <- tables[,i]
      c <- table[3]+1
      start <- table[1]+1
      end <- table[2]+1
      x[c,start:end] <-  x[c,start:end] + 1
    }
    return(x)
  }
}



new_diagram <- update_diag(diagram,tables = verticals)
new_diagram <- update_diag(new_diagram,tables = horizontals,vert = FALSE,diag = FALSE)

# Count number of points with 2 or more lines
length(new_diagram[new_diagram >= 2])

# Part 2 #

new_diagram <- update_diag(new_diagram,tables = diagonals,vert = FALSE,diag = TRUE)

length(new_diagram[new_diagram >= 2])



