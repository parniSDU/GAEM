minmax1<-function(data){
  min<-NULL
  max=min
  s<-sapply(data,summary,na.rm=TRUE)
  if (is.matrix(s)){
    for (i in 1:ncol(data)){
      min[i]<-(s[,i][2])
      max[i]<-(s[,i][5])
      #min[i]<-(s[,i][3])-0.05
      #max[i]<-(s[,i][3])+0.05
      #   min[i]<-s[,i][4]-sd(data[,i],na.rm = TRUE)
      #  max[i]<-s[,i][4]+sd(data[,i],na.rm = TRUE)
      
    }
  }
  if (is.list(s)){
    for (i in 1:ncol(data)){
      min[i]<-s[[i]][2]
      max[i]<-s[[i]][5]
      #3 median, 4mean
      # min[i]<-(s[[i]][3])-0.05
      #  max[i]<-(s[[i]][3])+0.05
      #   min[i]<-s[[i]][4]-sd(data[,i],na.rm = TRUE)
      #  max[i]<-s[[i]][4]+sd(data[,i],na.rm = TRUE)
    }
  }
  list(min=min, max=max)
}

