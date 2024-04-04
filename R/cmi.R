cmi<-function(v1,v2,vcs){
  if (missing(vcs)){
    c1<-var(v1)
    c2<-var(v2)
    c3=det(cov(cbind(v1,v2)))
    cmiv=0.5*log(c1*c2/c3)
  }else{
    c1=det(cov(cbind(v1,vcs)))
    c2=det(cov(cbind(v2,vcs)))
    c3=det(cov(cbind(vcs)))
    c4=det(cov(cbind(v1,v2,vcs)))
    cmiv=0.5*log((c1*c2)/(c3*c4));
  }
  if  (cmiv==Inf ){
    cmiv=0
  }
  return(cmiv)
}
