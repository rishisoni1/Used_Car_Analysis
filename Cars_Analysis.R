#Load Libraries
library(dplyr)
library(ggplot2)
library(scales)

#Import Data
df <- read.csv("C:/Users/rishi/OneDrive/Desktop/Work/Project_Portfolio/Used_Car_Project/Used_Cars_CLEAN.csv")
View(df)
mean(df$odometer)
mean(df$price)

#A Look at Price and Mileage 
df_filtered <- df %>%
  filter(odometer <= 300000, price <= 100000)

ggplot(df_filtered, aes(x = odometer, y = price)) + geom_point() + 
  labs(title = "Relationship Between Mileage and Price", x = "Miles", y = "Price") + 
  scale_x_continuous(labels = label_number()) +
  scale_y_continuous(labels = label_number()) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = 'blue') 

#Breaking Down Price and Mileage by Country
df_filtered3 <- df %>%
  filter(odometer <= 300000, price <= 100000, country %in% c("Germany", "United States", "Japan", "South Korea"))

ggplot(df_filtered3, aes(x = odometer, y = price)) + 
  geom_point() + 
  labs(title = "Relationship Between Mileage and Price", x = "Miles", y = "Price") + 
  scale_x_continuous(labels = scales::label_number()) +
  scale_y_continuous(labels = scales::label_number()) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = 'blue') +
  facet_wrap(~country)

#Build a Linear Model for Types
M1 <- lm(price ~ type, df)
summary(M1)

#Build a Linear Model for Fuel
M2 <- lm(price ~ fuel, df)
summary(M2)

#Build a Linear Model for Cylinders 
M3 <- lm(price ~ cylinders, df)
summary(M3)

#Observe Average Prices for Popular Manufactures over the last 30 years
df_filtered2 <- df[df$manufacturer %in% c("bmw", "toyota", "honda", "volkswagen", "mercedes-benz", "chevrolet", "kia", "hyundai","ford") & df$year >= 1991 & df$year <= 2021, ]

ggplot(df_filtered2, aes(x = year, y = price)) +
  geom_point(stat = "summary", fun = "mean", color = "red") +
  scale_x_continuous(breaks = seq(1991, 2021, by = 1)) +
  labs(title = "Average Price Over the Last 30 Years",
       x = "Year",
       y = "Average Price",
       color = "Manufacturer") +
  facet_wrap(~manufacturer) + 
  theme(axis.text.x = element_text(size = 4))

#Observe Average Prices for Countries over the last 20 years
df_filtered4 <- df[df$country %in% c("United States", "Japan", "Germany", "South Korea") & df$year >= 2001 & df$year <= 2021, ]

ggplot(df_filtered4, aes(x = year, y = price)) +
  geom_point(stat = "summary", fun = "mean", color = "red") +
  scale_x_continuous(breaks = seq(2001, 2021, by = 1)) +
  labs(title = "Average Price Over the Last 20 Years",
       x = "Year",
       y = "Average Price",
       color = "Country") +
  facet_wrap(~country) + 
  theme(axis.text.x = element_text(size = 5))

#Build a Linear Model for Odometer and Year
M4 <- lm(price ~ odometer + year, df)
summary(M4)

#Create a Basic Function to Predict the Value of Your Car 
my_prediction <- function(msrp, miles, model_year) {
  current_year <- as.numeric(format(Sys.Date(), "%Y"))
  value <- msrp - (0.068*miles) - (573.7*(current_year - model_year))
  return(value)
}
