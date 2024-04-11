
comp_imp <-  function(obs , pred) {
  squared_diff <- as.matrix((obs-pred)^2)
absolute_diff <- as.matrix(abs(obs-pred))
mae<-mean(absolute_diff)
  mse <- mean(squared_diff)
  rmse <- sqrt(mse)
  nrmse <- rmse/mean(as.matrix(obs))
  return(list(MAE=mae, MSE= mse, RMSE= rmse, NRMSE= nrmse))

}

#comp_imp(DREAM10, result$Best)
