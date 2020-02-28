###### Dragons Exercise ~ Data Manipulation ######

#1) Make data tidy
#2) Create boxplot for each species showing effect of spice on plume size

# Which spice triggers the most fiery reaction? And the least?

#BUT

# The fourth treatment wasn't paprika, it was tumeric. All measurements for Hungarian Horntail species are 30cm higher than they should be for TABASCO.
# And, convert cm to m.
library(dplyr)
library(tidyr)

getwd()
Dragons <- read.csv("Dragons.csv", header = TRUE)
Dragons
head(Dragons)
str(Dragons)
names(Dragons)

#Rename incorrect column header

Dragons <- rename(Dragons, tumeric = paprika) # Or, without dplyr package: (names(Dragons)[6] <-"tumeric")
names(Dragons)

# Create object with correct values
correct_values <- Dragons$tabasco[Dragons$species == "hungarian_horntail"] - 30

#overwrite values in the orginal dragons object:
Dragons[Dragons$species == "hungarian_horntail", "tabasco"] <- correct_values
Dragons

#or, could use mutate.

# Dragons_2 <- mutate(Dragons, tabasco = ifelse(species == "hungarian_horntail", tabasco - 30, tabasco))

# If species is a HH, deduct 30 from the original value in tabasco, if its not a HH the leave it.

# Best to create long table before changing the cm/m...

Dragons_long <- gather(Dragons, key = Treatment, value = FP_Length, c("tabasco", "jalapeno", "wasabi", "tumeric")) 

Dragons_long

#Convert data to meters using mutate to add another column (could have done this with calibration above, too)

Dragons_long <- mutate(Dragons_long, Plume_meters = FP_Length/100) #creates a new column turning cm into m 

Dragons_long

# Now, subset ready for the boxplots:

Horntail <- filter(Dragons_long, species == "hungarian_horntail"); Horntail
swedish <- filter(Dragons_long, species == "swedish_shortsnout"); swedish
Welsh <- filter(Dragons_long, species == "welsh_green"); Welsh

#Boxplots
par(mfrow=c(1, 3))

boxplot(Plume_meters ~ Treatment, data = Horntail, xlab = "Spice", ylab = "Length of fire plume (m)", main = "Hungarian Horntail")
boxplot(Plume_meters ~ Treatment, data = swedish, xlab = "Spice", ylab = "Length of fire plume (m)", main = "Swedish Shortsnout")
boxplot(Plume_meters ~ Treatment, data = Welsh, xlab = "Spice", ylab = "Length of fire plume (m)", main = "Welsh Green")















