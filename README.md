# GYZR7
### Title: Assessment 1

#### **Introduction**

This is an Overview of my Project Assessment. I chose to use the WHO 2017 Vaccine and Immunization data provided from this [Source](https://github.com/MallyM03/GYZR7/files/13281740/Vaccine.Coverage.and.Disease.Burden.-.WHO.2017.csv)

The data set has 14 variables and 7818 rows. The data details the amount of immunizations as a percentage of the total population, deaths by illness and number of cases of infection over 42 years from 1974 to 2015. There are 25,916 NA's in total.

Contributor(s): I am the sole contributer to this project.

This project's main objective is to use and understand the coding knowledge I had learnt for the first 5 weeks of the Term. I did this by cleaning, wrangling and visualising the dataset I chose to use. The programming language used thorughout the project is R and I used the R Studio IDE.

### **Project**
The first part of the project focused on loading in and understanding the dataset linked above and also loading in any packages I would need later on.
I would reccomend loading in the packages: ggplot2, dplyr, tidyverse, glue, purrrr, and gapminder. 
I document the entire process and code in a Qaurto pdf Document.

You can generate the first 2 tables in the project, using the markdown table creator in a Quarto Document. 
I used the data from summary and glimpse functions to create the tables. 

The plots made in this project are:

-Plot 1: A scatterplot with a trendline

-Plot 2: Multiple Bargraphs

-Plot 3: Bubble Plot

All of this is possible with Base R code and most importantly, ggplot2 package.

### **Troubleshooting**
Some errors, bugs and problems I came across while coding this project.
Firstly, the dataset has a huge number of missing values. You can either drop all the NA's or impute values using hotdeck imputation or mean imputation. Dropping NA's leads to a very small amount of data, and very skwewed means and medians. HOwever, due to the natrue of the assessment I dropped NA's.

Secondly, if you are wanting to make a grid of multiple plots, the gridarrange package is giving an error and does not recognise the GROBS in the list as GROBS. Instead you will have to call gridarrange using the syntax: call(gridarrange,)

Lastly, When rendering in Quarto, make sure to call the dataframe used in the code chunk before transforming it or calling it elsewhere. Otherwise, the rendering will halt.


