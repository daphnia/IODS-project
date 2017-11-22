#author: Hans Hellén
#date() "Tue Nov 21 15:37:44 2017"
#This is the data wrangling part of RStudio exercise 3 (IODS course at Uni Helsinki) 
#using data about student alcohol consumption researched among 
#students in mathematics and Portugal language courses. 
#The variables are explained here at the source of data: 
#https://archive.ics.uci.edu/ml/datasets/Student+Performance
setwd("~/Github/IODS-project")
mat <- read.csv("data/student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("data/student-por.csv", sep = ";", header = TRUE)

str(mat)
str(por)
summary(mat)
summary(por)
#^The dimensions of data frame from math course consists of 395 
#observations (rows) of 33 variables (colums). 
#All the variables' values are integers or factors.
library(dplyr)
#Let's choose background variables that are to be used to identify 
#the observations to be from the same student:
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
#Let's use suffixes ".math" and ".por" to mark the source data.frame and 
#use inner join to include only the students who answered the both course 
#questionaires (retain only rows with matches):
math_por <- inner_join(mat, por, by = join_by, suffix = c(".math", ".por"))
colnames(math_por)
str(math_por)
#^So, now there might be duplicated answers in the joined data, 
#if student has answered differently in two questionaires. To fix this, 
#let's use programming to combine these 'duplicated' answers by either:
#1) taking the rounded average (if the two variables are numeric)
#2) simply choosing the first answer (else).
#Let's create a new data frame called alc, first only out of the joined columns:
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
notjoined_columns
##The following programming is from the course DataCamp:
#for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
#Phase 6: the averaged alcohol consumption and high usage defined:
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
glimpse(alc)
#Finished wrangling:
write.csv(alc, file = "data/student_alc_analysis.csv", row.names = FALSE, quote = TRUE, eol = "\n", fileEncoding = "UTF-8")
#reading test:
read_test <- read.csv("data/student_alc_analysis.csv", header = TRUE)
str(read_test)
str(alc)
head(read_test)
head(alc)
remove(read_test)