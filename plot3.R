# Load necessary packages

library(ggplot2)
library(dplyr)

# Import data from the .rds file

file_name <- "summarySCC_PM25.rds"
NEI_data <- readRDS(file_name)

# Calculate Total PM2.5 emissions for Baltimore City from 1999 to 2008 
# Assign value to Balt_emissions

Balt_emissions <- NEI_data %>%
    filter(fips == "24510") %>%
    group_by(year,type) %>%
    summarise(Emissions = sum(Emissions))

# Plotting the data via ggplot (ggplot2 package)

Balt_emission_plot <- ggplot(data = Balt_emissions,
     aes(x = factor(year), y = Emissions, fill = type, colore = "black")) +
     geom_bar(stat = "identity") +
     facet_grid(.~ type) + 
     labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM2.5 Emissions by Source Type in Baltimore City from 1999 to 2008"))
print(Balt_emission_plot)

# Saving the Plot to a PNG file

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
