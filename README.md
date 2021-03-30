# How Did COVID-19 Impact Corporate Bonds and Treasury Securities

## About
This repository is meant to highlight the research that I am conducting parallel to my Economics Honors Seminar where I have to write my senior thesis paper about any Economics-related topic that I want. As the name of the repository suggests, the focus of the research paper is on bond data, but more specifically on how COVID-19 impacted corporate bonds and treasury securites. The data collected for this research involves time series data collected from Bloomberg Terminal including:

- Bloomberg Barclays US Treasury Index Returns
- Bloomberg Barclays US Corporate High Yield Bond Index Returns
- Bloomberg Barclays US Corporate Bond Index Returns

The time series for these data points spans from October 1999 to March 2021

## Models
Although there are no regressions made in this study, the models that we rely on include ARMA-GARCH-DCC. The first function defiens the ARMA+GARCH part of each return, the second function defines the joint DCC model, and the third function estimates the joint model.

## Interesting Analyses
Beecause the data that was collected spans more that 20 years, there are unique insights when looking at the evolution of the bond market. All it takes is one graph function to see such spikes in bond returns during the financial crisis of 2008, as well as the recession that the economy underwent recently. Images of these plots are found below

## Images

### DCC Correlation
<img src="https://github.com/JShimonov/Bond_Data_Analysis/blob/main/Images/DCC%20Correlation.png" width=500><br>

### DCC Mean
<img src="https://github.com/JShimonov/Bond_Data_Analysis/blob/main/Images/DCC%20Mean.png" width=500><br>

#### DCC Volatility
<img src="https://github.com/JShimonov/Bond_Data_Analysis/blob/main/Images/DCC%20Volatility.png" width=500><br>

#### Overall Volatility
<img src="https://github.com/JShimonov/Bond_Data_Analysis/blob/main/Images/Overall%20Volatility.png" width=500><br>
