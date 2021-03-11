# clean memory and leave some spae before output
rm(list = ls())
cat(rep("\n", 25))

# import libraries 
lapply(
  c("readr", "readxl", "dplyr", "stringr", "stargazer", "plm", "AER", "xts", "rugarch","rmgarch", "quantmod"),
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

# -----------------------------------------------------------------------

d_mat = as.Date(returns_data$Date, format = "%y/%m/%d")
r_mat = c(returns_data$`Bloomberg Barclays US Treasury Index Returns`, 
          returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`,
          returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`)

r_xts <- xts(r_mat, order.by=d_mat)

ga_spe <- ugarchspec(mean.model = list(armaOrder = c(1,1)), variance.model = list(garchOrder = c(1,1), model = "sGARCH"), distribution.model = "norm")
ga_fit <- ugarchfit(ga_spe, data = r_xts, log = TRUE)
ga_fit

dcc_spe <- dccspec(uspec = multispec( replicate(ncol(r_xts), ga_spe) ), dccOrder = c(1,1), distribution = "mvnorm") 
dcc_fit <- dccfit(dcc_spe, data = r_xts)


