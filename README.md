## Problem Statement

Find the relationship between eye health and age-adjusted death rate (AADR).

## Executive Summary

Age-adjusted death rate(AADR) is a statistical process applied to the rate of disease, death, injuries, or other health outcomes that allows communities with different age structures to be compared. The importance of this research about AADR-related data sets is that almost all disease or health issues occur at different rates in different groups. Some physical injuries occur more often among younger people, while other chronicle diseases and cancers etc., would occur more often among the elder population. I decided to investigate eye health and AADR in order to find what kind of symptoms actually cause more death.

## Data Description

**Behavior Risk Factors- Vision &amp** from [U.S. Government’s open data](https://catalog.data.gov/dataset/behavioral-risk-factors-vision-amp-eye-health-c8237)
- In 2013, Behavioral Risk Factor Surveillance System(BRFSS) sent out a questionnaire to all 50 states in U.S: Do you have serious difficulty seeing? Or even short sight? Then they make this data set which contains 54316 observations as well as 24 variables, such as year, location, location abbreviation, topic, lower ci, upper ci and location ID. 


**Age-Adjusted Death Rate** from [Centers for Disease Control and Prevention](https://www.cdc.gov/nchs/data-visualization/mortality-leading-causes/)
- The data set of adjusted death rates is shorter, as it contains only 13261 observations and 6 variables. This data set contains the major cause of death rates from 1999 to 2013. It is also based on all death certificates filed in the 50 states and District of Columbia. Six variables are included: year, cause type, cause name, state, death and AADR (age-adjusted death rates).

## Method

- Check the data
- Remove unnecessary columns
- Merge two datasets by year and state
- Remove missing data
- Perform statistical analysis
- Interpret the result

## Result

- Death rate of each survey questions with different age

![](/image/result.png)

- Death rate of adults 18 years and older

![](/image/ex1.png)

- Death rate of adults 50 years and older

![](/image/ex2.png)

- We can see a huge discrepancy between the AADR with these two questions. Rarer symptoms caused more death than those more common symptoms. Even though the AADR just varies from 10 to about 30 and some rare symptoms may not have that of an extremely high AADR, it is generally true that, in our dataset, the rarer diseases or symptoms tend to cause more death in general.

## Conclusion

This project contains three main steps. First, I accessed, simplified, labeled and merged the original two datasets for our research purposes. Then I validated the new data and clean it by three steps: univariate, means and freq in order to eliminate missing and extreme observations. I also added two calculated variables to build the relationship of the questionnaire and average death rate and did a mean analysis of the death rate of different questions. Ultimately, I was able to reach the conclusion that those questions with more rate of patients tended to be less lethal than those rarer symptoms.
