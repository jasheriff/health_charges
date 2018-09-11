library(ggplot2)
library(quantreq)

str(health_charges_clean)
    
#age: disporportionately high number of 18-19 ages; otherwise, even age distribution 
ggplot(health_charges_clean, aes(age))+
  geom_histogram(binwidth = 1)+
  coord_cartesian(xlim = c(18, 64))+
  theme_bw()

#sexes: even distribution
ggplot(health_charges_clean, aes(sex))+
  geom_bar()

#bmi: approximately normal distribution.
#The center of the data is at the cut-off between overweight and obese.
#The collection of obese observations is approximately equal to the sum of non-obese observations. 
ggplot(health_charges_clean, aes(bmi)) +
  geom_histogram(binwidth = 1)+
  coord_cartesian(xlim = c(15, 54))

#children: skewed right
ggplot(health_charges_clean, aes(children))+
  geom_bar()+
 
#smoker: ratio of non-smokers to smokers: 4 : 1
ggplot(health_charges_clean, aes(smoker))+
  geom_bar()
summary(health_charges_clean$smoker)


#region: all regions except southeast had between 324-325 observations.
    #perhaps cluster sampling was used for data collection
ggplot(health_charges_clean, aes(region))+
  geom_bar()
summary(health_charges_clean$region)

#charges: skewed right (strong)
ggplot(health_charges_clean, aes(charges)) +
  geom_area(stat = "bin")

health_charges_clean$children <- as.factor(health_charges_clean$children)

#bmi_factor:
#Charges tend to increase with higher BMIs.
#There is a positive linear correlation between charges and bmi up to 35.
#There is no meaningful correlation between charges and bmis above 35.
ggplot(health_charges_clean, 
       aes(x = bmi, y = charges, color = bmi_factor, alpha = .005 ))+
  geom_point() +
  geom_jitter() +
  geom_smooth (method = "loess", color = "black")


#Women do not have higher health charges than men with higher numbers of children. 
ggplot(health_charges_clean, aes(x = children, y = charges, color = sex)) +
  geom_bar(stat = "identity", aes(color = sex, fill = sex), 
           width = .7, position = "dodge")


#Smokers have higher charges than non-smokers.
#Smokers see a strong positive correlation between a higher BMI and charges.
#Obese smokers have higher charges than most non-smokers of all BMIs.
ggplot(health_charges_clean, aes(x = age, y = charges, color = bmi_factor), alpha = .02, size = .02) +
  geom_point(aes(color = bmi_factor, fill = bmi_factor))+
  facet_grid( . ~ smoker)+
  geom_smooth(se = FALSE, method = "loess", weight = .005, color = "black", alpha = .02 )


#There were no underweight observations in the southeast region.
#BMI is a stronger indicator for health charges in the south than in the north.
ggplot(health_charges_clean, aes(x = region, y = charges, color = bmi_factor))+
  geom_bar(stat = "identity", position = "dodge", 
           aes(color = bmi_factor, fill = bmi_factor), width = .7)
    