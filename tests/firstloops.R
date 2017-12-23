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


indata = readnma("cipriani_2011")

type = function (indata) {
  if(indata$format != "iv"){
  paste("long_",indata$type,sep="")
  }else{
    "iv"
  }
}

hatmat = function (indata, model="random", sm="OR") {
  return (
  getHatMatrix(indata$data,type=type(indata),model=model,sm=sm)
)}
 
stats = streamStatistics(hatmat(indata))

treatorder = c("ARI", "HAL", "LITH","PLA", "ASE", "OLA", "CARB","DIV", "QUE", "RIS","ZIP", "LAM", "PAL", "TOP")

edgelist = c(
 "ARI --HAL ","ARI --LITH","ARI --PLA" ,"ASE --OLA" ,"PLA --ASE" ,"CARB--DIV"
,"HAL --CARB","PLA --CARB","LITH--DIV" ,"OLA --DIV" ,"PLA --DIV" ,"HAL --OLA"
,"HAL --PLA ","HAL --QUE ","HAL --RIS" ,"HAL --ZIP" ,"LITH--LAM" ,"LITH--OLA"
,"LITH--PLA ","LITH--QUE ","PLA --OLA" ,"OLA --RIS" ,"PLA --PAL" ,"QUE --PAL"
,"PLA --QUE ","PLA --RIS ","PLA --TOP" ,"PLA --ZIP")

firstloops = unlist ( lapply(FUN = function(comp){Filter(x=comp$streams,f=function(str){str$length==2})},stats$streamContribution), recursive = F )

writeLines(jsonlite::toJSON(lapply(firstloops,function(row){row[1,]})),"firstloopsmania.json")
