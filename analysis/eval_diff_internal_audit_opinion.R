#################################################################################################
## evaluation of difference between audit opinion for internal accounting management for firms ##
#################################################################################################

#######################################
## load data from package accounting ##
#######################################

# install_github("blu2ego/accounting")
library(accounting)
data("internal")

###############################################
## process data to extract the audit opinion ##
###############################################

iao <- list()
firms_obs <- length(internal)
for (i in 1:firms_obs) {
  year_obs <- length(internal[[i]])
  for (j in 1:year_obs) {
    iao[[i]][j] <- internal[[i]][[j]]$`내부회계관리제도 감사보고서`  
  }
}



