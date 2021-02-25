# clean memory and leave some spae before output
rm(list = ls())
cat(rep("\n", 25))

# import libraries 
lapply(
  c("readr", "readxl", "dplyr", "stringr", "stargazer", "plm", "AER"),
  require,
  character.only = TRUE)

# change the working directory
setwd("~/Desktop/ECON392W")

# import datasets
yield_data <- read_excel("Bond Data/BondYields.xlsx")
fed_data <- read_excel("Bond Data/FedData.xlsx")

# convert datasets to dataframes
yield_data <- as.data.frame(yield_data)
fed_data <- as.data.frame(fed_data)

# clean up the fed_data and yield_data a little
# remove the 'Series Code' column
fed_data$`Series code` <- NULL

# remove rows from yield_data where the row values are empty
yield_data <- yield_data[!(is.na(yield_data$`10yr Treasury Yield`) | is.na(yield_data$`Barclays Agg HY Spread`) | is.na(yield_data$`Barclays Agg Investment Grade Corporate Spread`)), ]


