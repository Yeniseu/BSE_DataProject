# Author: ...
# Date: 26/11/2025
# Scope: Apply Random Forest
rm(list = ls())
source("01_RScript/00_Functions.R")
library(data.table)
library(glmnet)
library(caret)
options(print.max = 300, scipen = 30, digits = 5)

### Load & prepare
fred <- readRDS("02_Input/data_cleaned.rds")
setDT(fred)
setnames(fred, "CPIAUCSL", "inf")
setcolorder(fred, c("date", "inf"))

dt <- fred[!is.na(inf),]  ## Remove rows if inflation is NA
dt <- dt[, -c("date")]  
dt <- dt[, sapply(dt, function(x) sum(is.na(x))==0), with = F]  # Drop cols with NA
dt <- as.matrix(dt)

### Run for different lags and samples
nprev <- 180
best_lam <- get_best_lambda(dt, nprev, 1, lag=1, alpha=1, nlambda=25)  #

rlasso1c <- lasso_roll_win(dt, nprev, 1, lag=1, alpha=1, lambda=best_lam)

Y[1:(nrow(Y)-nprev),]


