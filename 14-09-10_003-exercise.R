#intro to R objeccts
(x <- 3 * 4)
is.vector(x)
#asks whether object is vector
length(x)
#returns length of vector
x[2] <- 100
#assigns value 100 to second element of item x
x
x[5] <- 3
x
#YOU CAN DO THAT
x[0]
#indexing begins at 1
(x <- 1:4)
x^2
y <- 1:3
#operates on each element in the vector
z <- vector(mode = mode(x), length = length(x))
for(i in seq_along(x)){
  z[i] <- x[i]^2
}
#I don't know what this is, come back to it
identical(y,z)
set.seed(1999)
rnorm(5, mean = 10^(1:5))
#generates normally distributed random numbers with assigned mean and sd
#sd defaults to 1
(y <- 1:3)
(z <- 3:7)
y+z
#when vectors are of different length, calculations recycle back to [1] in the shorter
(z <- 2:13)
y*z
#no warning is returned if the length of one vector is a multiple of the other
x <- c("hello", "world")
x
str(x)
# STRUCTURE should return characters, length, content of variable
y <- c(1:3, 100, 150)
y
str(y)
(x <- c("cabbage", pi, TRUE, 4.3))
#makes a character vector, because that's the only compatible option
str(x)
(n <- c("string", -3, rnorm))
str(n)
str(x)
length(x)
mode(x)
class(x)
n <- 8
set.seed(1)
(w <- round(rnorm(n), 2))
#numeric floating point
n
(x <- 1:n)
#numeric integer
(y <- LETTERS[1:n])
(z <- runif(n)>0.3)
str(z)
str(w)
length(x)
is.logical(y)
as.numeric(z)
#wrangles true and false into 1 and 0
str(z)
w
names(w) <- letters[seq_along(w)]
#names the items within a vector as letters in order
w<0
#returns true or false for all values within w less than 0
which(w<0)
#returns which values within w are less than 0
w[w<0]
seq(from = 1, to = length(w), by=2) 
#returns which items within variable
w[seq(from = 1, to = length(w), by = 2)]
#returns the actual values
w[-c(2,5)]
#allows you to exclude defined items
w[c('c', 'a', 'f')]

a <- list(veg = "cabbage", dessert = pi, myAim = TRUE, number = 4.3)
#indexes a list
names(a)
#returns the names of the indices
(a <- list(veg = c("cabbage", "eggplant"),
           tNum = c(pi, exp(1), sqrt(2)),
           myAim = TRUE,
           joeNum = 2:6))
str(a)

a[[2]]
#index with a positive integer
a$myAim
str(a$myAim)


##creating a data.frame explicitly
set.seed(1)
(jDat <- data.frame(w = round(rnorm(n), 2),
                    x = 1:n,
                    y = I(LETTERS[1:n]),
                    z = runif(n) > 0.3,
                    v = rep(LETTERS[9:12], each = 2)))
str(jDat)
mode(jDat)
class(jDat)
is.list(jDat)
jDat[5]
jDat$v
jDat[c("x", "z")]

(x <- c("cabbage", pi, T, 4.3))
str(x)

n <- 8
set.seed(1)
(w <- round(rnorm(n), 2))
(x <- 1:n)
(y <- LETTERS[1:n])
(z <- runif(n)>0.3)
?runif
str(w)
is.logical(y)
as.numeric(z)
(znum <- as.numeric(z))
str(znum)

names(w) <- letters[seq_along(w)]
str(w)
w<0
which(w>0)
w[w>0]
seq(from = 1, to = length(w), by = 2)
w[seq(from = 1, to = length(w), by = 2)]
w[-c(2, 5)]
w[c('c', 'a', 'f')]


(a <- list("cabbage", pi, T, 4.3))
str(a)
mode(a)
class(a)
names(a)
names(a) <- c("veg", "dessert", "myAim", "number")
a

a <- list(veg = "cabbage", dessert = pi, myAim = T, number = 4.3)
names(a)

(a <- list(veg = c("cabbage", "eggplant"),
          tNum = c(pi, exp(1), sqrt(2)),
          myAim = T,
          joeNum = 2:6))
str(a)

a[[2]]
a[2]
a$myAim
str(a$myAim)
a[["tNum"]]

iWantThis <- "joeNum"
a[[iWantThis]]
a[[c("joeNum", "veg")]]

names(a)
a[c("tNum", "veg")]


set.seed(1)
(jDat <- data.frame(w = round(rnorm(n), 2),
                    x = 1:n,
                    y = I(LETTERS[1:n]),
                    z = runif(n) > 0.3,
                    v = rep(LETTERS[9:12], each = 2)))
str(jDat)
is.list(jDat)
jDat[[5]]
jDat$v

identical(subset(jDat, select = c(x, z)), jDat[c("x", "z")])

(qDat <- list(w = round(rnorm(n), 2),
              x = 1:(n-1),
              y = I(LETTERS[1:n])))
as.data.frame(qDat)
qDat$x <- 1:n
qDat <- as.data.frame(qDat)


jMat <- outer(as.character(1:4), as.character(1:4),
              function(x,y) {
                paste0('x', x, y)
              })
jMat
str(jMat)
rownames(jMat)
rownames(jMat) <- paste0("row", seq_len(nrow(jMat)))
colnames(jMat) <- paste0("col", seq_len(ncol(jMat)))
colnames(jMat)
dimnames(jMat)
jMat[2, 3]
jMat[2, ]
is.vector(jMat[2, ])
jMat[ , 3, drop = F]
dim(jMat[ , 3, drop = F])
