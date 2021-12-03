## Solution to Day 3 Puzzle ##

# Part 1 #

#Function to identify most common binary number
modes <- function(x) {
  unique_x <- unique(x)
  tab <- tabulate(match(x, unique_x))
  if (length(unique_x[tab == max(tab)]) > 1){
    return("1")
  }
  else{
    unique_x[tab == max(tab)]
  }
}


x <- read.table(pipe("awk '{gsub(\"\",\" \", $1);print $1}' test.txt"))

#Identify mode of each column
x_list <- lapply(x,modes)

## Invert binary number to find epsilon rate
y_list <- ifelse(x_list == '0','1','0')

# convert binary numbers to string before converting to integer and calculating their product 
x_num <- paste(unlist(x_list),collapse = '')
y_num <- paste(unlist(y_list), collapse = '')
print(strtoi(x_num,base = 2)*strtoi(y_num,base = 2))


# Part 2 #

# Storing table of bits into two tables: one for oxygen rating and another for co2 rating
oxy <- x
co2 <- x
i <- 1
#Loop to run bit criteria through each column until only one binary number remains
while (nrow(oxy) > 1 && i <= ncol(x)){
  #ifelse command identifies each row that matches the bit criteria and uses this to subset the table
  oxy <- oxy[ifelse(oxy[,i] == modes(oxy[,i]),TRUE,FALSE),]
  i <- i + 1
}
#reset index
i <- 1
while (nrow(co2) > 1 && i <= ncol(x)){
  co2 <- co2[ifelse(co2[,i] != modes(co2[,i]),TRUE,FALSE),]
  i <- i + 1
}
##Convert number to string and then decimal to calculate product
oxy_num <- paste(unlist(oxy),collapse = '')
co2_num <- paste(unlist(co2), collapse = '')

print(strtoi(oxy_num,base = 2)*strtoi(co2_num,base = 2))
