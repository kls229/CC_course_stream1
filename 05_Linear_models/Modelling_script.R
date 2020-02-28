############################################################
#                                                          #
#                Coding Club 01-03-2017                    #
# Practicing modelling using  different data distributions #
#                                                          #
############################################################


# This is a sample script outlining the different tasks for this tutorial
# Edit this script to add in your own code

# Libraries ----
library(lme4)
library(ggplot2)

# Defining a ggplot2 theme we will use for plotting later
theme.clean <- function(){
  theme_bw()+
    theme(axis.text.x=element_text(size=12, angle=45, vjust=1, hjust=1),
          axis.text.y=element_text(size=12),
          axis.title.x=element_text(size=14, face="plain"),             
          axis.title.y=element_text(size=14, face="plain"),             
          panel.grid.major.x=element_blank(),                                          
          panel.grid.minor.x=element_blank(),
          panel.grid.minor.y=element_blank(),
          panel.grid.major.y=element_blank(),  
          plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm"),
          plot.title = element_text(size=20, vjust=1, hjust=0.5),
          legend.text = element_text(size=12, face="italic"),          
          legend.title = element_blank(),                              
          legend.position=c(0.9, 0.9))
}

# Load data ----

# For a simple linear model

install.packages("agridat")
library(agridat)

# Using a sample dataset from the agridat package

apples <- agridat::archbold.apple
apples
str(apples)
apples$spacing2 <- as.factor(apples$spacing) #Creates a new column with tree spacing as factor instead of integer 


library(ggplot2)


# A simple linear model ----
(apples_p <- ggplot(apples, aes(spacing2, yield)) + geom_boxplot(fill = "#CD3333", alpha = 0.8, colour = "#8B2323") + theme.clean() + theme(axis.text.x = element_text(size = 12, angle = 0)) + labs(x = "Spacing (m)", y = "Yield (kg)"))

# Hard to tell if tree spacing causes significant changes in apple yield from boxplot alone, so we can use a model to test:

apples_m <- lm(yield ~ spacing2, data = apples)
summary(apples_m)

# The yield IS significantly different ~ p <0.05, varaince explained by predictor 15% of the time: It is significant but maybe not 
# that important compared to other variables we could test for.

#Sapcing was a categorical variable, so output gives the yield estimate (mean) for each level of spacing (intercept is reference level)

# Generalised linear models ----

sheep <- agridat::ilri.sheep
library(dplyr) 
sheep <- filter(sheep, ewegen == "R") #Lambs from mothers that come from breed "R"
head(sheep)

(sheep.m1 <-lm(weanwt ~ weanage, data = sheep))
summary(sheep.m1)

# weange is continuous variable, so intercept is value of Y when X is 0. In this case, intercept is lamb weight at birth.
# Weanage estimate is increase in weight per day (slope)
# Age at weaning explains 20% of lamb weight and this is significant P<0.001

#New model also including sex

(sheep_m2 <- lm(weanwt ~ weanage*sex, data = sheep))
summary(sheep_m2)

#Female will be refernce group and male will be shown seperately. Values for male will be shown as difference between reference
# and their own intercept/slope


# Using population trend data for the European Shag from the Living Planet Index
# Import the shagLPI.csv file from the project's directory










# Using a dataset on weevil damage to Scott's pine
# Import the Weevil_damage.csv file from the project's directory





# Poisson distribution

# Binomial distribution