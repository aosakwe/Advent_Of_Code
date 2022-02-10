### Solution to Day 16 Puzzle ###
library(tidyverse)


key <- read.table("key.txt", sep = "=", colClasses = "character")
bits <- read.table("test.txt")[[1]]


# hexadecimal to binary
binary <- c()
for (i in 1:str_length(bits)){
  binary <- c(binary,key[key$V1 == str_sub(bits,i,i),2])
}
binary <- paste(binary, collapse = '')


# helper function
bin2dec <- function(x){
  dec <- 0
  for (i in str_length(x):1){
    dec <- dec + (2**(str_length(x)-i))*as.numeric(str_sub(x,i,i))
  }
  return(dec)
}


#Parses binary BITS transmisison to find sum of version numbers (Part 1)
parse_bin <- function(bin){
  ver <- bin2dec(str_sub(bin,1,3))
  # For length in operator packets
  if (bin2dec(str_sub(bin,4,6)) != 4){
    if (as.numeric(str_sub(bin,7,7)) == 0){
      length <- bin2dec(str_sub(bin,8,22))
      ver <- ver + parse_bin(str_sub(bin,23,22+length))
      if (22 + length != str_length(bin) & (str_length(bin) - (22+ length)) >= 11){
        ver <- ver + parse_bin(str_sub(bin,23+length,str_length(bin)))
      }
    }
    else {
      num_packs <- bin2dec(str_sub(bin,8,18))
      start = 19
      ver <- ver + parse_bin(str_sub(bin,start,str_length(bin)))
      
    }
  }
  
  ## For literal packets
  else if (bin2dec(str_sub(bin,4,6)) == 4){
    x <-  as.numeric(str_sub(bin,7,7))
    i <-  7
    out <- ''
    while (TRUE){
      if (as.numeric(str_sub(bin,i,i)) == 0){
        out <- str_c(out,str_sub(bin,i+1,i+4))
        break
      }
      out <- str_c(out,str_sub(bin,i+1,i+4))
      x <- as.numeric(str_sub(bin,i+5,i+5))
      i <- i+5
      if (x == 0){
        out <- str_c(out,str_sub(bin,i+1,i+4))
        break
      }
    }
    if (i + 4 != str_length(bin) & (str_length(bin) - (i+4)) >= 11){
      ver <- ver + parse_bin(str_sub(bin,i+5,str_length(bin)))
    }
    return(ver)
  }
  
  return(ver)
}


# Find literal value
compute_lit <- function(bin){
  x <-  as.numeric(str_sub(bin,7,7))
  i <-  7
  out <- ''
  packs <- c()
  while (TRUE){
    if (as.numeric(str_sub(bin,i,i)) == 0){
      out <- str_c(out,str_sub(bin,i+1,i+4))
      break
    }
    out <- str_c(out,str_sub(bin,i+1,i+4))
    x <- as.numeric(str_sub(bin,i+5,i+5))
    i <- i+5
    if (x == 0){
      out <- str_c(out,str_sub(bin,i+1,i+4))
      break
    }
  }
  packs <- c(packs,bin2dec(out))
  if (i + 4 != str_length(bin) & (str_length(bin) - (i+4)) >= 11){
    packs <- c(packs,compute_bin(str_sub(bin,i+5,str_length(bin))))
  }
  return(packs)
}

operate <- function(values,op){
  if (op == 0){ return(sum(values))}
  else if (op == 1){
    out <- 1
    for (i in 1:length(values)){
      out <- out*values[i]
    }
    return(out)
  }
  else if (op == 2){ return(min(values))}
  else if (op == 3){ return(max(values))}
  else if (op == 5){return(ifelse(values[1] > values[2],1,0))}
  else if (op == 6){return(ifelse(values[1] > values[2],0,1))}
  else if (op == 7){return(ifelse(values[1] == values[2],1,0))}
}
# Function to solve BITS transmission
#Similar to parse_bin, now need to identify operator values and their subsequent packets recursively and return those values
#will use a list to store the literal values of a packet
options(scipen = 9999, digits = 4)
compute_bin <- function(bin){
  if (str_length(bin) < 11){
    return()
  }
  op <- bin2dec(str_sub(bin,4,6))
  if (op != 4){
    vals <- c() #store all literal values to operate on
    if (as.numeric(str_sub(bin,7,7)) == 0){
      length <- bin2dec(str_sub(bin,8,22))
      vals <- c(vals,compute_bin(str_sub(bin,23,22+length)))
      if (22 + length != str_length(bin) & (str_length(bin) - (22+ length)) >= 11){
        #vals <- c(vals,compute_bin(str_sub(bin,23+length,str_length(bin))))
        return(c(operate(vals,op),compute_bin(str_sub(bin,23+length,str_length(bin)))))
      }
    }
    else {
      num_packs <- bin2dec(str_sub(bin,8,18))
      start = 19
      vals <- c(vals,compute_bin(str_sub(bin,start,str_length(bin))))
      if (length(vals) > num_packs){
        return(c(operate(vals[1:num_packs],op),vals[(num_packs+1):length(vals)]))
      }
    }
    return(operate(vals,op))
  }
  else if (op == 4){
    return(compute_lit(bin))
  }
}


#Part 1
parse_bin(binary)

#Part 2
#binary <- test
compute_bin(binary)



# 
# 
# bits <- c("C200B40A82","04005AC33890","880086C3E88112","CE00C43D881120","D8005AC2A8F0","F600BC2D8F","9C005AC2F8F0","9C0141080250320F1802104A08")
# 
# for (bit in bits){
#   binary <- c()
#   for (i in 1:str_length(bit)){
#     binary <- c(binary,key[key$V1 == str_sub(bit,i,i),2])
#   }
#   binary <- paste(binary, collapse = '')
#   
#   print(compute_bin(binary))
# }

test <- binary
bit <- "22008b80230a440118530e604"
binary <- c()
for (i in 1:str_length(bit)){
  binary <- c(binary,key[key$V1 == str_sub(bit,i,i),2])
}
binary <- paste(binary, collapse = '')
compute_bin(binary)

me <- 911945516456
real <- 911945136934
me - real


bits

