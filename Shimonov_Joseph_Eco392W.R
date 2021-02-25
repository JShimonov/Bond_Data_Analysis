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

# clean up the fed_data a lil
# remove the 'Series Code' column
fed_data$`Series code` <- NULL
