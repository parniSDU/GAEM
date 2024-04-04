#######Functions to learn the skeloton
edgereduceOI<-function(G,Gval,order,data,t,lamda,GFInal){
  if (order==0){
    for (i in 1:(nrow(G)-1)){
      for (j in (i+1):nrow(G)){
        if (G[i,j]!=0){
          cmiv=cmi(data[i,],data[j,]);
          Gval[i,j]=cmiv;  Gval[j,i]=cmiv;
          if (cmiv<lamda){
            G[i,j]=0;G[j,i]=0;
          }
        }
      }
    }
    t=t+1
    degreeG<-sum(G)
  } else {
    for (i in 1:(nrow(G)-1)){
      for (j in (i+1):nrow(G)){
        if (G[i,j]!=0){
          adj<-NULL
          for (k in 1:nrow(G)){
            if (GFInal[i,k]!=0 & GFInal[j,k]!=0){
              adj<-cbind(adj,k)
            }
          }
          adj<-setdiff(adj, i)
          adj<-setdiff(adj, j)
          
          
          if (ncol(adj)>=order){
            combntnslist<-t(combn(adj,order))
            combntnsrow<-nrow(combntnslist)
            cmiv=0;
            v1=data[i,];v2=data[j,]
            for (k in 1:combntnsrow){
              vcs=data[combntnslist[k,],]
              a=cmi(v1,v2,vcs) ;
              cmiv=max(cmiv,a);
            }
            Gval[i,j]=cmiv; #Gval[j,i]=cmiv
            if (cmiv<lamda){
              G[i,j]=0; G[j,i]=0
            }
            t=t+1;
          } #ifncol
        }#ifG
        
      }
    }
    
  }
  GFInal<-G
  out<-list(G=G, Gval=Gval,t=t)
  return(out)
}

