##############################################################
#This file scrapes descriptive data from PEMRA's website 
#regarding the number of complaints by TV channel

# Faisal Sohail - 25th Sep 2016
##############################################################
library(XML)
library(foreign)

# December 2011 is the first year
url       = "http://58.65.182.183/complaints/index1.php?m=December&yy=2011"

tables   <- readHTMLTable(url)
table     = tables[[5]]
table[4]  = "December 2011"

# Get data from 2012 to 2015 by month
month     = c("January", "February", "March", "April", "May","June","July", "August", "September", "October", "November", "December")

for (j in month){
  for (i in 2012:2015) {
    
    url1       = paste("http://58.65.182.183/complaints/index1.php?m=",j,sep="")
    url2       = paste(url1,"&yy=",i,sep="")
    tables     = readHTMLTable(url2)
    temptable  = tables[[5]]
    temptable[4]  = paste(j," ",i)
    table      = rbind(table,temptable)  
  }
}

# Get data from 2016
month     = c("January", "February", "March", "April", "May","June","July", "August")

for (j in month){
  for (i in 2016) {
    
    url1       = paste("http://58.65.182.183/complaints/index1.php?m=",j,sep="")
    url2       = paste(url1,"&yy=",i,sep="")
    tables     = readHTMLTable(url2)
    temptable   = tables[[5]]
    temptable[4]  = paste(j," ",i,sep="")
    table      = rbind(table,temptable)  
  }
}


write.table(table, "pemra_summary.txt", sep=",")
