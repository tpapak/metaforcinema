Sys.setenv(LANG = "en")
rm(list=ls())
library("devtools")
indata = read.csv("CINeMAnet.csv",header=TRUE,sep=",")


library(meta)
library(plyr)

#install_version("netmeta",version="0.9-5")
install.packages("netmeta")
library(netmeta)
#install_github("esm-ispm-unibe-ch/flow_contribution")

 
D <- indata
sm = "OR"

metaNetw=netmeta(effect,se,t1,t2,id,data=D,sm=sm,comb.fixed =T,comb.random = F,details.chkmultiarm=TRUE)
#metaNetw=netmeta(effect,se,t1,t2,id,data=D,sm=sm)


#Res = getHatMatrix(indata,type="iv",model="random",sm="OR")

print(metaNetw)
















