install.packages("plyr")
install.packages("ggplot2")
install.packages("reshape")
install.packages("haven")
install.packages("randomForest")
install.packages("mltools")
install.packages("data.table")
library(mltools)
library(data.table)



#with[,106:231]=lapply(with[,106:231],as.factor) 
#without[,100:225]=lapply(with[,100:225],as.factor) 
#library(haven)
library(randomForest)
getwd()
setwd()


fac_num = funcation(a){
  a = 2^a - 2
}
scf[year == 2019,107:232]
scf = read.table("all years with timevar.txt",sep=",",head = T)
  
scf[,107:232]=lapply(scf[,107:232],fac_num)
scf = scf[,-1]
scf = one_hot(as.data.table(scf))
scf = as.data.frame(scf)

randomForest_rf<-randomForest(c_Lli_ty~.,data = scf,
                              ntree = 200,
                              mtry = 20,
                              proximity = TRUE,
                              importance = TRUE)
A = importance(randomForest_rf,type = 1)
randomForest_rf
B=predict(randomForest_rf, testdata, type="response",
        norm.votes=TRUE, predict.all=FALSE, proximity=FALSE, nodes=FALSE)
hist(B,xlab = "Weight",col = "yellow",border = "blue")
hist(testdata[,117],add = T,col = "green")
