# Load necessary packages

library(dplyr)
library(ggplot2)

# Import data from the .rds file

NEI_file <- "summarySCC_PM25.rds"
NEI_data <- readRDS(NEI_file)
SCC_file <- "Source_Classification_Code.rds"
SCC_data <- readRDS(SCC_file)

# Select emissions related to motor vehicle sources

SCC_vehicles <- SCC_data[grep("[Vv]ehicle", SCC_data$EI.Sector), "SCC"]

# Calculate total emissions from motor vehicle sources in Baltimore City for each year from 1999 to 2008

Total_Vehicle_emissions <- NEI_data %>% 
    filter(SCC %in% SCC_vehicles & fips == "24510") %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

# Plotting the data via ggplot (ggplot2 package)

Vehicle_emission_plot <- ggplot(Total_Vehicle_emissions, 
                          aes(factor(year),Emissions)) +
                          geom_bar(stat="identity",fill="grey",width=0.75) +
                          theme_bw() +  guides(fill=FALSE) + 
                          ylab(expression('PM'[2.5]*' Emissions in Kilotons')) + 
                         xlab("Year") +
        ggtitle("Total Vehicle Emissions in Baltimore City from 1999 to 2008")
print(Vehicle_emission_plot)

# Saving the Plot to a PNG file

dev.copy(png, file = "plot5.png", height = 480, width = 640)
dev.off()
