Sys.setenv(LANG = "en")
rm(list=ls())
library("devtools")
#install_github("esm-ispm-unibe-ch/flow_contribution")
source("./newHatmatrix/hatmatrices");
#library(contribution)
#indata = read.csv2("binary.csv",header=TRUE)
#indata = read.csv2("diabetes_new.csv",header=TRUE,sep=";")
indata = read.csv2("diabetes_indr.csv",header=TRUE,sep=";")
 
#indata = read.csv("Macfayeden.csv",header=TRUE,sep=";")

Res = getHatMatrix(indata,type="netwide_binary",model="random",sm="OR")
# Direct effects
#md = C$hatMatrix$Pairwise[,1]
#mdsigns = lapply(names(md), function(n){if(strsplit(n," vs ")[[1]][1]<strsplit(n," vs ")[[1]][2]){+1}else{-1}})
#mdsigns = -1 * unlist(mdsigns)
#newnmd = lapply(names(md), function(n){paste(sort(unlist(strsplit(n," vs "))),collapse=":")})
#names(md) = newnmd
#md = md * mdsigns
#md = md[order(names(md))]

#network effects
#hatmatrix
#HM = C$hatMatrix$H2bu
#nmn = HM %*% md
#nmn = unlist(nmn[,1])

#mn = C$hatMatrix$NMA[,1]

 #test that hmatrix works
#print("hatmatrix gives correct network measures")
#print(all.equal(mn,nmn))

















