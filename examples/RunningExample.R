rm(list=ls())
library(GAEM)
#Read the original data, missing data and gold-standard
original<-read.table(file="examples/Dream10.txt", header=TRUE)
incomplete<-read.table(file="examples/DREAM10_MAR_10%.txt", header=TRUE)
gold_standard = read.csv(file="examples/true_10.csv", header=TRUE,row.names = 1)
gold_standard_graph<-as(as.matrix(gold_standard), "graphNEL")
result<-GAEM(incom= incomplete, pSize=10,  lamda=0.05, mode="pc", sco="bge",
             pcross=0.85,pmut=0.15,maxiter=50, error=0.00001 )
#Compare the imputed data set with the original data set, and the learnt GRN with the true GRN:
cmp<-c(comp(gold_standard_graph, result$BestDag),RMSE=sqrt(mean(as.matrix((original-result$Best)^2))))



