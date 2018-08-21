library(tidyr)
library(dplyr)
health_charges <- read.csv("capstone_data.csv", header = TRUE)

#Clean up your column names to be simple, short and descriptive
colnames(health_charges)[3] <- "bmi_(weight/height^2)"
summary(health_charges)

#For each column:
#Check for missing values and decide what you want to do about them.
summary(health_charges == "")
summary(is.na.data.frame(health_charges)) 

#Make sure the values in each column make sense. If you find values that don't, decide what you want to do about those.
#***I'll re-examine column 3 and column 7 because of the large number of unique strings.***
unique(health_charges[,1])
unique(health_charges[,2])
unique(health_charges[,3])
unique(health_charges[,4])
unique(health_charges[,5])
unique(health_charges[,6])
unique(health_charges[,7])

#Look for outliers (values that are too small or too large). Do they make sense? Do you want to keep them in the data set?
#***The 25 highest and lowest values look reasonable for the two variables with the widest range.***
head(sort(health_charges$`bmi_(weight/height^2)`), n=25)
tail(sort(health_charges$`bmi_(weight/height^2)`), n=25)
head(sort(health_charges$charges), n=25)
head(sort(health_charges$charges), n=25)

summary(health_charges)
View(health_charges)
  
write.csv(health_charges, "health_charges_clean821.csv")
  