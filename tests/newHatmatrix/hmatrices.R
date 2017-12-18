#illustrate using the Senn 2013 data
library(netmeta)
data(Senn2013)
net1 <- netmeta(TE, seTE, treat1, treat2, studlab,
                data=Senn2013, sm="MD",prediction = T)

#alternative 1: what we are doing so far 
  #for fixed effect
  Hkrahn=netmeta:::nma.krahn(net1)$H
  X.full=netmeta:::nma.krahn(net1)$X.full
  direct=netmeta:::nma.krahn(net1)$direct
  X=netmeta:::nma.krahn(net1)$X.full[direct$comparison,,drop=FALSE]
  Vd=diag(direct$seTE^2,nrow=length(direct$seTE),ncol=length(direct$seTE))

  H <- X.full %*% solve(t(X) %*% solve(Vd) %*% X) %*% t(X) %*% solve(Vd)
  colnames(H)<-rownames(X)

  N=H%*%(direct$TE)
  Nnetmeta=net1$TE.fixed[lower.tri(net1$TE.fixed)]
  cbind(N,Nnetmeta)
  (N-Nnetmeta>0.01)

  #for random effects
  Hkrahn=netmeta:::nma.krahn(net1,tau.preset = net1$tau)$H
  X.full=netmeta:::nma.krahn(net1,tau.preset = net1$tau)$X.full
  direct=netmeta:::nma.krahn(net1,tau.preset = net1$tau)$direct
  X=netmeta:::nma.krahn(net1,tau.preset = net1$tau)$X.full[direct$comparison,,drop=FALSE]
  Vd=diag(direct$seTE^2,nrow=length(direct$seTE),ncol=length(direct$seTE))
  
  H <- X.full %*% solve(t(X) %*% solve(Vd) %*% X) %*% t(X) %*% solve(Vd)
  colnames(H)<-rownames(X)
  
  N=H%*%(direct$TE)
  Nnetmeta=net1$TE.random[lower.tri(net1$TE.random)]
  cbind(N,Nnetmeta)
  (N-Nnetmeta>0.1)
  
#alternative 2: H.matrix from Rucker
  H0 <- net1$H.matrix
  dim(H0)          
  H0%*%net1$TE
  #need to find a way to produce all NMA
  
#alternative 3: pairwise meta-analysis using reduced weights
  #fixed
  comp<-paste(net1$treat1,rep(":",length(net1$treat1)),net1$treat2)
  
  a=metagen(TE=net1$TE,seTE=net1$seTE.adj,studlab=net1$studlab,byvar = comp,sm="MD",comb.fixed=T)
  #length(a$seTE.fixed.w)

  b=data.frame(a$bylevs,a$TE.fixed.w,a$seTE.fixed.w)
  b <- b[order(b$a.bylevs),]
  Vda=matrix(0,length(a$bylevs),length(a$bylevs))
  diag(Vda)=(b$a.seTE.fixed.w)^2

  Hkrahn=netmeta:::nma.krahn(net1)$H
  X.full=netmeta:::nma.krahn(net1)$X.full
  direct=netmeta:::nma.krahn(net1)$direct
  X=netmeta:::nma.krahn(net1)$X.full[direct$comparison,,drop=FALSE]
  #Vd=diag(direct$seTE^2,nrow=length(direct$seTE),ncol=length(direct$seTE))
  
  H <- X.full %*% solve(t(X) %*% solve(Vda) %*% X) %*% t(X) %*% solve(Vda)
  colnames(H)<-rownames(X)
  
  N1=H%*%(direct$TE)
  Nnetmeta=net1$TE.fixed[lower.tri(net1$TE.fixed)]
  cbind(N,N1,Nnetmeta)
  (N-Nnetmeta>=N1-Nnetmeta)
  (N1-Nnetmeta>0.01)
  
  

  
  
  
  
  
  
  
  
  
  