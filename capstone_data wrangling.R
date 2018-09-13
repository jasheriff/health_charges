library(tidyr)
library(dplyr)
health_charges <- read.csv("capstone_data.csv", header = TRUE)
str(health_charges)

#Created new bmi_factor column 
health_charges <- health_charges %>% 
  mutate(bmi_factor = if_else ( bmi < 18.5, "underweight",
         if_else ( bmi >= 18.5 & bmi < 25, "healthy_weight", 
         if_else ( bmi >= 25 & bmi < 30, "overweight",
         if_else ( bmi >= 30, "obese", NA_character_)))))

health_charges$bmi_factor <- factor(health_charges$bmi_factor, 
                      levels = c("underweight", "healthy_weight", "overweight", "obese"),
                      ordered = TRUE)

health_charges <- health_charges[ , c(1:3, 8, 4:7)]

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
unique(health_charges[,8])

#Look for outliers (values that are too small or too large). Do they make sense? Do you want to keep them in the data set?
#***The 25 highest and lowest values look reasonable for the two variables with the widest range.***
head(sort(health_charges$bmi), n=25)
tail(sort(health_charges$bmi), n=25)
head(sort(health_charges$charges), n=25)
head(sort(health_charges$charges), n=25)

health_charges_clean <- health_charges
summary(health_charges_clean)
View(health_charges_clean)
  
write.csv(health_charges_clean, "health_charges_clean.csv")
  
