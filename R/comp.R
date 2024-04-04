comp<-function(True, Pred){
  adj1<-bnlearn::amat(bnlearn::as.bn(True))
  if (is(Pred)[1]!="bn"){Pred<-bnlearn::as.bn(Pred)}
  adj2<-bnlearn::amat(Pred)

  K <- (nrow(adj1)- 1) * nrow(adj1)


  tp <- length(which((adj1 & adj2)))
  # 1 values in both adjacency matrices

  # 0obs 0pred (TN)
  tn <- length(which(((1 - adj1) & (1 - adj2)))) - nrow(adj1)
  # 0 values become 1 in both adjacency matrices when using 1 - adj1 and 1 - adj2
  # We remove the number of nodes as both diagonal values
  # of 1 - adj1 and 1 - adj2 are ones.

  # 0obs 1pred (FP)
  fp <- length(which(((1 - adj1) & adj2)))
  # We do not remove the number of nodes as only the
  # diagonal values of 1 - adj1 are ones.

  # 1obs 0pred (FN)
  fn <- length(which((adj1 & (1 - adj2))))
  # We do not remove the number of nodes as only the
  # diagonal values of 1 - adj2 are ones.
  pp <- tp + fp
  # Predicted negative = false negative + true negative
  pn <- fn + tn

  # Observed positive = true positive + false negative
  op <- tp + fn
  # Observed negative = true negative + false positive
  on <- tn + fp

  # We compute products because otherwise we reach the limit
  # of the numbers R can handle in calculations.
  pp_op <- pp * op
  pn_on <- pn * on

  mcc <- (tp * tn - fp * fn) / ( sqrt(pp_op) * sqrt(pn_on) )
  kappa <- ( K * (tp + tn) - (on * pn) - (op * pp)) / (K^2 - (on * pn) - (op * pp))
  fdr <- fp / (tp + fp)
  acc <- (tp + tn) / K
  sens <- tp / (tp + fn)
  spec <- tn / (tn + fp)
  prec <- tp / (tp + fp)
  f<-2*sens*prec/(sens+prec)
  out<-data.frame(TP=tp, FP=fp, FN=fn, TN=tn,ACC=acc,MCC=mcc,Fmea=f, TPR=sens,FPR=1-spec)
  return(out)
}
