
# GAEM: Genetic Algorithm Based Expectation Maximization For Inferring Gene Regulatory Networks From Incomplete Data

<img src="GAEM2.png" style="width:40%;" align=right>

## Description

GAEM employs an iterative approach combining Genetic Algorithm and Expectation Maximization methodologies to infer GRN structures from incomplete data. This iterative process updates imputed values based on learned GRNs until convergence.  Part A depicts the input (complete data set and GRN gold standard). In Part B, each data set is artificially perturbed under Missing at Random (MAR) and Not Missing at Random (NMAR) mechanisms, each with 5%, 15%, and 40% percentages of missingness values. Part C illustrates the process of imputing and learning the directed structure of the GRN from incomplete data sets using SVD, KNN, and GAEM algorithm. The outputs are shown in Part D. F-measure and RMSE are reported in Part E.

## Installation
```
install.packages("devtools")
# Install GAEM
devtools::install_github("parniSDU/GAEM")
```
### Required Arguments (ordered)
1. Incomelte data set---> incom,
2. Population size---> pSize,
3. Thresold for Conditional Mutual Information---> lambda,
4. Algorithm for directing the edges ---> mode= c("pc", "hc"),
5. Score measure for structure building---> sco= c("loglik-g","aic-g","bic-g","pred-loglik-g","bge"),
6. Probability of crossover---> pcross,
7. Probability of mutation---> pmut,
8. Maximum iteration for convergence---> maxiter, 
9. Error tollerance---> error
- Notes:
  - The Incomelte data set is represented by matrix in txt format, where rows show the genes and columns show the samples.

### Outputs: A list containing:

-An imputed data set---> Best,<br>
-A learnt GRN---> BestDag,<br>
-Maximum fitness value---> MaxFit,<br>
-Vector of fitness values---> FitVec

### Example
```
library(GAEM)

#Read the original data, missing data and gold-standard 
original<-read.table(file="examples/Dream10.txt", header=TRUE)
incomplete<-read.table(file="examples/DREAM10_MAR_10%.txt", header=TRUE)
gold_standard = read.csv(file="examples/true_10.csv", header=TRUE,row.names = 1)
gold_standard_graph<-as(as.matrix(gold_standard), "graphNEL")

#Run GAEM
result<-GAEM(incom= incomplete, pSize=10,  lamda=0.05, mode="pc", sco="bge",
             pcross=0.85,pmut=0.15,maxiter=50, error=0.00001 )

#Compare the imputed data set with the original data set, and the learnt GRN with the true GRN
cmp<-c(comp(gold_standard_graph, result$BestDag),RMSE=sqrt(mean(as.matrix((original-result$Best)^2))))
```

## Contributions, Questions, Issues, and Feedback

Users interested in expanding functionalities in GAEM are welcome to do so.Issues reports are encouraged through Github's
[issue tracker]([https://github.com/parniSDU/GAEM/issues]).

## Citation

If you use GAEM in your work, we kindly ask that you cite the following paper:

```bibtex
@ARTICLE{Niloofar,
  title         = "GAEM: Genetic Algorithm Based Expectation-Maximization For Inferring Gene Regulatory Networks From Incomplete Data",
  author        = "Parisa Niloofar and  Rosa Aghdam and
                   Changix Eslahchi",
  year          =  2024,
  archivePrefix = "arXiv"
}
```

