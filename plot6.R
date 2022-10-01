# Load necessary packages

library(dplyr)
library(ggplot2)

# Import data from the .rds file

NEI_file <- "summarySCC_PM25.rds"
NEI_data <- readRDS(NEI_file)
SCC_file <- "Source_Classification_Code.rds"
SCC_data <- readRDS(SCC_file)

# Select motor vehicle emissions in Baltimore City and Los Angeles County

fips_data <- data.frame(fips = c("06037", "24510"), 
                        county = c("Los Angeles", "Baltimore"))
SCC_vehicles <- SCC_data[grep("[Vv]ehicle", SCC_data$EI.Sector), "SCC"]
Total_Vehicle_emissions <- NEI_data %>% 
    filter(SCC %in% SCC_vehicles & fips %in% fips_data$fips) %>%
    group_by(fips,year) %>%
    summarize(Emissions = sum(Emissions))

Merged_data <- merge(Total_Vehicle_emissions, fips_data)

# Plotting the data via ggplot (ggplot2 package)

Comparative_V_emission_plot <- ggplot(Merged_data, aes(x=factor(year), 
                                                       y=Emissions, fill=year)) +
    geom_bar(stat="identity") +
    facet_grid(.~county) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
    labs(title=expression("Baltimore City Vs Los Angeles County Motor Vehicle Emissions from 1999 to 2008"))
print(Comparative_V_emission_plot)

# Saving the Plot to a PNG file

dev.copy(png, file = "plot6.png", height = 480, width = 640)
dev.off()
