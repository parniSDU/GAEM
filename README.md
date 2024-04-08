
# GAEM: Genetic Algorithm Based Expectation Maximization For Inferring Gene Regulatory Networks From Incomplete Data

<img src="GAEM2.png" style="width:40%;" align=right>
![ ](https://img.shields.io/github/languages/code-size/parniSDU/GAEM)

## Description

GAEM employs an iterative approach combining Genetic Algorithm and Expectation Maximization methodologies to infer GRN structures from incomplete data. This iterative process updates imputed values based on learned GRNs until convergence.  Part A depicts the input (complete data set and GRN gold standard). In Part B, each data set is artificially perturbed under Missing at Random (MAR) and Not Missing at Random (NMAR) mechanisms, each with 5%, 15%, and 40% percentages of missingness values. Part C illustrates the process of imputing and learning the directed structure of the GRN from incomplete data sets using SVD, KNN, and GAEM algorithm. The outputs are shown in Part D. F-measure and RMSE are reported in Part E.

## Requirements

This program requires C++20 or higher, and g++.

### Windows

```bash
mkdir obj
make
```

In addition to C++20 and g++, Windows requires a special means to run the provided makefile. The MinGW Package Manager provides a lightweight make function. It is recommended to download MinGW [here](https://sourceforge.net/projects/mingw/), and follow [this guide](https://linuxhint.com/run-makefile-windows/) for installation, however any method for compiling C++ using g++ should suffice.

## Usage

This utility has the form `./minaa.exe <G> <H> [-B=bio] [-a=alpha] [-b=beta]`.

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

### Examples

Examples of GAEM's usage with DREAM3 size 10 can be found in the `examples/` directory.

## Simulations in the Manuscript

All scripts and instructions to reproduce the analyses in the manuscript can be found in the `simulations/` directory.

## Contributions, Questions, Issues, and Feedback

Users interested in expanding functionalities in MiNAA are welcome to do so. Issues reports are encouraged through Github's [issue tracker](https://github.com/solislemuslab/minaa/issues). See details on how to contribute and report issues in [CONTRIBUTING.md](https://github.com/solislemuslab/minaa/blob/master/CONTRIBUTING.md).

## License

MiNAA is licensed under the [MIT](https://opensource.org/licenses/MIT) license. &copy; SolisLemus lab (2024).

## Citation

If you use GAEM in your work, we kindly ask that you cite the following paper:

```bibtex
@ARTICLE{Nelson2022,
  title         = "GAEM: Genetic Algorithm Based Expectation-Maximization For Inferring Gene Regulatory Networks From Incomplete Data",
  author        = "Parisa Niloofar and  Rosa Aghdam and
                   Changix Eslahchi",
  year          =  2024,
  archivePrefix = "arXiv"
}
```

