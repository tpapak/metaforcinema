Sys.setenv(LANG = "en")
rm(list=ls())

setwd("~/Documents/flow_contribution/")


library(parallel)
library(devtools)
#install_github("esm-ispm-unibe-ch/dataformatter")
#install_github("esm-ispm-unibe-ch/nmadata")
#install_github("esm-ispm-unibe-ch/flow_contribution")
source("./R/streamstatistics.R")

library(dataformatter)
library(contribution)
library(nmadata)


#indata = read.csv("./tests/ms.csv")
indata = read.csv2("./tests/griselda/griselda.csv")
hatmat = getHatMatrix(indata,type="long_binary",model="random",sm="OR")

 
stats = streamStatistics(hatmat)

hist=data.frame(contribution = 
    cbind(mapply(function(c){return(toString(c$comparison))},(unlist(stats$lengthfrequency2,recursive=F)))), 
  len = 
    cbind(mapply(function(c){return(c$length)},(unlist(stats$lengthfrequency2,recursive=F)))) 
  )

#get first order loops
fol = hist[hist$len==2,]
hs = table(fol)
hist(hs)

hist(hs, breaks=seq(min(hs)-0.5, max(hs)+0.5, by=1)  )

plot(stats$cummulativeContributionPerStream)
