# Load necessary packages

library(dplyr)

# Import data from the .rds file

NEI_file <- "summarySCC_PM25.rds"
NEI_data <- readRDS(NEI_file)

# Calculate Total PM2.5 emissions for Baltimore City from 1999 to 2008 
# Assign value to Balt_total_emissions
Balt_total_emissions <- NEI_data %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

# Plotting the data via barplot function [base plotting system]

with(Balt_total_emissions,
     barplot(height=Emissions/1000, 
             names.arg = year, 
             xlab = "Year", 
             ylab = expression('PM'[2.5]*' in Kilotons'),
            main = "Baltimore City PM2.5 Total Emissions - 1999 to 2008"))

# Saving the Plot to a PNG file

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
