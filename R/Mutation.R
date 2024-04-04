Mutation<-function(pop,pmut,incom,pSize){
  mutNo<-floor(pmut*pSize)
  mutS<-sample(1:pSize, mutNo,replace = FALSE)
  mutPop<-pop[mutS]
  for (i in 1:mutNo){
    s<-sample(names(incom),1)
    mindex<-which(is.na(incom[,s]))
    mutPop[[i]][mindex,s]<-1-mutPop[[i]][mindex,s]
  }
  mutPop
}
