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

## Clean and Prepare Data
source("01_RScript/01_Data_Transformation.R")
source("01_RScript/02_Data_Cleaning.R")

## Create Descriptives and Estimate Benchmarks
source("source/05_Descriptive_Inflation_Variable.R")
source("source/10_AR_and_SM.R")

## LASSO, Ridge, ElNet, RF
source("source/15_Lasso_Ridge_Elnet_RW.R")
source("source/16_Lasso_Ridge_Plots.R")
source("source/20_Random_Forest.R")
source("source/21_Random_Forest_Plots.R")

## Compare Out of Sample Forecast Performance
source("source/51_Model_Comparison_Rolling_Erros.R")