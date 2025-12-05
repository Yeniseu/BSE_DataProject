# Author: Ece Tasan
# Date: 5/12/2025
# Scope: Rolling RMSE for Model Comparison

#### Comparison for First Out of Sample Period ####

lasso1 <- readRDS("03_Output/lasso_pred_s1.rds")
lasso1_1 <- lasso1[, c("real", "lasso_l1", "ridge_l1", "elnet_l1", "rw_l1")]
lasso1_3 <- lasso1[, c("real", "lasso_l3", "ridge_l3", "elnet_l3", "rw_l3")]
colnames(lasso1)

mean1_h1 <- readRDS("03_Output/p1_h1_mean.rds")
mean1_h1 <- mean1_h1$pred
mean1_h1 <- as.data.table(mean1_h1)
setnames(mean1_h1, "V1", "mean_h1")

mean1_h3 <- readRDS("03_Output/p1_h3_mean.rds")
mean1_h3 <- mean1_h3$pred
mean1_h3 <- as.data.table(mean1_h3)

p1_h1_ar4 <- readRDS("03_Output/p1_h1_ar4.rds")
p1_h1_ar4 <- p1_h1_ar4$pred
p1_h1_ar4 <- as.data.table(p1_h1_ar4)

p1_h3_ar4 <- readRDS("03_Output/p1_h3_ar4.rds")
p1_h3_ar4 <- p1_h3_ar4$pred
p1_h3_ar4 <- as.data.table(p1_h3_ar4)

rf1_1 <- readRDS("03_Output/rf1_1.rds")
rf1_1 <- rf1_1$pred
rf1_1 <- as.data.table(rf1_1)

rf1_3 <- readRDS("03_Output/rf1_3.rds")
rf1_3 <- rf1_3$pred
rf1_3 <- as.data.table(rf1_3)

all1 <- cbind(lasso1, mean1_h1, rf1_3)



class(mean1_h1)
p1_h1_mean$mse, p1_h1_ar4$mse,
p2_h1_mean$mse, p2_h1_ar4$mse,
p1_h3_mean$mse, p1_h3_ar4$mse,
p2_h3_mean$mse, p2_h3_ar4$mse


