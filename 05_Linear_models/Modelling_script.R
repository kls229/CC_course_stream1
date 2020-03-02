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

#An ANOVA is the same as a linear regression, but it measures the effect of a categorical explanatory variable on a continuous
# response variable. Running an ANOVA and linear regression will get the same p-value:

anova(apples_m)


# The assumptions of a linear model should be checked fist:

#1 Residuals are normally distributed:

apples_resid <- resid(apples_m)
shapiro.test(apples_resid)

#If P>0.05, there is no significant difference from a normal distribution

#2 Data is homoscedastic (variances not equal)

bartlett.test(apples$yield, apples$spacing2) # (The same as code below)
bartlett.test(yield ~ spacing2, data = apples)

#3 Observations are independent 

# If any of these are violated, may need to transform the data.

# Can examine the model fit further by looking at mroe plots:

plot(apples_m)

#This creates 4 plots: residuals, Q-Q, scale-location, cooks distance. 

##### Sheep

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

#Visualise the relationship:


(sheep.p <- ggplot(sheep, aes(x = weanage, y = weanwt)) +
    geom_point(aes(colour = sex)) +                                # scatter plot, coloured by sex
    labs(x = "Age at weaning (days)", y = "Wean weight (kg)") +
    stat_smooth(method = "lm", aes(fill = sex, colour = sex)) +    # adding regression lines for each sex
    scale_colour_manual(values = c("#FFC125", "#36648B")) +
    scale_fill_manual(values = c("#FFC125", "#36648B")) +
    theme.clean() )

# Generalised linear models ----

#Often in ecology, we have to use generalised linear model (not general), as data has different distributions e.g
# Poisson and binomial.

# Poisson distribution

# Using population trend data for the European Shag from the Living Planet Index
# Import the shagLPI.csv file from the project's directory
getwd()

shag <- shagLPI

str(shag)
shag$year <- as.numeric(shag$year)

#Histogram to assess distribution

(Shag.hist <- ggplot(shag, aes(pop)) + geom_histogram() + theme.clean())

# pop variable is count adundance i.e integers, so poisson distribution is appropriate.

shag.m <- glm(pop ~ year, family = poisson, data = shag)
summary(shag.m)

 # Shag abundance varies significantly based on the year

(shag.p <- ggplot(shag, aes(x = year, y = pop)) +
    geom_point(colour = "#483D8B") +
    geom_smooth(method = glm, colour = "#483D8B", fill = "#483D8B", alpha = 0.6) +
    scale_x_continuous(breaks = c(1975, 1980, 1985, 1990, 1995, 2000, 2005)) +
    theme.clean() +
    labs(x = " ", y = "European Shag abundance"))


# ---- Model with binomial distribution
# Binomial distribution

# Using a dataset on weevil damage to Scott's pine
# Import the Weevil_damage.csv file from the project's directory

weevil <- Weevil_damage
str(Weevil)
weevil$block <- as.factor(weevil$block)

weevil.m <- glm(damage_T_F ~ block, family = binomial, data = weevil)
summary(weevil.m)

# Probability of pine tree enduring damage does vary significantly based on block tree is located in, but it's not a linear relationship!
# The bigger the reduction in deviance, the better job the model is doing. 



