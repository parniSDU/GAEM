Initialize_population<-function(incom, pSize){
  nodes<-names(incom)
  #population_param<-vector(mode = "list", length = pSize)
  population_data<-vector(mode = "list", length = pSize)
  #initializing data
  population_data[[1]]<-as.data.frame(impute.svd(incom, k = (nrow(incom)-1),  maxiter=10000)$x)
  population_data[[2]]<-as.data.frame(impute.knn(as.matrix(incom),k = (ncol(incom)-1))$data)
  
  for (j in 3:pSize){
    imp<-incom
    mm<-minmax1(imp)
    for (k in 1:ncol(imp)){
      C<-imp[,k]
      n<-sum(1*is.na(C))
      C[is.na(C)]<-runif(n, mm$min[k], mm$max[k])
      imp[,k]<-C
    }
    population_data[[j]]<-imp
  }
  
  population_data
}
