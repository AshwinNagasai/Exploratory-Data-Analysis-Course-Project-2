# Load necessary packages

library(ggplot2)
library(dplyr)

# Import data from the .rds file

NEI_file <- "summarySCC_PM25.rds"
NEI_data <- readRDS(NEI_file)
SSC_file <- "Source_Classification_Code.rds"
SSC_data <- readRDS(SSC_file)

# Select coal combustion_related sources using keywords from the Ei.Sector column

Coal_data <- SSC_data[grepl("Comb.*Coal", SSC_data$EI.Sector), ]

# Calculate total coal combustion-related emissions for each year from 1999 to 2008

SSC_Coal <- unique(Coal_data$SCC)
Coal_emissions <- NEI_data[(NEI_data$SCC %in% SSC_Coal), ]
Coal_year <- Coal_emissions %>% group_by(year) %>% 
             summarise(total = sum(Emissions))

# Plotting the data via ggplot (ggplot2 package)

Coal_emission_plot <- ggplot(Coal_year, aes(factor(year), total/1000, label = round(total/1000))) + 
    geom_bar(stat = "identity") + 
    ggtitle("Total Coal Combustion related PM2.5 Emissions - 1999 to 2008") + 
    xlab("Year") + ylab("PM2.5 Emissions in Kilotons") +
    ylim(c(0, 620)) + 
    theme_classic()+ 
    geom_text(size = 5, vjust = -1) + 
    theme(plot.title = element_text(hjust = 0.5))
print(Coal_emission_plot)

# Saving the Plot to a PNG file

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
