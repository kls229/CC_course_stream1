##%######################################################%##
#                                                          #
####        Challenge yourself - graphing               ####
#                                                          #
##%######################################################%##


# Using the orginal LPI data set:

#1 Choose two species and display their population trends over time using scatterplot and linear model fit

#2 Using the same species, filter the data to include records from 5 countries and make a  boxplot to compare how the abundance of
# those two species varies between the five countries? 

# Grey wolf / Gray wolf and Red fox

Wolf <-filter(LPI2, Common.Name == c("Grey wolf / Gray wolf"))
head(Wolf)
Wolf <- na.omit(Wolf)
Wolf

Fox <-filter(LPI2, Common.Name == c("Red fox"))
head(Fox)
Fox <- na.omit(Fox)
Fox

# Histograms

(Wolf_hist <- ggplot(Wolf, aes(x=abundance)) + geom_histogram()) 

(Fox_hist <- ggplot(Fox, aes(x=abundance)) + geom_histogram()) 

# Scatterplots

(Wolf_SP <- ggplot(Wolf, aes (x=year, y=abundance)) + geom_point() +  geom_smooth(method=lm))
(Fox_SP <- ggplot(Koala, aes (x=year, y=abundance)) + geom_point() +  geom_smooth(method=lm))

# Together, filter them first:

canids <- filter(LPI2, Common.Name %in% c("Grey wolf / Gray wolf", "Red fox"))

(canid.scatter<- ggplot(canids, aes(x = year, y = abundance, colour = Common.Name)) +
    geom_point() +                # alpha controls transparency
    facet_wrap(~ Common.Name, scales = 'free_y') +                                   # facetting by species
    stat_smooth(method = 'lm', aes(fill = Common.Name, colour =Common.Name)) +    # colour coding by country
    scale_colour_manual(values = c('#8B3A3A', '#4A708B', '#FFA500', '#8B8989'), name = 'Species') +
    scale_fill_manual(values = c('#8B3A3A', '#4A708B', '#FFA500', '#8B8989'), name = 'Species') +
    labs(x = 'Year', y = 'Abundance \n') +
    theme_bw() +
    theme(panel.grid = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size = 12),
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 12),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 12))
)

colour = Country.list

# GRAPH 2 - BOXPLOTS OF ABUNDANCE ACROSS FIVE COUNTRIES

Canid.five <- filter(canids, Country.list %in% c("Denmark", "Sweden", "United States", "Finland", "Poland"))

(Canid_boxplot <- ggplot(Canid.five, aes(Country.list, abundance)) + geom_boxplot())

# GRAPH 2 - BOXPLOTS OF ABUNDANCE ACROSS FIVE COUNTRIES


(Canid.box <- ggplot(Canid.five, aes(x = Country.list, y = abundance)) +
    geom_boxplot() +
    labs(x = 'Country', y = 'Abundance \n') +
    theme_bw() +
    facet_wrap(~Common.Name, scales = 'free_y') +
    theme(panel.grid = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size = 12),
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 12),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 12))
)


