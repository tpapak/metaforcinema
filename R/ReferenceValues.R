#measurement can be "binary" or "continuous"
#InterventionComparisonType can be "Pharmacological vs Placebo/Control" "Pharmacological vs Pharmacological" "Non-pharmacological vs any"
#OutcomeType has different values depending on whether measurement is "binary" or "continuous"
#if measurement is "binary" OutcomeType can be "Objective", "Semi-objective" or "Subjective"
#if measurement is "continuous" OutcomeType can be:
#"Obstetric outcome", "Resource use and hospital stay/process", "Internal and external structure-related outcome"
#"General physical health and adverse event and pain and quality of life/functioning"
#"Signs/symptoms reflecting continuation/end of condition and infection/onset of new acute/chronic disease"
#"Mental health outcome", "Biological marker" or "Various subjectively measured outcomes"


ReferenceValues <- function(measurement,OutcomeType,InterventionComparisonType){
  
  library(MASS)
  
  LogMean=NULL
  LogSD=NULL
  LogTmean=NULL
  LogTsd=NULL
  quantiles=NULL
  
  if (measurement=="binary"){
    
    if (InterventionComparisonType=="Pharmacological vs Placebo/Control"){
      if (OutcomeType=="Objective"){
        LogMean=-4.06
        LogSD=1.45  
      }
      if (OutcomeType=="Semi-objective"){
        LogMean=-3.02
        LogSD=1.85
      }
      if (OutcomeType=="Subjective"){
        LogMean=-2.13
        LogSD=1.58
      }
    }
      
    if (InterventionComparisonType=="Pharmacological vs Pharmacological"){
      if (OutcomeType=="Objective"){
        LogMean=-4.27
        LogSD=1.48
      }
      if (OutcomeType=="Semi-objective"){
        LogMean=-3.23
        LogSD=1.88
      }
      if (OutcomeType=="Subjective"){
        LogMean=-2.34
        LogSD=1.62
      }
    }
      
    if (InterventionComparisonType=="Non-pharmacological vs any"){
      if (OutcomeType=="Objective"){
        LogMean=-3.93
        LogSD=1.51
      }
      if (OutcomeType=="Semi-objective"){
        LogMean=-2.89
        LogSD=1.91
      }
      if (OutcomeType=="Subjective"){
        LogMean=-2.01
        LogSD=1.64
      }
    }
      
    quantiles=cbind(
      qlnorm(0.25, meanlog = LogMean, sdlog = LogSD^2, log = FALSE),
      qlnorm(0.5, meanlog = LogMean, sdlog = LogSD^2, log = FALSE),
      qlnorm(0.75, meanlog = LogMean, sdlog = LogSD^2, log = FALSE)
    )
    
  }
  
  if (measurement=="continuous"){
    
    if (InterventionComparisonType=="Pharmacological vs Placebo/Control"){
      
      if (OutcomeType=="Obstetric outcome"){
        LogTmean=-4.13
        LogTsd=2.34  
      }
      
      if (OutcomeType=="Resource use and hospital stay/process"){
        LogTmean=-2.55
        LogTsd=2.73  
      }
      
      if (OutcomeType=="Internal and external structure-related outcome"){
        LogTmean=-2.43
        LogTsd=2.50  
      }
      
      if (OutcomeType=="General physical health and adverse event and pain and quality of life/functioning"){
        LogTmean=-3.16
        LogTsd=2.50  
      }
      
      if (OutcomeType=="Signs/symptoms reflecting continuation/end of condition and infection/onset of new acute/chronic disease"){
        LogTmean=-3.00
        LogTsd=2.50  
      }
      
      if (OutcomeType=="Mental health outcome"){
        LogTmean=-2.99
        LogTsd=  2.16
      }
      
      if (OutcomeType=="Biological marker"){
        LogTmean=-3.41
        LogTsd=  2.83
      }
      
      if (OutcomeType=="Various subjectively measured outcomes"){
        LogTmean= -2.76
        LogTsd=  2.58
      }
      
    }
    
    if (InterventionComparisonType=="Pharmacological vs Pharmacological"){
      if (OutcomeType=="Obstetric outcome"){
        LogTmean=-4.40
          LogTsd=  2.31
      }
      
      if (OutcomeType=="Resource use and hospital stay/process"){
        LogTmean=-2.83
          LogTsd=  2.70
      }
      
      if (OutcomeType=="Internal and external structure-related outcome"){
        LogTmean=-2.70
          LogTsd=  2.46
      }
      
      if (OutcomeType=="General physical health and adverse event and pain and quality of life/functioning"){
        LogTmean=-3.44
          LogTsd=  2.44
      }
      
      if (OutcomeType=="Signs/symptoms reflecting continuation/end of condition and infection/onset of new acute/chronic disease"){
        LogTmean=-3.27
          LogTsd=  2.47
      }
      
      if (OutcomeType=="Mental health outcome"){
        LogTmean=-3.27
          LogTsd=  2.14
      }
      
      if (OutcomeType=="Biological marker"){
        LogTmean=-3.68
          LogTsd=  2.78
      }
      
      if (OutcomeType=="Various subjectively measured outcomes"){
        LogTmean=-3.03
          LogTsd=  2.59
      }
      
    }
    
    if (InterventionComparisonType=="Non-pharmacological vs any"){
      if (OutcomeType=="Obstetric outcome"){
        LogTmean=-3.99
          LogTsd=  2.11
      }
      
      if (OutcomeType=="Resource use and hospital stay/process"){
        LogTmean=-2.41
          LogTsd=  2.57
      }
      
      if (OutcomeType=="Internal and external structure-related outcome"){
        LogTmean=-2.29
          LogTsd=  2.32
      }
      
      if (OutcomeType=="General physical health and adverse event and pain and quality of life/functioning"){
        LogTmean=-3.02
          LogTsd=  2.27
      }
      
      if (OutcomeType=="Signs/symptoms reflecting continuation/end of condition and infection/onset of new acute/chronic disease"){
        LogTmean=-2.86
          LogTsd=  2.33
      }
      
      if (OutcomeType=="Mental health outcome"){
        LogTmean=-3.85
          LogTsd=  1.93
      }
      
      if (OutcomeType=="Biological marker"){
        LogTmean=-3.27
          LogTsd=  2.66
      }
      
      if (OutcomeType=="Various subjectively measured outcomes"){
        LogTmean=-2.62
          LogTsd=  2.41
      }
      
    }
    
    qt_ls <- function(prob, df, mu, a) qt(prob, df)*a + mu
    
    quantiles=cbind(
      (exp(qt_ls(0.25,5,LogTmean,LogTsd))),
      (exp(qt_ls(0.5,5,LogTmean,LogTsd))),
      (exp(qt_ls(0.75,5,LogTmean,LogTsd)))
    )
    
  }

  return(list(LogMean=LogMean,LogSD=LogSD,
              LogTmean=LogTmean,
              LogTsd=LogTsd,quantiles=quantiles))  
  
}

plotLogNormal <- function(mean,sd) {
  library(ggplot2)
  xs = seq(0,1,0.00001)
  dln <- mapply(function(x) {gdl(x,out$LogMean, out$LogSD)},xs)
  oplt <- data.frame(xs, dln)
  ppl <- ggplot(oplt)+geom_line(data=oplt,aes(xs,dln))+scale_x_log10()
  ppl
}
