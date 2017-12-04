#libraries to be available if needed:
library(dplyr)
library(GGally)
library(tidyr)
library(ggplot2)
#Let's get “Human development” (hd) and “Gender inequality” (gii) datas into R:
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
#Information about the data can be found here: http://hdr.undp.org/en/content/human-development-index-hdi 
# Some technical notes here: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
str(hd)
head(hd$Country, n=8)
summary(hd)
#
str(gii)
head(gii$Country, n=9)
summary(gii)
#renaming of variables:
colnames(hd)
#"HDI" = Human.Development.Index..HDI.
#"Life" = Life expectancy at birth
#"Exp.Edu" = Expected years of schooling 
#"Mean.Edu" = Mean.Years.of.Education"
#"GNI" = Gross.National.Income..GNI..per.Capita
#"GNI-HDI.Rank" = GNI.per.Capita.Rank.Minus.HDI.Rank
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life"
colnames(hd)[5] <- "Exp.Edu"
colnames(hd)[6] <- "Mean.Edu"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI-HDI.Rank"
colnames(gii)
# Original variable names:
# [3] "Gender.Inequality.Index..GII."               
# [4] "Maternal.Mortality.Ratio"                    
# [5] "Adolescent.Birth.Rate"                       
# [6] "Percent.Representation.in.Parliament"        
# [7] "Population.with.Secondary.Education..Female."
# [8] "Population.with.Secondary.Education..Male."  
# [9] "Labour.Force.Participation.Rate..Female."    
# [10] "Labour.Force.Participation.Rate..Male."      
# New names: 
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MMR"
colnames(gii)[5] <- "ABR"
colnames(gii)[6] <- "PRF"
colnames(gii)[7] <- "SEF"
colnames(gii)[8] <- "SEM"
colnames(gii)[9] <- "LFPRF"
colnames(gii)[10] <- "LFPRM"
#Mutating variables:
#"ratio of Female and Male populations with secondary education in each country"
#SEF_per_SEM = gii$SEF/gii$SEM
#another mutation:
#"ratio of labour force participation of females and males in each country"
#LFPRF_per_LFPRM = gii$LFPRF/gii$LFPRM
#Then let's insert the two new variables to data frame gii
gii <- mutate(gii, LFPRF_per_LFPRM = LFPRF/LFPRM, SEF_per_SEM = SEF/SEM)
str(gii)
gii2$SEF_per_SEM
head(gii$SEF_per_SEM)
head(gii$SEF)
head(gii$SEM)

## Just a note here, if needed later: remove original VAR from the dataset; 
#note that here "select" is used from a package dplyr. 
##DATAFRAME <- dplyr::select(DATAFRAME, -VAR)
glimpse(hd)
#Let's use inner join to combine the data frames hd and gii using countries as a nominator:
human <- inner_join(hd, gii, by = hd$Country)
colnames(human)
glimpse(human)

#Finished wrangling:
write.csv(human, file = "data/human.csv", row.names = FALSE, quote = TRUE, eol = "\n", fileEncoding = "UTF-8")
#reading test:
read_test <- read.csv("data/human.csv", header = TRUE)
str(read_test)
str(human)
head(read_test)
head(human)
remove(read_test)