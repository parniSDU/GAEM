#Structure Learning algorithm

Sstep<-function(data, lamda=0.05, mode=c("pc","hc"),
                sco=c("loglik-g","aic-g","bic-g","pred-loglik-g","bge")){

  #names(data)<-paste("G",1:ncol(data),sep="")
  n_gene<-ncol(data)
  G<-matrix(1,n_gene,n_gene)
  diag(G)<-0
  Gval=G
  res<-edgereduceOI(G,Gval,0,t(data),0,lamda,G)
  skelEdge<-res$G
  fixedGaps =matrix(as.logical(1-skelEdge),n_gene,n_gene)
  fixedEdges = matrix(as.logical(skelEdge),n_gene,n_gene)
  suffStat = list(C = cor(data), n = nrow(data))
  if (mode=="pc"){

    pc.fit<- pcalg::pc(suffStat = suffStat,indepTest = cmi,
                alpha=lamda, labels = names(data), verbose = FALSE,
                u2pd ="retry"
                , fixedGaps =fixedGaps
                ,fixedEdges=fixedEdges
                ,skel.method = "stable"
    )
    ds<-pcalg::pdag2dag(pcalg::getGraph(pc.fit), keepVstruct=TRUE)$graph
  }
  if (mode=="hc"){
    #fixedEdges[upper.tri(fixedEdges, diag = TRUE)]<-FALSE
    #w<-which(fixedEdges , arr.ind = TRUE)
    #whitelist<-data.frame(from=paste("V",w[,1],sep=""),to=paste("V",w[,2],sep=""))
    b<-which(fixedGaps , arr.ind = TRUE)
    blacklist<-data.frame(from=paste("V",b[,1],sep=""),to=paste("V",b[,2],sep=""))
    #ds<-hc(data, whitelist=whitelist,blacklist=blacklist, score="loglik-g" )
    ds<-bnlearn::hc(data,blacklist=blacklist, score=sco )

  }

  return(ds)
}
