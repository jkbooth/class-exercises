x  <- 3*4
x
this_is_long <- 2.5
this_is_long
this_is_long
thilsalong
This_Is_Long
seq(from = 1, to = 10)
#name = value form
seq(1,10)
1:10
#quick way to get a sequence of integers
one <- "hello world"
#assigning a string. Use double quotation marks
one
#in console, use arrow keys to cycle through recent commands
(one <- "hello world")
#surrounding an assignment with parentheses makes the assignment and prints it
date()
#automatically returns date and time
ls()
#gives list of objects
rm(this_is_long)
#removes object
rm(list = ls())
#removes all objects from environment
getwd()
#lists current working directory. Also always shown in top bar of console.
y <- seq(1,10)
(y <- seq(1,40))
a <- 2
b <- -3
sig_sq <- 0.5
x <- runif(40)
x <- a + b * x + rnorm(10, sd = sqrt(sig_sq))
(avg_x <- mean(x))
write(avg_x,"avg_x.txt")
plot(x,y)
abline(a, b, col = "purple")
dev.print(pdf, "toy_line_plot.pdf")
