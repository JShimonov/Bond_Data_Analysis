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

# -----------------------------------------------------------------------

d_mat = as.Date(returns_data$Date, format = "%y/%m/%d")

# Multi returns
r_mat = cbind(returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`,
              returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`,
              returns_data$`Bloomberg Barclays US Treasury Index Returns`)

r_xts <- xts(r_mat, order.by = d_mat)

# Individual returns
r_mat_treasury = returns_data$`Bloomberg Barclays US Treasury Index Returns`
r_mat_HY = returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`
r_mat_IG = returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`

r_xts_treasury <- xts(r_mat_treasury, order.by = d_mat)
r_xts_HY <- xts(r_mat_HY, order.by = d_mat)
r_xts_IG <- xts(r_mat_IG, order.by = d_mat)

# plot
plot(r_xts_treasury)
plot(r_xts_HY)
plot(r_xts_IG)

ga_spe <- ugarchspec(mean.model = list(armaOrder = c(1,1)), 
                     variance.model = list(garchOrder = c(1,1), model = "sGARCH"), 
                     distribution.model = "norm")

ga_fit <- ugarchfit(ga_spe, data = r_xts, log = TRUE)
ga_fit

# plot the volatility using ga_fit 
plot(ga_fit, which = 3)

# dynamic conditional correlation (DCC)
dcc_spe <- dccspec(uspec = multispec(replicate(ncol(r_xts), ga_spe)), 
                   dccOrder = c(1,1), 
                   distribution = "mvnorm") 

dcc_fit <- dccfit(dcc_spe, data = r_xts)
dcc_fit
# plotting mean
#pdf(paste0("./fit.pdf"))

plot(dcc_fit, which=1, series=(1:3))

#dev.off()
plot(dcc_fit, which = 2, series=(1:3))

# plotting volatility
plot(dcc_fit, which = 4, series=(1:3))

# plot correlation
plot(dcc_fit, which = 4)

summary(returns_data)
