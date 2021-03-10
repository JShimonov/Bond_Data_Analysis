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
returns_data <- read_excel("Bond Data/bloomberg_bond_data.xlsx")

# convert datasets to dataframes
returns_data <- as.data.frame(returns_data)

# remove rows from yield_data where the row values are empty
returns_data <- returns_data[!(is.na(returns_data$`Bloomberg Barclays US Treasury Index Returns`) | is.na(returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`) | is.na(returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`)), ]
returns_data <- cbind(returns_data[0], returns_data$`Date`, returns_data$`Bloomberg Barclays US Treasury Index Returns`, returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`, returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`)
colnames(returns_data) <- c("Date", 
                            "Bloomberg Barclays US Treasury Index Returns",
                            "Bloomberg Barclays US Corporate High Yield Bond Index Returns",
                            "Bloomberg Barclays US Corporate Bond Index Returns")

# get summary information of the datasets
summary(returns_data)

# find basic data on the datasets 
# stargazer(as.data.frame(yield_data), type="text")
# 
# plot(log(yield_data$`10yr Treasury Yield`) ~ log(yield_data$`Barclays Agg HY Spread`), data = yield_data)
# results <- lm(log(yield_data$`10yr Treasury Yield`) ~ log(yield_data$`Barclays Agg HY Spread`), data = yield_data)
# abline(results)
# 
# plot(log(yield_data$`Barclays Agg HY Spread`) ~ log(yield_data$`Barclays Agg Investment Grade Corporate Spread`), data = yield_data)
# HY_and_IG_results <-lm(log(yield_data$`Barclays Agg HY Spread`) ~ log(yield_data$`Barclays Agg Investment Grade Corporate Spread`), data = yield_data)
# abline(HY_and_IG_results)





