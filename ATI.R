

######################
##                  ##
##     Raw Data     ##
##                  ##
######################

# Windows install (change the path according to the version)
# install.packages("quantmod","C:/Program Files/R/R-2.15.3/library", dependencies = TRUE)
# OSX Install
# install.packages("quantmod", dependencies = TRUE)
library(quantmod)


# Download the list of all ASX listed company 
# Download link:  http://www.asx.com.au/asx/research/listedCompanies.do

company_list <- read.csv("~/Documents/ATI/Data/ASXListedCompanies_2013-06-15.csv")

# Modify the company symbol with ".AX" to use google finance/yahoo finance
company_list$symbl <- paste(company_list[,2],".AX", sep = "")


#################################################################################################
#
# This part of the code is to check the downloaded companies and generate a list of downloading
# failure 

# get a list of all object in the current working space (including all downloaded and others)
downloaded <- data.frame(ls())

# inner join with the original company list to get the list of downloaded companies "b"
b <- merge(downloaded, company_list, 
	by.x = "ls..", by.y = "symbl", all.x = FALSE, all.y = FALSE)

# only needs the symbols
b <- data.frame(b[,1])

colnames(b) <- "symbl"

# to do an anti-join with the original list to get a list of companies which are not yet 
# downloaded
# create a new col in b
b$i <- 0

# do a full outer join, and use the "na" value in b$i as an indicator to achieve the anti-join
d <- merge (b, company_list, by.x = "symbl", by.y = "symbl", all.y = TRUE)
d <- d[is.na(d$i)==TRUE,]

# getSymbols() function works with character strings so converting it from factors to characters
d <- d[,-2]
d[,1] <- as.character(d[,1])
company_list1 <- d
  
#################################################################################################



# Looping through all company to download stock data

for (i in 1:length(company_list[,4])) {
  try(getSymbols(company_list[i,4]),TRUE)}

# There are companies with no price available, using try() function to ignore those.

# Company_list1 is all companies with no price information available at the time of downloading 
# data.



######################
##                  ##
## Additional Data  ##
##                  ##
######################

#calculate daily returns

company_list <- as.character(b[,1])

n = length(company_list)

# initial the process
i=1
zz <- (get(company_list[i]))
r <- periodReturn(zz,period = 'daily', type = 'log')
colnames(r) <- company_list[i]
rt <- r
# rt <- merge(rt,r)
rm(r,zz) 


# merge all into rt
for (i in 2:n)
{
  zz <- (get(company_list[i]))
  r <- periodReturn(zz,period = 'daily', type = 'log')
  colnames(r) <- company_list[i]
  
  rt <- merge(rt,r)
  
  rm(r,zz) 
}




###################################
###    Modelling Framework      ###
###################################

# 
# 1. Two models are required, one for predicting positive returns and one for predictig 
#    negative returns 
#     -- When defining outcome window ,  time period definition: 4 weekly or monthly depending 
#        on which are more predictable
#     --    
# 
# 2. Data structure: 
#     
#     -- n x (p + t) matrix 
#         - n = number of stocks, 
#         - p = number of predictors (stock ratios across different time lags, 
#			industry segments,...)  
#         - t = number of targets (positve / negative future returns)
#   
#     -- the target variables need to be defined based on transaction costs (from CommSec)
#  
# 3. Candidate models
#     
#     -- randomForests
# 
# 
# 4. Validation
# 
#     -- 12 month profit loss simulation is required 

barChart(AAC.AX)
addADX(n=7)  
  
aa <- data.frame(AAC.AX)  
 
  
  





