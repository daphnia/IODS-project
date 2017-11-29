#Coming soon... maybe later...
#Let's get “Human development” (hd) and “Gender inequality” (gii) datas into R:
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
help(mean)
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
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life"
colnames(hd)[5] <- "Exp.Edu"
colnames(hd)[6] <- "Mean.Edu"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI-HDI.Rank"
colnames(gii)
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MMR"
colnames(gii)[5] <- "ABR"
colnames(gii)[6] <- "PRF"
colnames(gii)[7] <- "SEF"
colnames(gii)[8] <- "SEM"
colnames(gii)[9] <- "LFPRF"
colnames(gii)[10] <- "LFPRM"
#Mutating variables:
#edu2F / edu2M
SEF_per_SEM <- gii$SEF/gii$SEM
head(SEF_per_SEM)
head(gii$SEF)
head(gii$SEM)
#another mutation:
#labF / labM
LFPRF_per_LFPRM <- gii$LFPRF/gii$LFPRM
#Then let's insert the two new variables to data.frame gii
gii <- data.frame(gii, SEF_per_SEM, LFPRF_per_LFPRM)
## If needed: remove original VAR from the dataset; 
#note that here "select" is used from a package dplyr. 
##DATAFRAME <- dplyr::select(DATAFRAME, -VAR)
glimpse(hd)
#Let's use inner join to include only the countries in both datasets (retain only rows with matches):
join_by2 <- hd$Country
human <- inner_join(hd, gii, by = gii$Country)
#^EI SKULAA JOSTAIN SYYSTÄ?!
colnames(human)
str(human)
glimpse(join_by2)
