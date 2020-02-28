##%######################################################%##
#                                                          #
####               TUtorial on etiquette                ####
#                                                          #
##%######################################################%##


# THese four dashes create subheadings like a word doc! ----
# They can be collapsed and expanded !

# I should start every script with an Introduction e.g 
# What script does, author name, contact details and date

# What libraries/packages are being used - keep them
#all together at the start of the script

#eg:

# Analysis for sun bear occupaancy in Kalimantan 
# Katie Spencer 06/02/2020

# Libraries ----
library(tidyr)  # Formatting data for analysis
library(dplyr)  # Manipulating data
library(ggplot2)  # Visualising results
library(readr)  # Manipulating data

# Define any functions you've created 


# Get the working directory from:
setwd()

# Define the different sections of analysis in logical order

# Can format old scripts automatically useing:

install.packages("formatR")

#Use find /replace to update names, or use code:

names(dataframe) <- gsub(".", "_", names(dataframe), fixed = TRUE)

# e.g replace name "." with "_"

# Point and click addins with:

install.packages('addinslist')

#Insert a box around the introductory section of your script
install.packages("devtools")
devtools::install_github("ThinkRstat/littleboxes")

# Afterwards select your introductory comments, click on Addins/ Little boxes and the box appears!
# Note that if you are also reformatting your code using formatR, reformat the code first, then add the box.
# formatR messes up these boxes otherwise!

