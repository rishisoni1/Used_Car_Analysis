#Load Libraries
library(dplyr)

#Import
df <- read.csv("C:/Users/rishi/OneDrive/Desktop/Work/Project_Portfolio/Used_Car_Project/vehicles_CLEAN.csv")
View(df)

#Filter Empty VIN
filter <- subset(df, VIN != "")

#Add a Column for Country 
filter <- filter %>%
  mutate(country = case_when(
    manufacturer == "bmw" | manufacturer == "mercedes-benz" | manufacturer == "porsche" | manufacturer == "audi" | manufacturer == "volkswagen" ~ "Germany",
    manufacturer == "honda" | manufacturer == "acura" | manufacturer == "toyota" | manufacturer == "datsun" | manufacturer == "nissan" | manufacturer == "infiniti" | manufacturer == "lexus" | manufacturer == "mazda" | manufacturer == "mistubishi" | manufacturer == "subaru" ~ "Japan",
    manufacturer == "alfa-romeo" | manufacturer == "ferrari" | manufacturer == "fiat" ~ "Italy", 
    manufacturer == "aston-martin" | manufacturer == "jaguar" | manufacturer == "land rover" | manufacturer == "mini" | manufacturer == "rover" ~ "England",
    manufacturer == "buick" | manufacturer == "cadillac" | manufacturer == "chevrolet" | manufacturer == "chrysler" | manufacturer == "dodge" | manufacturer == "ford" | manufacturer == "gmc" | manufacturer == "harley-davidson" | manufacturer == "jeep" | manufacturer == "lincoln" | manufacturer == "mercury" | manufacturer == "pontiac" | manufacturer == "ram" | manufacturer == "saturn" | manufacturer == "tesla" ~ "United States",
    manufacturer == "hyundai" | manufacturer == "kia" ~ "South Korea",
    manufacturer == "volvo" ~ "Sweden",
    TRUE ~ "Empty"
  ))
View(filter)

#Specify New File Path
output_file_path <- file.path(dirname("C:/Users/rishi/OneDrive/Desktop/Work/Project_Portfolio/Used_Car_Project/vehicles_CLEAN.csv"), "Used_Cars_CLEAN.csv")

#Save as New CSV
write.csv(filter, output_file_path, row.names = FALSE)
