# install "plspm"
install.packages("devtools") 
library(devtools)
install_github("gastonstat/plspm")
install.packages("plyr")
install.packages("ggplot2")
install.packages("reshape")
install.packages("haven")
install.packages("randomForest")
library(plspm)
library(haven)
library(randomForest)
getwd()
setwd()
scf_all <- as.data.frame(read_dta(file = "2007revised.dta"))
scf_all = scf_all[,4:ncol(scf_all)]
scf_all
ind<-sample(2,nrow(scf_all),replace = TRUE,prob = c(0.7,0.3))
traindata<-scf_all[ind == 1,]
testdata<-scf_all[ind == 2,]
randomForest_rf<-randomForest(c_Lli_ty~.,data = traindata,
                              ntree = 100,
                              mtry = 30,
                              proximity = TRUE,
                              importance = TRUE)
A = importance(randomForest_rf,type = 1)
randomForest_rf
B=predict(randomForest_rf, testdata, type="response",
        norm.votes=TRUE, predict.all=FALSE, proximity=FALSE, nodes=FALSE)
hist(B,xlab = "Weight",col = "yellow",border = "blue")
hist(testdata[,117],add = T,col = "green")
