##%######################################################%##
#                                                          #
####   Challenge yourself -  Tooth growth               ####
#                                                          #
##%######################################################%##


# 1 Are higher doses of vit C beneficial for tooth growth?
#2 Does method of administration influence effect of dose
#3 Whats the predicted tooth legth of a guinea pig given 1 mg of vit C as absorbic acid.

ToothGrowth
ToothGrowth <- datasets::ToothGrowth
str(ToothGrowth)
ToothGrowth$dose <- as.factor(ToothGrowth$dose) # Need to change dosage into a factor so we can compare them later on

#For question 1, I can used simple linear regression:

#boxplot:

boxplot(len ~ dose, data=ToothGrowth, main = "Guinea pig tooth growth with Vitamin C", xlab= "VItamin C dosage", ylab = "Tooth length mm")

#OR.... 

ggplot(ToothGrowth, aes(x=dose, y = len, fill = supp)) + geom_boxplot()

# Looks like they will be significant, but we can check with a model:

toothgrowth_m <- lm(len ~ dose, data = ToothGrowth)
summary(toothgrowth_m)

# P<0.001 - tooth length does vary significantly with dosage, explains 77% of variance.
# 0.5 dose = 10.6, 1 dose = 10.6 + 9.13, dose 2 = 10.6 + 15.49

# Could also do an ANOVA:

tooth.m <- lm(len ~ dose*supp, data = ToothGrowth)
summary(tooth.m)


### Quesion 2:

(ToothGrowth_m2 <- lm(len ~ dose*supp, data = ToothGrowth))
summary(ToothGrowth_m2)


# Shows that OJ is better than VC and this is significant, highest dose of vc is better than smallest dose of oj - YES! checked with thr boxplot.


# Question three:

13.230 + 9.47 (extra growth for 1mg oj) - 5.25 (as its VC not OJ) - 0.68 (differnce in growth for the interaction between 1.0 and VC treatment)

# guinea pig given 1mg of VC has a predicted tooth length of 16.77














