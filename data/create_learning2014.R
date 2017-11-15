#author: Hans Hellén
#14th Nov 2017
date()
#This is the data wrangling part of RStudio exercise 2. 
#
#The data (N=183) was collected by Kimmo Vehkalahti 
#from a course Introduction to Social Statistics between 3.12.2014–10.1.2015 
#for international survey of Approaches to Learning.

learning2014_full <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)
dim(learning2014_full)
str(learning2014_full)
#So, the learning2014_full data frame consists of 183 observations of 60 variables. 
#The variable gender is a factor (1="F"=female, 2="M"=male) and all others are numerical
# and in Likert scale except Age, Attitude and Points. 

#Let's then make some combination variables as described here: 
#http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt
#Questions related to the same dimensions: deep, surface or strategic learning methods.
#Let's make objects containing the related variables:
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

library(dplyr)
#Let's calculate the means of the related variables by first selecting 
#them to new objects and insert the means as a new column to the data frame:
deep_columns <- select(learning2014_full, one_of(deep_questions))
learning2014_full$deep <- rowMeans(deep_columns)
stra_columns <- select(learning2014_full, one_of(strategic_questions))
learning2014_full$stra <- rowMeans(stra_columns)
surf_columns <- select(learning2014_full, one_of(surface_questions))
learning2014_full$surf <- rowMeans(surf_columns)

#Let's check the data frame: 
str(learning2014_full)
#Let's rename the variables to be consistent with instructions of this exercise: 
colnames(learning2014_full)[57] <- "age"
colnames(learning2014_full)[58] <- "attitude"
colnames(learning2014_full)[59] <- "points"
#   Another option for renaming from dplyr: 
#   learning2014_full <- rename(learning2014_full, age = Age, attitude = Attitude, points = Points)
#Then the unnecessary columns are removed: 
analysis_colums <- c("gender","age","attitude", "deep", "stra", "surf", "points")
learning2014 <- select(learning2014_full, one_of(analysis_colums))
str(learning2014)

#Let's remove the observations where the exam points zero:
learning2014 <- filter(learning2014, points != 0)
str(learning2014)
#^As instructed, there are now 166 observations and 7 variables.

#Phase 4:
#getwd()
setwd("~/Github/IODS-project")

?write.csv
write.csv(learning2014, file = "data/learning2014.csv", row.names = FALSE, quote = TRUE, eol = "\n", fileEncoding = "UTF-8")

#Let's check that I can read the data:
read_test <- read.csv("data/learning2014.csv", header = TRUE)
str(read_test)
str(learning2014)
head(read_test)
head(learning2014)

#remove() can be used to remove objects. That is handy to clean up the project! 
remove(read_test)