# Authors: Silvia Ianeselli, Emilia Infante, Ece Tasan, Orhun Ozel
# Date: 16/12/2025
# Scope: This study examines the performance of various machine learning 
# methods for forecasting US inflation using FRED-MD data. We employ LASSO, RIDGE,
# ElNet, Random Forest. We also benchmark them with MA, AR, and rolling sample mean.

rm(list = ls())
library(data.table)
library(dplyr)
library(ggplot2)
library(randomForest)
library(glmnet)
library(gt)
library(scales)
library(readr)
library(corrplot)

## Clean and Prepare Data
source("01_RScript/01_Data_Transformation.R")
source("01_RScript/02_Data_Cleaning.R")

## Create Descriptives and Estimate Benchmarks
source("01_RScript/05_Descriptive_Inflation_Variable.R")
source("01_RScript/10_AR_and_SM.R")

## LASSO, Ridge, ElNet, RF
source("01_RScript/15_Lasso_Ridge_Elnet_RW.R")
source("01_RScript/16_Lasso_Ridge_Plots.R")
source("01_RScript/18_Random_Forest.R")

## Compare Out of Sample Forecast Performance
source("01_RScript/51_Model_Comparison_Rolling_Erros.R")





