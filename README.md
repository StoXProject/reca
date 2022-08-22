
<!-- README.md is generated from README.Rmd. Please edit that file -->
R-eca - Estimating Catch-at-Age
===============================

Reca is a package made for the Institute of Marine Research. The package produces predictions of catch-at-age, i.e. the number of fish caught within each age group, of different fish species.

Predicting the catch-at-age of commercial fish species is an important part of the quota-setting process for many diferent species. The Norwegian Computing Center and the Institute of Marine Research have over years developed a Bayesian hierarchical model to estimate the catch-at-age of fish. The model aims to estimate both the proportion-at-age and the mean weight of fish, in order to convert total landings statistics to numbers at age.

Maintainance policy
---------

The primary source for the Reca package is the repository maintained by the Norwegian computing centre: https://github.com/NorskRegnesentral/Reca, which comes with binaries pre-built for windows and linux. This fork is maintained to document configurations that allow for compiling the library for different operating systems, and to maintain a copy of depencies that are no longer hosted by their original developers. Successful builds are archived in https://github.com/StoXProject/repo/tree/gh-pages. As a side effect this also provides a mac-version for some past releases of mac-os and R, but we are not committed to maintain this workflow, and adaptations to new os or R releases will have low priority.
