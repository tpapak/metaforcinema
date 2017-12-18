Sys.setenv(LANG = "en")
rm(list=ls())

library("devtools")
install_version("netmeta",version="0.9-6")
install_github("esm-ispm-unibe-ch/dataformatter")
install_github("esm-ispm-unibe-ch/flow_contribution")
install_github("esm-ispm-unibe-ch/nmadata")
install.packages("rlist")
install.packages("dplyr")

library(dataformatter)
library(contribution)
library(nmadata)

#indata = read.csv("long_conti.csv",header=TRUE,sep=";")
#C = getHatMatrix(indata,type="long_continuous",model="random",sm="MD")

#wideData = read.csv2("Cipriani 2011_withRoB_AC.csv",header=TRUE,sep=",")
#indata = wide2long(wideData,"binary")
#C = getHatMatrix(indata,type="long_binary",model="random",sm="OR")


data(cipriani_2011)
wideData = cipriani_2011
indata = wide2long(wideData,"binary")





C = getHatMatrix(indata,type="long_binary",model="random",sm="OR")


 
cl = streamStatistics(C)
