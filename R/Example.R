
#######Building True Dag for Dream10 from a matrix
TrueDag<-DREAM3GoldStandard_InSilicoSize10_Yeast1
names(TrueDag)<-c("from", "to", "edge")
TrueDag<-TrueDag[TrueDag$edge==1,]

mtdag<-matrix(0,10,10)
colnames(mtdag)<-paste("G",1:10,sep="")
rownames(mtdag)<-colnames(mtdag)

for (i in 1:nrow(TrueDag)){
  mtdag[as.character(TrueDag[i,1]),as.character(TrueDag[i,2])]<-1
}

dag_true10<-as(as.matrix(mtdag), "graphNEL")

plot(dag_true10)

#############
result<-GAEM(incom= DREAM10_MAR_15, pSize=10,  lamda=0.05, mode="pc", sco="bge",
             pcross=0.85,pmut=0.15,maxiter=50, error=0.00001 )


cmp<-c(comp(dag_true10, result$BestDag),comp_imp(DREAM10, result$Best))

