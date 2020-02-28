##%######################################################%##
#                                                          #
####             4. Basic Data Manipulation             ####
####             Katie Spencer 06/02/2020               ####
#                                                          #
##%######################################################%##

getwd()
setwd("C:\\Users\\katie\\OneDrive\\PhD\\My_Stats_from_Scratch\\CC_course_stream1\\04_Data_manip_1")

#Can import data with point&click, or:

Empetrum <- read.csv("EmpetrumElongation.csv", header = TRUE) # (after set wd)
Empetrum

head(Empetrum)
str(Empetrum)

#---- Subsetting #

Empetrum$Indiv
length(unique(Empetrum$Indiv)) #How many unique individuals in the data?
Empetrum[2,5] # Value in second row and fifth column
Empetrum[6, ] #All info for row 6


Empetrum[!Empetrum$Zone >5, ] #Exclude zone 5 

#With two conditions:

Empetrum[Empetrum$Zone == 2 | Empetrum$Zone ==7, ] # Returns data for only zones 2 and 7
Empetrum[Empetrum$Zone == 2 & Empetrum$Indiv %in% c(300:400),] #Returns data for shrubs in zone 2 whose ID numbers are between 300 and 400


# But coding with numbers is bad practise, should use logical operators

names(Empetrum) #Names of the columns
names(Empetrum)[1] # Name of 1st column
(names(Empetrum)[1] <-"ZONE") # Renamed to ZONE

#can edit individual data points

Empetrum[1,4] <- 5.7

#or

Empetrum[Empetrum$Indiv == 373, ]$X2008 <- 5.7 # This finds indivdual 373 from column x2008

#Change variable type:

str(Empetrum)
(Empetrum$ZONE <- as.factor(Empetrum$ZONE))

#See the levels

levels(Empetrum$ZONE)

#Rename the levels

(levels(Empetrum$ZONE) <- c("A", "B", "C", "D", "E", "F"))



##%######################################################%##
#                                                          #
####                 Tidy datasets ----                 ####
#                                                          #
##%######################################################%##


#Each row represents an obersation and each column is a varible (long format)

#The function gather() from tidyr package coverts wide-format table
# to a tidy data frame 

install.packages("tidyr")
library(tidyr)

longation_long <- gather(Empetrum, Year, Length,                           # in this order: data frame, key, value
                         c(X2007, X2008, X2009, X2010, X2011, X2012))        # we need to specify which columns to gather


#(or longation_long2 <- gather(Empetrum, Year, Length, c(3:8)) )

longation_long

### BOXPLOT ####

boxplot(Length ~ Year, data = longation_long,
        xlab = "year", ylab = "Elongation (cm)",
        main = "Annual growth of Empetrum spp")

##%######################################################%##
#                                                          #
####                dplyr function ----                 ####
#                                                          #
##%######################################################%##

# Much more efficient at manipulating base R, as it negates need for 
# calling objects from data frame e.g using $$$


install.packages("dplyr")
library(dplyr)  

#Rename:

#rename(dataframe, new name = old name)
rename(longation_long, years = Year)


#base R equivilent =

names(dataframe) <- c(" new name", " new name", etc )

# Just keep zone 2 and 3,  from years 2009 to 2011

elong_subset <- filter(longation_long, Zone %in% c(2, 3), Year %in% c("X2009", "X2010", "X2011"))

# USed logical &in% because looking to match exact characters,
# but if looking for numeric values we need two logical statements or used between()

# length > 4 & length <= 6.5 
#or 
# between(length, 4, 6.5).

# remove  columns:

elong_no_zone <- dplyr::select(longation_long, -Zone)
elong_no_zone
#This command also allows you to rename and reorder columns on the fly (see tutorial)


# The Base R command would be:

longation_long[ , -1]


#### MUTATE

# Creates new columns 

#Code below is for the orginal, wide table

elong_total <- mutate(Empetrum, total.growth = X2007 + X2008 + X2009 + X2010 + X2011 + X2012)
elong_total

#COde for new, long data: 

# group_by - groups data internally, but does not change dataframe
# This is useful when want to compute summary statistics for species etc

#Summarise()
#This aggregates the orginal data frame

# ALWAYS CREATE A NEW OBJECT FOR SUMMARISED DATA, SO YOU DON'T LOST ORIGNAL DATA 


elong_grouped <- group_by(longation_long, Indiv) 

summary1 <- summarise(longation_long, total.growth = sum(Length))
summary2 <- summarise(elong_grouped, total.growth = sum(Length))

#The first will sum all growth increments, the second will sum the growth over years for each per individual as this is the grouping variable

summary3 = summarise(elong_grouped, total.growth = sum(Length), mean.growth = mean(Length), sd.growth = sd(Length))


#----JOIN -----


treatments <- EmpetrumTreatments
head(treatments)
Empetrum
treatments

experiment <- left_join(longation_long, treatments, by = c("Indiv")) # IF columsn to match have exactly the same name then you
#can omit them, but it's good practice to specify merging conditon.

#If they were spelt differently for example:

## Join the two data frames by ID code, as the columns names are spelt differently, we will need to tell the function which columns
#represent a match. e.g zone and individual ID 

# experiment <- left_join(longation_long, treatments, by = c("Indiv" = "indiv", "zone" = "Zone"))
experiment

# merge function also works well:
experiment2 <- merge(longation_long, treatments, by.x = c("Indiv), by.y = c("Indiv"))

# Now look at data with treatements usuing a boxplot again

boxplot(Length ~ Treatment, data = experiment)






  
  
  
  
  
  