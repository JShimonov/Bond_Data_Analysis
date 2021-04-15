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
#returns_data <- read_excel("Bond Data/bloomberg_bond_data.xlsx")
returns_data <- read_excel('Bond Data/Data.xlsx')

# convert datasets to dataframes
returns_data <- as.data.frame(returns_data)

# remove rows from yield_data where the row values are empty
#returns_data <- returns_data[!(is.na(returns_data$`Bloomberg Barclays US Treasury Index Returns`) | is.na(returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`) | is.na(returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`)), ]
#returns_data <- cbind(returns_data[0], returns_data$`Date`, returns_data$`Bloomberg Barclays US Treasury Index Returns`, returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`, returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`)

returns_data <- returns_data[!(is.na(returns_data$`HY Returns`) | is.na(returns_data$`IG Returns`) | is.na(returns_data$`Treasury Returns`)), ]
returns_data <- cbind(returns_data[0], returns_data$`Date`, returns_data$`HY Returns`, returns_data$`IG Returns`, returns_data$`Treasury Returns`)

colnames(returns_data) <- c("Date", 
                            "HY Returns",
                            "IG Returns",
                            "Treasury Returns")

# -----------------------------------------------------------------------

d_mat = as.Date(returns_data$Date, format = "%y/%m/%d")

# Multi returns
#r_mat = cbind(returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`,
#              returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`,
#              returns_data$`Bloomberg Barclays US Treasury Index Returns`)

r_mat = cbind(returns_data$`HY Returns`,
              returns_data$`IG Returns`,
              returns_data$`Treasury Returns`)

# change the column names in the xts to show the bond types
r_xts <- xts(r_mat, order.by = d_mat)
r_xts_df <- as.data.frame(r_xts)
colnames(r_xts_df) <- c("HY", "IG", "Treasury")
r_xts <- as.xts(r_xts_df)

# Individual returns
#r_mat_treasury = returns_data$`Bloomberg Barclays US Treasury Index Returns`
#r_mat_HY = returns_data$`Bloomberg Barclays US Corporate High Yield Bond Index Returns`
#r_mat_IG = returns_data$`Bloomberg Barclays US Corporate Bond Index Returns`

#r_xts_treasury <- xts(r_mat_treasury, order.by = d_mat)
#r_xts_HY <- xts(r_mat_HY, order.by = d_mat)
#r_xts_IG <- xts(r_mat_IG, order.by = d_mat)


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

# ploting
plot(dcc_fit, which=1, series=(1:3))

#dev.off()
plot(dcc_fit, which = 2, series=(1:3))

# plotting volatility
plot(dcc_fit, which = 4, series=(1:3))

# plot correlation
plot(dcc_fit, which = 4)

# show descriptive stats
stargazer(returns_data[,2:ncol(returns_data)], type = "text", flip = T)

# find the correlation among all the return columns
cor(returns_data[,2:ncol(returns_data)], use="all.obs", method = "pearson")

fit_r <- as.data.frame(fitted(dcc_fit))
vol_r <- as.data.frame(sigma(dcc_fit))
cor_r <- as.data.frame(rcor(dcc_fit, type = "R"))

# prepare the cor_all for the stargazer
# cor HY-IG
cor_HYIG <- cor_r[1,2,]
# cor HY-Treasury
cor_HYTreasury <- cor_r[1,3,]
# cor IG-Treasury
cor_IGTreasury <- cor_r[2,3,]

# convert the cors calculated into a df
cor_HYIG <- as.data.frame(cor_HYIG)
cor_HYTreasury <- as.data.frame(cor_HYTreasury)
cor_IGTreasury <- as.data.frame(cor_IGTreasury)

# bind the cors together to form cor_all
cor_all <- cbind(cor_HYIG, cor_HYTreasury, cor_IGTreasury)

# print stargazer outputs for fit_r, vol_r, and cor_r
stargazer(fit_r, type = "text", flip = F)
stargazer(vol_r, type = "text", flip = F)
stargazer(cor_all, type = "text", flip = F)

# does not work
#stargazer(cor_r, type = "text", flip = F, median = T)

#stargazer::stargazer(returns_data,
#                     type = "html",
#                     out = "~/Desktop/ECON392W/descriptives.doc")












