rm(list=ls())
source("~/Documents/flow_contribution/R/hatmatrix.R")
source("~/Documents/flow_contribution/R/nmadbhatmatrix.R")
source("~/Documents/flow_contribution/R/contributionrow.R")
source("~/Documents/flow_contribution/R/studycontribution.R")
library(readr)
library(devtools)
install_github("esm-ispm-unibe-ch/dataformatter")
install_github("esm-ispm-unibe-ch/nmadata")
#install.packages("../nmadata_1.0.tar.gz",repos=NULL)
library(nmadata)

listVerified()

testhm = getHatmatrixFromDB(501400, model="random",sm="OR")
comparison = "2:3"

result = getStudyContribution(testhm$hm, comparison)
print(result)

print("contributions sum to 100")
print(all.equal(sum(result$contribution),100))
