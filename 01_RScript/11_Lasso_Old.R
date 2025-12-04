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

fred <- fred[!is.na(inf),]  ## Remove rows if inflation is NA
data <- fred[, -c("date")]  
data <- data[, sapply(data, function(x) sum(is.na(x))==0), with = F]  # Drop cols with NA
data <- as.matrix(data)

fred[, which(date=="2000-12-01")]
fred[, which(date=="2015-12-01")]
dt_s1 <- data[1:fred[, which(date=="2015-12-01")], ]
dt_s2 <- copy(data)

### Run for different lags and samples
## Sample 1: Train: 1960-01-01:2000-12-01.  Test: 2001-01-01:2015-12-01 
npred1 <- nrow(dt_s1) - fred[, which(date=="2000-12-01")]  # 180
best_lam_all_1 <- get_best_lambda(dt_s1, npred1, 1, lag=1, alpha=1, nlambda=25)  #0.020048
best_lam_1 <- best_lam_all_1$best_lam
#best_lam_1 <- 0.020048
lasso_s1_l1 <- lasso_roll_win(dt_s1, npred1, 1, lag=1, alpha=1   , lambda=best_lam_1)
lasso_s1_l3 <- lasso_roll_win(dt_s1, npred1, 1, lag=3, alpha=1   , lambda=best_lam_1)
ridge_s1_l1 <- lasso_roll_win(dt_s1, npred1, 1, lag=1, alpha=0   , lambda=best_lam_1)
ridge_s1_l3 <- lasso_roll_win(dt_s1, npred1, 1, lag=3, alpha=0   , lambda=best_lam_1)
elnet_s1_l1 <- elnet_roll_win(dt_s1, npred1, 1, lag=1, alpha="el", lambda=best_lam_1)
elnet_s1_l3 <- elnet_roll_win(dt_s1, npred1, 1, lag=3, alpha="el", lambda=best_lam_1)

## Sample 2: Train: 1960-01-01:2015-12-01.  Test: 2016-01-01:2024-12-01
npred2 <- nrow(fred) - fred[, which(date=="2015-12-01")]  # 108 as of 2024-12-01
best_lam_all_2 <- get_best_lambda(dt_s1, npred2, 1, lag=1, alpha=1, nlambda=25)  #0.0091218
best_lam_2 <- best_lam_all_2$best_lam
#best_lam_2 <- 0.0091218
lasso_s2_l1 <- lasso_roll_win(dt_s2, npred2, 1, lag=1, alpha=1   , lambda=best_lam_2)
lasso_s2_l3 <- lasso_roll_win(dt_s2, npred2, 1, lag=3, alpha=1   , lambda=best_lam_2)
ridge_s2_l1 <- lasso_roll_win(dt_s2, npred2, 1, lag=1, alpha=0   , lambda=best_lam_2)
ridge_s2_l3 <- lasso_roll_win(dt_s2, npred2, 1, lag=3, alpha=0   , lambda=best_lam_2)
elnet_s2_l1 <- elnet_roll_win(dt_s2, npred2, 1, lag=1, alpha="el", lambda=best_lam_2)
elnet_s2_l3 <- elnet_roll_win(dt_s2, npred2, 1, lag=3, alpha="el", lambda=best_lam_2)


ridge_s2_l3$real
lasso_s2_l3$real
sapply(elnet_s2_l1, function(x) x$errors)
writeClipboard(as.character(sapply(elnet_s2_l1, function(x) x$errors)[1,]))





