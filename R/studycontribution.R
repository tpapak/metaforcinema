#Gives contributions of individual studies for a single comparison
# arguments hm = hatmatrix list from getHatMatrix and comparison the string
# identifying the hatmatrix row separated by ":"
getStudyContribution = function (hm, comparison) {
  contribution = getComparisonContribution(hm, comparison)
  model = hm$model
  net = hm$netmetaObject
  tau = 0
  if (model=="random"){
    tau = net$tau
  }
  # main data frame
  dfr=data.frame(net$studlab,net$treat1,net$treat2,net$seTE,net$seTE.adj)
  dfr$comp=paste(dfr$net.treat1,dfr$net.treat2,sep=":")
  dfr$w.adj = 1 / ((dfr$net.seTE.adj)^2+(tau)^2)
 
  studyContribution = function (direct){
    aux = dfr[dfr$comp==direct,]
    normfac = sum(aux[,"w.adj"])
    per = contribution$contribution[direct]
    studycontr = lapply(row.names(aux),function(row){
      w = aux[row,"w.adj"]
      out = data.frame(study=''
                       , contribution=0
                       ,comparison='')
      out$study = aux[row,"net.studlab"]
      out$contribution = w * per / normfac
      out$comparison = direct
      return(out)
    })
    return(studycontr)
  }

  outlist = Reduce(function(acc,col){stw=studyContribution(col);return(c(acc,stw))},contribution$names,list(),accumulate=F)

  comps = unlist(lapply(outlist, function(r) {r$comparison}))
  studies = unlist(lapply(outlist, function(r) {r$study}))
  contrs = unlist(lapply(outlist, function(r) {r$contribution}))

  result=data.frame(study=studies,contribution=contrs,comparison=comps)

  return(result)
}
