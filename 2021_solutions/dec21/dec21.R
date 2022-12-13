### Solution Day 21 Puzzle ###
options(scipen = 1000, digits = 4)



#Use modulo 10 to create a circular list and die rolls
#to make this work need to swap out any 0 (100%%100) with 100 for die roll and 10 for space on board

roll_die <- function(cur){
  rolls <- c(cur,cur+1,cur+2)%%100
  rolls <- ifelse(rolls == 0,100,rolls)
  return(sum(rolls))
}

move_pawn <- function(p,roll){
  p <- (p+roll)%%10
  p <- ifelse(p == 0,10,p)
  return(p)
}

play <- function(die,p){
  rolls <- roll_die(die)
  space <- move_pawn(p,rolls)
  return(space)
}

dirac <- function(p1,p2){
  turns <- 0
  dice <- 1 
  s1 <- 0
  s2 <- 0
  while (TRUE) {
    p1 <- play(dice,p1)
    s1 <- s1 + p1
    dice <- dice + 3
    if (s1 >= 1000){break}
    p2 <- play(dice,p2)
    s2 <- s2 + p2
    dice <- dice + 3
    turns <- turns + 1 
    if (s2 >= 1000){break}
  }
  return(ifelse(s1 >= 1000,s2*(dice-1),s1*(dice-1)))
}

# Part 1
dirac(6,10)

# Part 2

tally <- data.frame(matrix(data = 0, nrow = 1, ncol =2))
colnames(tally) <- c("P1", "P2")


death_by_dirac <- function(p1,p2,s1,s2,p1turn = TRUE, mod = 1){
  if (s1 >= 21){
    tally$P1 <- tally$P1 + 1
    return()
  }
  else if (s2 >= 21){
    tally$P2 <- tally$P2 + 1
    return()
  }
  
  if (p1turn){
    
  }
  
  else {
    
  }
}
