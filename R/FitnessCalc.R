FitnessCalc<-function(pop, incom, lamda=lamda, mode,sco){
  out<-NULL
  pred<-incom
  pop_dag<-Sstep(as.data.frame(pop), lamda=lamda, mode,sco)
  if (is(pop_dag)[1]!="bn"){pop_dag<-bnlearn::as.bn(pop_dag)}
  fitted = bnlearn::bn.fit(pop_dag,pop)

  #complete = bnlearn::impute(fitted, incom,method = "bayes-lw")
  #mean(as.matrix((pop-complete)^2))

  for (k in names(pred)){
    pred[,k]= predict(fitted, k, pop, method = "bayes-lw")
  }

  mean(as.matrix((incom-pred)^2),na.rm=TRUE)
}

