# How Did COVID-19 Impact Corporate Bonds and Treasury Securities

## About
This repository is meant to highlight the work that is done for my Economics Honors Seminar where I have to write my senior thesis paper about any Economics-related topic that I want. As the name of the repository suggests, the focus of the research paper is on bond data, but more specifically on how COVID-19 impacted corporate bonds and treasury securites. The data collected for this research involves time series data collected from Bloomberg Terminal including:

- Bloomberg Barclays US Treasury Index Returns
- Bloomberg Barclays US Corporate High Yield Bond Index Returns
- Bloomberg Barclays US Corporate Bond Index Returns

The time series for these data points spans from October 1999 to March 2021

## Models
Although there are no regressions made in this study, the models that we rely on include ARMA-GARCH-DCC. The first function defiens the ARMA+GARCH part of each return, the second function defines the joint DCC model, and the third function estimates the joint model.

## Next Goals
Analyze the data returned from the models: find events and patterns from the time-series of means, volatilites, and correlations.

*As of right now, the data has not been finalized, there may be more data that will be used in the future*
