Sys.setenv(LANG = "en")
rm(list=ls())

library(parallel)
library(devtools)
install_github("esm-ispm-unibe-ch/flow_contribution")
#install_github("esm-ispm-unibe-ch/nmadata")
install.packages("../../nmadata_1.0.tar.gz",repos=NULL)

library(contribution)
library(nmadata)


testdata = lapply(nmadatanames(),readnma)

type = function (indata) {
  if(indata$format != "iv"){
  paste("long_",indata$type,sep="")
  }else{
    "iv"
  }
}

hatmat = function (indata){
  getHatMatrix(indata$data,type=type(indata),model="random",sm="OR")
}
 
cl = mclapply(testdata,function(dts){
  list( data = dts
      , stats = streamStatistics(hatmat(dts))
      )
})

lapply(cl,
       function(dataset){
   plot(dataset[[1]]$cummulativeContributionPerStream)
   })
