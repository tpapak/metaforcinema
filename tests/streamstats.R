Sys.setenv(LANG = "en")
rm(list=ls())

library(parallel)
library(devtools)
install_github("esm-ispm-unibe-ch/flow_contribution")
install_github("esm-ispm-unibe-ch/nmadata")
#install.packages("../../nmadata_1.0.tar.gz",repos=NULL)

#source("../R/hatmatrix.R")
#source("../R/contributionrow.R")
#source("../R/streamstatistics.R")
library(contribution)
library(nmadata)


testdata = lapply(nmadatanames(),readnma)

hatmat = function (indata){
  getHatMatrix(indata$data,type=longType(indata),model="random",sm="OR")
}
 
#cl = mclapply(head(testdata,1),function(dts){
cl = lapply(testdata,function(dts){
                print(dts$name)
  list( data = dts
      , stats = streamStatistics(hatmat(dts))
      )
})

#lapply(cl,
       #function(dataset){
   #plot(dataset[[1]]$cummulativeContributionPerStream)
#})
