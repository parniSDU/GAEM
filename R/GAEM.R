#' GAEM: Genetic Algorithm Based Expectation Maximization For Inferring Gene Regulatory Networks From Incomplete Data
#'
#' @param  incom Incomelte data set
#' @param  pSize Population size
#' @param lambda ????
#' @param mode Algorithm for directing the edges c("pc", "hc"),
#' @param sco Score measure for structure building c("loglik-g","aic-g","bic-g","pred-loglik-g","bge"),
#' @param pcross Probability of crossover
#' @param pmut Probability of mutation
#' @param maxiter Maximum iteration for convergence
#' @param error Error tollerance
#' @return A list containing: An imputed data set (Best), a learnt GRN (BestDag),Maximum fitness value (MaxFit) and Vector of fitness values (FitVec).



GAEM<-function(incom, pSize,  lamda,mode, sco,
               pcross,pmut,maxiter=50, error=0.0001 ){

  #Creating an empty vector to store fitness values
  fittest_vec<-NULL
  count<-1
  #Initialize population
  pop_ini<-Initialize_population(incom,pSize)

  #Calculate fitness of each individual
  FitnessParam<-numeric(pSize)
  for (i in 1:pSize){
    FitnessParam[i]<-FitnessCalc(pop_ini[[i]],incom, lamda ,mode,sco)
  }
  fittest<-min(FitnessParam)
  fittest_vec<-c(fittest_vec,fittest)
  paste("Generation",count, "Best= ", fittest)

  #While population gets an individual with maximum fitness
  while ((fittest > error)& (count<maxiter)) {
    #++demo.generationCount;
    count<-count+1

    ord <- order(FitnessParam, decreasing = FALSE)
    PopSorted <- pop_ini[ord]
    FitnessSorted <- FitnessParam[ord]

    #Do crossover
    nmating <- floor(length(PopSorted[1:floor(pSize/2)])/2)
    mating <- matrix(sample(1:length(PopSorted[1:floor(pSize/2)]), size = (2 *nmating)), ncol = 2)
    cro<-NULL
    for (i in seq_len(nmating)) {
      if (pcross > runif(1)) {
        par <- mating[i, ]
        cro<-c(cro,CrossOver(PopSorted[1:floor(pSize/2)],par))

      }
    }

    pop_ini<-c(PopSorted,cro)
    FitnessParam<-c(FitnessSorted,rep(NA,length(cro)))

    #Do mutation under a random probability (pmut)
    mu<-Mutation(pop_ini,pmut,incom,pSize)
    pop_ini<-c(pop_ini,mu)
    FitnessParam<-c(FitnessParam,rep(NA,length(mu)))

    for (i in 1:length(FitnessParam)) if (is.na(FitnessParam[i])) {
      FitnessParam[i]<-FitnessCalc(pop_ini[[i]],incom, lamda ,mode,sco)
    }
    ord <- order(FitnessParam, decreasing = FALSE)
    PopSorted <- pop_ini[ord]
    FitnessSorted <- FitnessParam[ord]
    pop_ini<-PopSorted[1:pSize]
    FitnessParam <- FitnessSorted[1:pSize]
    fittest<-min(FitnessParam)
    best<-pop_ini[[which(FitnessParam==fittest)]]
    fittest_vec<-c(fittest_vec,fittest)
    print(paste("Generation",count, "Best= ", fittest))
  }

  best_dag<-Sstep(as.data.frame(best), lamda, mode,sco)

  return(list(Best=best, BestDag=best_dag, MaxFit=fittest, FitVec=fittest_vec))

}
