# Load necessary packages

library(dplyr)

# Import data from the .rds file

NEI_file <- "summarySCC_PM25.rds"
NEI_data <- readRDS(NEI_file)

# Calculate Total PM2.5 emissions for each year from 1999 to 2008 
# Assign value to Total_PM2.5_emission

Total_PM2.5_emission <- NEI_data %>% group_by(year)  %>% 
                        summarise(total = sum(Emissions))

# Plotting the data via barplot function[base plotting system]

plot1 <- barplot(Total_PM2.5_emission$total/1000, 
                 main = "Total PM2.5 Emissions from all sources - 1999 to 2008",
                 xlab = "Year", ylab = "PM2.5 Emissions in Kilotons", 
                 names.arg = Total_PM2.5_emission$year, 
                 ylim = c(0,8300))

# Annotating the Plot

text(plot1, round(Total_PM2.5_emission$total/1000), 
     label = round(Total_PM2.5_emission$total/1000), 
     pos = 3, cex = 1.2)

# Saving the Plot to a PNG file

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
