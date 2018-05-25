## nomSummarize.R - Script to clean ABS NOM data

# Neil Bretana

# Restart R and set working directory to source file location

# Libraries for data manipulation
require(LeftysRpkg)
LoadLibrary(readxl)
LoadLibrary(zoo)

# Key folder paths
basePath <- file.path(dirname(getwd()))
absFolder <- file.path(basePath,"data","ABS", "raw") # Folder with raw ABS data
cleanDataFolder <- file.path(basePath,"data", "ABS") # Where cleaned data goes

# Additional cleaned data folders for copies
cascadeDataFolder <- file.path(basePath,"project_care_cascades", "data",
  "ABS")

# Read in ABS raw data files
nomRawNSW <- read_excel(file.path(absFolder, "NOMdeparturesNSW.xls"))
nomRawACT <- read_excel(file.path(absFolder, "NOMdeparturesACT.xls"))
nomRawNT <- read_excel(file.path(absFolder, "NOMdeparturesNT.xls"))
nomRawQLD <- read_excel(file.path(absFolder, "NOMdeparturesQLD.xls"))
nomRawSA <- read_excel(file.path(absFolder, "NOMdeparturesSA.xls"))
nomRawTAS <- read_excel(file.path(absFolder, "NOMdeparturesTAS.xls"))
nomRawVIC <- read_excel(file.path(absFolder, "NOMdeparturesVIC.xls"))
nomRawWA <- read_excel(file.path(absFolder, "NOMdeparturesWA.xls"))
nomRawAUS <- read_excel(file.path(absFolder, "NOMdeparturesAUS.xls"))

#erpRawNSW <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPNSW.xls")
#erpRawACT <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPACT.xls")
#erpRawNT <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPNT.xls")
#erpRawQLD <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPQLD.xls")
#erpRawSA <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPSA.xls")
#erpRawTAS <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPTAS.xls")
#erpRawVIC <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPVIC.xls")
#erpRawWA <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPWA.xls")
#erpRawAUS <- read_excel("C:/Users/nbretana/Desktop/NOM Data/ERPAUS.xls")

#erp by COB
#RCerpACT <- read.csv(file.path(absFolder, "ERP_COB_ACT.csv", header=TRUE, sep=","))
#RCerpNSW <- read.csv(file.path(absFolder, "ERP_COB_NSW.csv", header=TRUE, sep=","))
#RCerpNT <- read.csv(file.path(absFolder, "ERP_COB_NT.csv", header=TRUE, sep=","))
#RCerpQLD <- read.csv(file.path(absFolder, "ERP_COB_QLD.csv", header=TRUE, sep=","))
#RCerpSA <- read.csv(file.path(absFolder, "ERP_COB_SA.csv", header=TRUE, sep=","))
#RCerpTAS <- read.csv(file.path(absFolder, "ERP_COB_TAS.csv", header=TRUE, sep=","))
#RCerpVIC <- read.csv(file.path(absFolder, "ERP_COB_VIC.csv", header=TRUE, sep=","))
#RCerpWA <- read.csv(file.path(absFolder, "ERP_COB_WA.csv", header=TRUE, sep=","))

RCerpAUS <- read.csv(file.path(absFolder, "ERP_COB_AUS.csv", header=TRUE, sep=","))
RCerpACT <- read_excel(file.path(absFolder, "erpCobACT_cleaned.xls"))
RCerpNSW <- read_excel(file.path(absFolder, "erpCobNSW_cleaned.xls"))
RCerpNT <- read_excel(file.path(absFolder, "erpCobNT_cleaned.xls"))
RCerpQLD <- read_excel(file.path(absFolder, "CerpCobQLD_cleaned.xls"))
RCerpSA <- read_excel(file.path(absFolder, "erpCobSA_cleaned.xls"))
RCerpTAS <- read_excel(file.path(absFolder, "erpCobTAS_cleaned.xls"))
RCerpVIC <- read_excel(file.path(absFolder, "erpCobVIC_cleaned.xls"))
RCerpWA <- read_excel(file.path(absFolder, "erpCobWA_cleaned.xls"))

#cleanup erp by COB
RCerpNames <- c("COB", "Sex", "Age", 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011)
names(RCerpNSW) <- RCerpNames
names(RCerpACT) <- RCerpNames
names(RCerpNT) <- RCerpNames
names(RCerpQLD) <- RCerpNames
names(RCerpSA) <- RCerpNames
names(RCerpTAS) <- RCerpNames
names(RCerpVIC) <- RCerpNames
names(RCerpWA) <- RCerpNames
#names(RCerpAUS) <- RCerpNames

RCerpNSW$`2012` <- NA
RCerpNSW$`2013` <- NA
RCerpNSW$`2014` <- NA
RCerpACT$`2012` <- NA
RCerpACT$`2013` <- NA
RCerpACT$`2014` <- NA
RCerpNT$`2012` <- NA
RCerpNT$`2013` <- NA
RCerpNT$`2014` <- NA
RCerpQLD$`2012` <- NA
RCerpQLD$`2013` <- NA
RCerpQLD$`2014` <- NA
RCerpSA$`2012` <- NA
RCerpSA$`2013` <- NA
RCerpSA$`2014` <- NA
RCerpTAS$`2012` <- NA
RCerpTAS$`2013` <- NA
RCerpTAS$`2014` <- NA
RCerpVIC$`2012` <- NA
RCerpVIC$`2013` <- NA
RCerpVIC$`2014` <- NA
RCerpWA$`2012` <- NA
RCerpWA$`2013` <- NA
RCerpWA$`2014` <- NA

RCerpACT$state <- "ACT"
RCerpNSW$state <- "NSW"
RCerpNT$state <- "NT"
RCerpQLD$state <- "QLD"
RCerpSA$state <- "SA"
RCerpTAS$state <- "TAS"
RCerpVIC$state <- "VIC"
RCerpWA$state <- "WA"

RCerpS <- rbind(RCerpACT, RCerpNSW)
RCerpS <- rbind(RCerpS, RCerpNT)
RCerpS <- rbind(RCerpS, RCerpQLD)
RCerpS <- rbind(RCerpS, RCerpSA)
RCerpS <- rbind(RCerpS, RCerpTAS)
RCerpS <- rbind(RCerpS, RCerpVIC)
RCerpS <- rbind(RCerpS, RCerpWA)

#linearly project missing years out of consensus years for state erps
#cols <- colnames(RCerpNSW)[4:length(colnames(RCerpNSW))]
#rcTmp <- RCerpNSW[1:3,4:length(colnames(RCerpNSW))]
#rcTmp <- RCerpNSW[,4:length(colnames(RCerpNSW))]
#rcTemp <- data.frame(t(apply(RCerpNSW[,4:length(colnames(RCerpNSW))], 1, na.approx)))
#if 2011 is NA, don't do na.approx
#t(apply(rcTmp, 1, na.approx))

#lm
#erpProject <- data.frame(year=c(1996:2011), "0.4"=0, "5.9"=0, "10.14"=0, "15.19"=0, "20.24"=0, "25.29"=0, "30.34"=0, "35.39"=0, "40.44"=0, "45.49"=0, "50.54"=0, "55.59"=0, "60.64"=0, "65.69"=0, "70.74"=0, "75andover"=0, Total=0)
#erpProject$value <- 0

#sampleT <- RCerpNSW[1:10, 4:22]
#sampleX <- data.frame(t(apply(sampleT[,1:16], 1, na.approx)))  
#sampleT[,1:16] <- sampleX
#yearsProject <- data.frame(year=c(2012:2014))

#erpProject <- data.frame(cbind(year=c(1996:2011), t(sampleX[1,]), t(sampleX[2,]), t(sampleX[3,]))) #..total age groups
#mod <- lm(X1~year, data=erpProject)
#sampleT[1,17:19] <- predict(mod, yearsProject)
#mod <- lm(X2~year, data=erpProject)
#sampleT[2,17:19] <- predict(mod, yearsProject)
#mod <- lm(X3~year, data=erpProject)
#sampleT[3,17:19] <- predict(mod, yearsProject)

##

RCerpAll <- data.frame(sex=character(),age=character(), cob=character(), region=character(), year=character(), erp=integer(), stringsAsFactors = FALSE)
index<-1
eIndex<-1
colE <- c("year", "age", "state", "cob", "gender", "erp")
colYrs <- c("1996", "1997", "1998","1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010","2011", "2012", "2013", "2014")
yearsProject <- data.frame(year=c(2012:2014))
addYrs <- c("75 - 79", "80 - 84", "85+")

tData <- RCerpS
#tData <- RCerpS[1:102,]

while(index <= nrow(tData)){
  tCob <- tData$COB[index]
  tState <- tData$state[index] #state
  for(gIndex in 1:3){ #gender M F Total
    tSex <- tData$Sex[index]
    #index <- index + 1
    #index <- index+1
    tempErp <- tData[index:(index+16),4:22]
    #tempApp <- tData[index:(index+16),4:19]
    
    if(!is.na(tempErp$`2011`[1])){
      #transpose and linearly project
      #tempErp <- data.frame(t(apply(tempErp, 1, na.approx)))
      tempApp <- data.frame(t(apply(tempErp[,1:16], 1, na.approx)))
      tempErp[,1:16] <- tempApp
      erpProject <- data.frame(cbind(year=c(1996:2011), t(tempApp[1,]), t(tempApp[2,]), t(tempApp[3,]), t(tempApp[4,]), t(tempApp[5,]), t(tempApp[6,]), t(tempApp[7,]), t(tempApp[8,]), t(tempApp[9,]), t(tempApp[10,]), t(tempApp[11,]), t(tempApp[12,]), t(tempApp[13,]), t(tempApp[14,]), t(tempApp[15,]), t(tempApp[16,]), t(tempApp[17,]))) #..total age groups
      mod <- lm(X1~year, data=erpProject)
      tempErp[1,17:19] <- predict(mod, yearsProject)
      mod <- lm(X2~year, data=erpProject)
      tempErp[2,17:19] <- predict(mod, yearsProject)
      mod <- lm(X3~year, data=erpProject)
      tempErp[3,17:19] <- predict(mod, yearsProject)
      mod <- lm(X4~year, data=erpProject)
      tempErp[4,17:19] <- predict(mod, yearsProject)
      mod <- lm(X5~year, data=erpProject)
      tempErp[5,17:19] <- predict(mod, yearsProject)
      mod <- lm(X6~year, data=erpProject)
      tempErp[6,17:19] <- predict(mod, yearsProject)
      mod <- lm(X7~year, data=erpProject)
      tempErp[7,17:19] <- predict(mod, yearsProject)
      mod <- lm(X8~year, data=erpProject)
      tempErp[8,17:19] <- predict(mod, yearsProject)
      mod <- lm(X9~year, data=erpProject)
      tempErp[9,17:19] <- predict(mod, yearsProject)
      mod <- lm(X10~year, data=erpProject)
      tempErp[10,17:19] <- predict(mod, yearsProject)
      mod <- lm(X11~year, data=erpProject)
      tempErp[11,17:19] <- predict(mod, yearsProject)
      mod <- lm(X12~year, data=erpProject)
      tempErp[12,17:19] <- predict(mod, yearsProject)
      mod <- lm(X13~year, data=erpProject)
      tempErp[13,17:19] <- predict(mod, yearsProject)
      mod <- lm(X14~year, data=erpProject)
      tempErp[14,17:19] <- predict(mod, yearsProject)
      mod <- lm(X15~year, data=erpProject)
      tempErp[15,17:19] <- predict(mod, yearsProject)
      mod <- lm(X16~year, data=erpProject)
      tempErp[16,17:19] <- predict(mod, yearsProject)
      mod <- lm(X17~year, data=erpProject)
      tempErp[17,17:19] <- predict(mod, yearsProject)

    #  tempAddYrs <- tData[index:(index+2),4:22]
    #  tempAddYrs[] <- NA
    #  tempAddYrs[1,] <- tempErp[17,]* #2016 proportion of aged 75-79
    #  tempAddYrs[2,] <- tempErp[17,]* #2016 proportion of aged 80-84
    #  tempAddYrs[3,] <- tempErp[17,]* #2016 proportion of aged 85 and over
      
      #tempErp <- rbind(tempErp[1:16,], tempAddYrs)
      colnames(tempErp) <- colYrs
    }

    ##Add 75_70, tData[index:(index+16), 3]
    #tAges <- rbind(tData[index:(index+15), 3], addYrs[1], addYrs[2], addYrs[3])
    
    tAges <- tData[index:(index+16), 3]
    tT <- NULL
    for(iTemp in 1:19){ #19 yrs
      tX <-cbind(colnames(tempErp)[iTemp], tAges, tState, tCob, tSex, tempErp[,iTemp])
      colnames(tX) <- colE
      tT <- rbind(tT, tX)
    }
    RCerpAll <- rbind(RCerpAll, tT)
    index <- index + 17
  }
}

write.csv(RCerpAll, file.path(cleanDataFolder, "erp_projected_states.xls"), row.names = FALSE)
# RCerpAll <- read.csv("C:/Users/nbretana/Desktop/NOM Data/Results/erp_projected_states.xls", header=TRUE, sep=",")
RCerpAUS <- data.frame(year=RCerpAUS$Time, age=RCerpAUS$Age, state=RCerpAUS$Region, cob=RCerpAUS$Country.of.birth, gender=RCerpAUS$Sex, erp=RCerpAUS$Value, stringsAsFactors = FALSE)
stateCodes <- read.csv(file.path(absFolder, "StateCode.csv"), header=TRUE, sep=",")

#clean ERP
RCerpAll$cob <- as.character(RCerpAll$cob)
RCerpAll$year <- as.character(RCerpAll$year)
RCerpAll$age <- as.character(RCerpAll$age)
RCerpAll$gender <- as.character(RCerpAll$gender)
RCerpAll$state <- as.character(RCerpAll$state)
RCerpAUS$cob <- as.character(RCerpAUS$cob)
RCerpAUS$year <- as.character(RCerpAUS$year)
RCerpAUS$age <- as.character(RCerpAUS$age)
RCerpAUS$gender <- as.character(RCerpAUS$gender)
RCerpAUS$state <- as.character(RCerpAUS$state)

RCerpAUS$state <- stateCodes$code[match(RCerpAUS$state, stateCodes$state)]
RCerpAll$age <- gsub(" ", "", RCerpAll$age, fixed=TRUE)
RCerpAUS$age <- gsub(" ", "", RCerpAUS$age, fixed=TRUE)
RCerpAll$age[RCerpAll$age=="5-Sep"] <- "5-9"
RCerpAUS$age[RCerpAUS$age=="5-Sep"] <- "5-9"
RCerpAll$age[RCerpAll$age=="Oct-14"] <- "10-14"
RCerpAUS$age[RCerpAUS$age=="Oct-14"] <- "10-14"
RCerpAll$age[RCerpAll$age=="Allages"] <- "Total"
RCerpAUS$age[RCerpAUS$age=="Allages"] <- "Total"

RCerpAll <- rbind(RCerpAll, RCerpAUS)
RCerpAll$cob <- trimws(RCerpAll$cob, "both")
RCerpAll$gender <- trimws(RCerpAll$gender, "both")

##Calculate total (all cobs) Males, Females, Persons, for each state 
excludeForTotal <- c("Australian External Territotires, nfd", "Australian External Territotires, nec", "Polynesia (Excludes Hawaii), nec", "Americas", "Antarctica", "Carribean, nfd", "Central Asia, nfd", "Chinese Asia, nfd", "Eastern Europe nfd", "Japan and Koreas, nfd", "Mainland South-East Asia nfd", "Melanesia, nfd", "Micronesia, nfd", "Middle East, nfd", "Maritime South-East Asia, nfd", "North Africa and Middle Easte, nfd", "North Africa, nfd", "North-East Asia nfd", "Northern America, nfd", "Northern Europe, nfd", "North-West Europe, nfd", "Polynesia, nfd", "South Eastern Europe, nfd", "South America, nec", "South America, nfd", "Southern and Central Asia, nfd", "Southern and East Africa, nfd", "Southern and East Europe, nfd", "South-East Asia, nfd", "Southern and East Africa, nec", "Southern Asia, nfd", "Southern Europe, nfd", "Spanish North Africa", "Sub-Saharan Africa, nfd", "Western Europe, nfd")


#####
#
nomNames <- c("COB", 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015)
#erpNames <- c("Sex", "Descriptor", "Age", 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016)

names(nomRawNSW) <- nomNames
names(nomRawACT) <- nomNames
names(nomRawNT) <- nomNames
names(nomRawQLD) <- nomNames
names(nomRawSA) <- nomNames
names(nomRawTAS) <- nomNames
names(nomRawVIC) <- nomNames
names(nomRawWA) <- nomNames
names(nomRawAUS) <- nomNames
#names(erpRawNSW) <- erpNames
#names(erpRawACT) <- erpNames
#names(erpRawNT) <- erpNames
#names(erpRawQLD) <- erpNames
#names(erpRawSA) <- erpNames
#names(erpRawTAS) <- erpNames
#names(erpRawVIC) <- erpNames
#names(erpRawWA) <- erpNames
#names(erpRawAUS) <- erpNames

nomRawNSW$state <- "NSW"
nomRawACT$state <- "ACT"
nomRawNT$state <- "NT"
nomRawQLD$state <- "QLD"
nomRawSA$state <- "SA"
nomRawTAS$state <- "TAS"
nomRawVIC$state <- "VIC"
nomRawWA$state <- "WA"
nomRawAUS$state <- "AUS"
  
target <- nomRawAUS
#erpTarget <- erpRawAUS

##Get all cobs
cobList <- window(target$COB, deltat=61)
cobList <- cobList[1:287]

#write.csv(cobList, "C:/Users/nbretana/Desktop/NOM Data/Results/countrCode.xls", row.names = FALSE)
cobCodes <- read_excel("C:/Users/nbretana/Desktop/NOM Data/Results/countryCode.xls")

nomRawAll <- rbind(nomRawNSW, nomRawACT)
nomRawAll <- rbind(nomRawAll, nomRawNT)
nomRawAll <- rbind(nomRawAll, nomRawQLD)
nomRawAll <- rbind(nomRawAll, nomRawSA)
nomRawAll <- rbind(nomRawAll, nomRawTAS)
nomRawAll <- rbind(nomRawAll, nomRawVIC)
nomRawAll <- rbind(nomRawAll, nomRawWA)
nomRawAll <- rbind(nomRawAll, nomRawAUS)

write.csv(nomRawAll, "C:/Users/nbretana/Desktop/NOM Data/Results/countrCode.xls", row.names = FALSE)

nomAll <- data.frame(year=integer(),age=character(), state=character(), country=character(), gender=character(), nom=integer(), stringsAsFactors = FALSE)
index<-1
nIndex<-1
colN <- c("year", "age", "state", "cob_code", "gender", "nom")

tData <- nomRawAll
while(index <= nrow(tData)){
    tCob <- tData[index,1]
    tState <- tData[index, 14] #state
    for(gIndex in 1:3){ #gender M F Total
      index <- index + 1
      tSex <- tData[index,1]
      
      index <- index+1
      tM <- tData[index:(index+18),1:13]
      tT <- NULL
      for(iTemp in 1:12){
        tX <-cbind(colnames(tM)[1+iTemp], tM$COB, tState, tCob, tSex, tM[,1+iTemp])
        colnames(tX) <- colN
        tT <- rbind(tT, tX)
      }
      nomAll <- rbind(nomAll, tT)
      index <- index + 18
      
      #for(aIndex in 1:19){ #age groups
        #index <- index +1
        #tAge <- nomRawAll[index,1]
        #tState <- nomRawAll[index, 14] #state
        #for(iYears in 2:13){ #years 04-15
        #  tNom <- nomRawAll[index, iYears] #nom
        # tYear <- colnames(nomRawAll[index, iYears]) #year
        # nomAll[nIndex,] <- c(tYear, tAge, tState, tCob, tSex, tNom)
        #  nIndex <- nIndex + 1
       # }
      #}
    }
    index <- index + 1
}

nomAll$cob <- cobCodes$Name[match(nomAll$cob_code, cobCodes$FullCode)]

nomAll$age <- as.character(nomAll$age)
nomAll$gender <- as.character(nomAll$gender)
nomAll$year <- as.character(nomAll$year)
nomAll$state <- as.character(nomAll$state)
nomAll$cob <- as.character(nomAll$cob)
nomAll$age <- gsub(" ", "", nomAll$age, fixed=TRUE)
nomAll$gender <- gsub(" ", "", nomAll$gender, fixed=TRUE)
#nomAll$erp <- NA

#incorporate 75+
RCerp75 <- subset(RCerpAll, RCerpAll$age=="75andover")
RCerp7579 <- RCerp75
RCerp7579$age <- "75-79"
RCerp8084 <- RCerp75
RCerp8084$age <- "80-84"
RCerp85 <- RCerp75
RCerp85$age <- "85+"

RCerpAll75 <- rbind(RCerpAll, RCerp7579)
RCerpAll75 <- rbind(RCerpAll75, RCerp8084)
RCerpAll75 <- rbind(RCerpAll75, RCerp85)

#nomAllSummary <- merge(nomAll, RCerpAll, by=c("year", "age", "state", "gender", "cob"), all.x=TRUE)
nomAllSummary <- merge(nomAll, RCerpAll75, by=c("year", "age", "state", "gender", "cob"), all.x=TRUE)
nomAllSummary$erp[is.na(nomAllSummary$erp)] <- 0

#match ERP from ERP files
#nomAll$erp <- RCerpAll$Value
#cobCodes$Name[match(nomAll$cob_code, cobCodes$FullCode)]
#grepl(RCerpAll$Country.of.birth[1], nomAll$cob)
#RCerpAll$age[RCerpAll$age=="75andabove"] <- "75-79"
#RCerpAll$age[RCerpAll$age=="75-79"] <- "80-84"
#RCerpAll$age[RCerpAll$age=="80-84"] <- "85+"
#RCerp75 <- subset(RCerpAll, RCerpAll$age=="75andover")
#RCerp75$age <- "75-79"
#nomAllSummary <- merge(nomAllSummarynomAl, RCerp75, by=c("year", "age", "state", "gender", "cob"), all.x=TRUE)
#RCerp75$age <- "80-84"
#nomAllSummary <- merge(nomAllSummary, RCerp75, by=c("year", "age", "state", "gender", "cob"), all.x=TRUE)
#RCerp75$age <- "85+"
#nomAllSummary <- merge(nomAllSummary, RCerp75, by=c("year", "age", "state", "gender", "cob"), all.x=TRUE)
#tmp2 <- merge(tmp, tmpERP, by=c("year", "age", "state", "gender", "cob"), all.x=TRUE)
#nomAll <- nomAll[-8]

write.csv(nomAllSummary, file.path(cleanDataFolder, "nomSummary2015.csv"), row.names = FALSE)
write.csv(nomAllSummary, file.path(cascadeDataFolder, "nomSummary2015.csv"), row.names = FALSE)

##End of code###


##Get Australia and NZ
for (i in 1:nrow(target)) {
  if(target$COB[i]=="1101 Australia"){
    nomAUS <- target[i:(i+60),] 
    nomTotalANZ <- target[i:(i+60),] 
  }else if(target$COB[i]=="1201 New Zealand"){
    nomNZ <- target[i:(i+60),] 
    nomTotalANZ[,2] <- nomAUS[,2] + nomNZ[,2]
    nomTotalANZ[,3] <- nomAUS[,3] + nomNZ[,3]
    nomTotalANZ[,4] <- nomAUS[,4] + nomNZ[,4]
    nomTotalANZ[,5] <- nomAUS[,5] + nomNZ[,5]
    nomTotalANZ[,6] <- nomAUS[,6] + nomNZ[,6]
    nomTotalANZ[,7] <- nomAUS[,7] + nomNZ[,7]
    nomTotalANZ[,8] <- nomAUS[,8] + nomNZ[,8]
    nomTotalANZ[,9] <- nomAUS[,9] + nomNZ[,9]
    nomTotalANZ[,10] <- nomAUS[,10] + nomNZ[,10]
    nomTotalANZ[,11] <- nomAUS[,11] + nomNZ[,11]
    nomTotalANZ[,12] <- nomAUS[,12] + nomNZ[,12]
    nomTotalANZ[,13] <- nomAUS[,13] + nomNZ[,13]
  }
}
##Combine AU and NZ
nomTotalANZ[1,1] <- "Australia New Zealand"

nomTotalCOB <- nomTotalANZ
nomTotalCOB[1,1] <- "Other cob"
nomTotalCOB[,2] <- nomTotalCOB[,2]-nomTotalCOB[,2]
nomTotalCOB[,3] <- nomTotalCOB[,3]-nomTotalCOB[,3]
nomTotalCOB[,4] <- nomTotalCOB[,4]-nomTotalCOB[,4]
nomTotalCOB[,5] <- nomTotalCOB[,5]-nomTotalCOB[,5]
nomTotalCOB[,6] <- nomTotalCOB[,6]-nomTotalCOB[,6]
nomTotalCOB[,7] <- nomTotalCOB[,7]-nomTotalCOB[,7]
nomTotalCOB[,8] <- nomTotalCOB[,8]-nomTotalCOB[,8]
nomTotalCOB[,9] <- nomTotalCOB[,9]-nomTotalCOB[,9]
nomTotalCOB[,10] <- nomTotalCOB[,10]-nomTotalCOB[,10]
nomTotalCOB[,11] <- nomTotalCOB[,11]-nomTotalCOB[,11]
nomTotalCOB[,12] <- nomTotalCOB[,12]-nomTotalCOB[,12]
nomTotalCOB[,13] <- nomTotalCOB[,13]-nomTotalCOB[,13]

excludeList <- c("1000 Oceania nfd", "1100 Aust (incl E T) nfd", "1101 Australia", "1199 Aust E T, nec", "1201 New Zealand", "1300 Melanesia nfd", "1400 Micronesia nfd", "1404 Micronesia, F S", "1500 Polynesia nfd", "1599 Polynesia, nec", "1600 Antarctica nfd", "1602 Argentinian A T", "1603 Australian A T", "1604 British A T", "1605 Chilean A T", "2000 NW Europe nfd", "21 UK, CIs & IOM(d)", "2300 Western Europe nfd", "2400 Northern Europe nfd", "3000 S & E Europe nfd", "3100 Southern Europe nfd", "3200 SE Europe nfd", "3300 Eastern Europe nfd", "4000 N Afr & Middl E nfd", "4100 North Africa nfd", "4108 Sp North Africa", "4200 Middle East nfd", "5000 South-East Asia nfd", "5100 Mainld SE Asia nfd", "5200 M'time SE Asia nfd", "6000 North-East Asia nfd", "6100 Chinese Asia nfd", "6200 Japan & Koreas nfd", "7000 S & C Asia nfd", "7100 Southern Asia nfd", "7200 Central Asia nfd", "8000 Americas nfd", "8100 N'thern America nfd", "8200 South America nfd", "8299 S America, nec", "8300 Central America nfd", "8400 Caribbean nfd", "9000 Sub-Saha Africa nfd", "9100 Cent & W Africa nfd", "9105 Cent Africa Rep", "9200 S & E Africa nfd", "9225 South Africa", "9299 S & E Afr, nec", "0000 Inadequately Described", "0001 At Sea", "0003 Not Stated", "0004 Unknown", "Total All Countries", "Males", "0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85+", "Total", "Females", "Persons")

tmp <- NULL
##Get other cobs
for (i in 1:nrow(target)) {
  if(!(trimws(target$COB[i])%in%excludeList)){
    tmp[i] <- target$COB[i]
    nomTotalCOB[,2] <- nomTotalCOB[,2]+target[i:(i+60),2]
    nomTotalCOB[,3] <- nomTotalCOB[,3]+target[i:(i+60),3]
    nomTotalCOB[,4] <- nomTotalCOB[,4]+target[i:(i+60),4]
    nomTotalCOB[,5] <- nomTotalCOB[,5]+target[i:(i+60),5]
    nomTotalCOB[,6] <- nomTotalCOB[,6]+target[i:(i+60),6]
    nomTotalCOB[,7] <- nomTotalCOB[,7]+target[i:(i+60),7]
    nomTotalCOB[,8] <- nomTotalCOB[,8]+target[i:(i+60),8]
    nomTotalCOB[,9] <- nomTotalCOB[,9]+target[i:(i+60),9]
    nomTotalCOB[,10] <- nomTotalCOB[,10]+target[i:(i+60),10]
    nomTotalCOB[,11] <- nomTotalCOB[,11]+target[i:(i+60),11]
    nomTotalCOB[,12] <- nomTotalCOB[,12]+target[i:(i+60),12]
    nomTotalCOB[,13] <- nomTotalCOB[,13]+target[i:(i+60),13]
  } 
}
nTmp <- tmp[!is.na(tmp)]

#Get nom overall
nomTotalAll <- nomTotalCOB
nomTotalAll[1,1] <- "All cob"
nomTotalAll[,2] <- nomTotalAll[,2]+nomTotalANZ[,2]
nomTotalAll[,3] <- nomTotalAll[,3]+nomTotalANZ[,3]
nomTotalAll[,4] <- nomTotalAll[,4]+nomTotalANZ[,4]
nomTotalAll[,5] <- nomTotalAll[,5]+nomTotalANZ[,5]
nomTotalAll[,6] <- nomTotalAll[,6]+nomTotalANZ[,6]
nomTotalAll[,7] <- nomTotalAll[,7]+nomTotalANZ[,7]
nomTotalAll[,8] <- nomTotalAll[,8]+nomTotalANZ[,8]
nomTotalAll[,9] <- nomTotalAll[,9]+nomTotalANZ[,9]
nomTotalAll[,10] <- nomTotalAll[,10]+nomTotalANZ[,10]
nomTotalAll[,11] <- nomTotalAll[,11]+nomTotalANZ[,11]
nomTotalAll[,12] <- nomTotalAll[,12]+nomTotalANZ[,12]
nomTotalAll[,13] <- nomTotalAll[,13]+nomTotalANZ[,13]

#excludeList <- c("1000 Oceania nfd", "1100 Aust (incl E T) nfd", "1199 Aust E T, nec", "1300 Melanesia nfd", "1400 Micronesia nfd", "1404 Micronesia, F S", "1500 Polynesia nfd", "1599 Polynesia, nec", "1600 Antarctica nfd", "1602 Argentinian A T", "1603 Australian A T", "1604 British A T", "1605 Chilean A T", "2000 NW Europe nfd", "21 UK, CIs & IOM(d)", "2300 Western Europe nfd", "2400 Northern Europe nfd", "3000 S & E Europe nfd", "3100 Southern Europe nfd", "3200 SE Europe nfd", "3300 Eastern Europe nfd", "4000 N Afr & Middl E nfd", "4100 North Africa nfd", "4108 Sp North Africa", "4200 Middle East nfd", "5000 South-East Asia nfd", "5100 Mainld SE Asia nfd", "5200 M'time SE Asia nfd", "6000 North-East Asia nfd", "6100 Chinese Asia nfd", "6200 Japan & Koreas nfd", "7000 S & C Asia nfd", "7100 Southern Asia nfd", "7200 Central Asia nfd", "8000 Americas nfd", "8100 N'thern America nfd", "8200 South America nfd", "8299 S America, nec", "8300 Central America nfd", "8400 Caribbean nfd", "9000 Sub-Saha Africa nfd", "9100 Cent & W Africa nfd", "9105 Cent Africa Rep", "9200 S & E Africa nfd", "9225 South Africa", "9299 S & E Afr, nec", "0000 Inadequately Described", "0001 At Sea", "0003 Not Stated", "0004 Unknown", "Total All Countries", "Males", "0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85+", "Total", "Females", "Persons")

#for (i in 1:nrow(target)) {
#  if(!(trimws(target$COB[i])%in%excludeList)){
#    tmp[i] <- target$COB[i]
#    nomTotalAll[,2] <- nomTotalAll[,2]+target[i:(i+60),2]
#    nomTotalAll[,3] <- nomTotalAll[,3]+target[i:(i+60),3]
#    nomTotalAll[,4] <- nomTotalAll[,4]+target[i:(i+60),4]
#    nomTotalAll[,5] <- nomTotalAll[,5]+target[i:(i+60),5]
#    nomTotalAll[,6] <- nomTotalAll[,6]+target[i:(i+60),6]
#    nomTotalAll[,7] <- nomTotalAll[,7]+target[i:(i+60),7]
#    nomTotalAll[,8] <- nomTotalAll[,8]+target[i:(i+60),8]
#    nomTotalAll[,9] <- nomTotalAll[,9]+target[i:(i+60),9]
#    nomTotalAll[,10] <- nomTotalAll[,10]+target[i:(i+60),10]
#    nomTotalAll[,11] <- nomTotalAll[,11]+target[i:(i+60),11]
#    nomTotalAll[,12] <- nomTotalAll[,12]+target[i:(i+60),12]
#    nomTotalAll[,13] <- nomTotalAll[,13]+target[i:(i+60),13]
#  } 
#}

##ERP
##Get ERP for NSW from 2004 to 2014, Males, Females, and Persons in the same format as nomTotal 

##Combine ANZ erp
#erpAUS <- NULL
#erpNZ <- NULL
#erpList <- NULL
#for(i in 1:nrow(erpRaw)){
#  if(!is.na(trimws(erpRaw$COB[i]))){
#    erpList[i] <- trimws(erpRaw$COB[i])
#    if(trimws(erpRaw$COB[i])=="Australia"){ 
#      erpAUS <- erpRaw[i:(i+458),]
#    }
#    if(trimws(erpRaw$COB[i])=="New Zealand"){
#      #erpANZ <- erpANZ[,5:27]+erpRaw[i:(i+458),5:27]
#      erpNZ <- erpRaw[i:(i+458),]
#    }
#  }
#}
#erpList <- erpList[!is.na(erpList)]
#erpANZ <- erpAUS
#erpANZ[,5:27] <- erpAUS[,5:27]+erpNZ[,5:27]

##Combine COB erp
#erpCOB <- erpANZ
#erpCOB[,5:27] <- erpCOB[,5:27]-erpCOB[,5:27]

#erpExcludeList <- c("Australian External Territories, nec", "Polynesia (Excludes Hawaii), nec", "")

migrationANZ <- nomTotalANZ
migrationANZ[1,1] <- "Australia New Zealand"
migrationANZ[,2] <- migrationANZ[,2]-migrationANZ[,2]
migrationANZ[,3] <- migrationANZ[,3]-migrationANZ[,3]
migrationANZ[,4] <- migrationANZ[,4]-migrationANZ[,4]
migrationANZ[,5] <- migrationANZ[,5]-migrationANZ[,5]
migrationANZ[,6] <- migrationANZ[,6]-migrationANZ[,6]
migrationANZ[,7] <- migrationANZ[,7]-migrationANZ[,7]
migrationANZ[,8] <- migrationANZ[,8]-migrationANZ[,8]
migrationANZ[,9] <- migrationANZ[,9]-migrationANZ[,9]
migrationANZ[,10] <- migrationANZ[,10]-migrationANZ[,10]
migrationANZ[,11] <- migrationANZ[,11]-migrationANZ[,11]
migrationANZ[,12] <- migrationANZ[,12]-migrationANZ[,12]
migrationANZ[,13] <- migrationANZ[,13]-migrationANZ[,13]

##Calculate nomTotalAUS/ERP
#males
migrationANZ[3:20,2:13] <- nomTotalANZ[3:20,2:13]/erpTarget[19:36,7:18]
#females
migrationANZ[23:40,2:13] <- nomTotalANZ[23:40,2:13]/erpTarget[37:54,7:18]
#total
migrationANZ[43:60,2:13] <- nomTotalANZ[43:60,2:13]/erpTarget[1:18,7:18]

migrationCOB <- nomTotalCOB
migrationCOB[1,1] <- "Other COB"
migrationCOB[,2] <- migrationCOB[,2]-migrationCOB[,2]
migrationCOB[,3] <- migrationCOB[,3]-migrationCOB[,3]
migrationCOB[,4] <- migrationCOB[,4]-migrationCOB[,4]
migrationCOB[,5] <- migrationCOB[,5]-migrationCOB[,5]
migrationCOB[,6] <- migrationCOB[,6]-migrationCOB[,6]
migrationCOB[,7] <- migrationCOB[,7]-migrationCOB[,7]
migrationCOB[,8] <- migrationCOB[,8]-migrationCOB[,8]
migrationCOB[,9] <- migrationCOB[,9]-migrationCOB[,9]
migrationCOB[,10] <- migrationCOB[,10]-migrationCOB[,10]
migrationCOB[,11] <- migrationCOB[,11]-migrationCOB[,11]
migrationCOB[,12] <- migrationCOB[,12]-migrationCOB[,12]
migrationCOB[,13] <- migrationCOB[,13]-migrationCOB[,13]

##Calculate nomTotalANZ/ERP
#male
migrationCOB[3:20,2:13] <- nomTotalCOB[3:20,2:13]/erpTarget[19:36,7:18]
#females
migrationCOB[23:40,2:13] <- nomTotalCOB[23:40,2:13]/erpTarget[37:54,7:18]
#total
migrationCOB[43:60,2:13] <- nomTotalCOB[43:60,2:13]/erpTarget[1:18,7:18]

migrationALL <- nomTotalAll
migrationALL[1,1] <- "All cob"
migrationALL[,2] <- migrationALL[,2]-migrationALL[,2]
migrationALL[,3] <- migrationALL[,3]-migrationALL[,3]
migrationALL[,4] <- migrationALL[,4]-migrationALL[,4]
migrationALL[,5] <- migrationALL[,5]-migrationALL[,5]
migrationALL[,6] <- migrationALL[,6]-migrationALL[,6]
migrationALL[,7] <- migrationALL[,7]-migrationALL[,7]
migrationALL[,8] <- migrationALL[,8]-migrationALL[,8]
migrationALL[,9] <- migrationALL[,9]-migrationALL[,9]
migrationALL[,10] <- migrationALL[,10]-migrationALL[,10]
migrationALL[,11] <- migrationALL[,11]-migrationALL[,11]
migrationALL[,12] <- migrationALL[,12]-migrationALL[,12]
migrationALL[,13] <- migrationALL[,13]-migrationALL[,13]

##Calculate nomTotalANZ/ERP
#male
migrationALL[3:20,2:13] <- nomTotalAll[3:20,2:13]/erpTarget[19:36,7:18]
#females
migrationALL[23:40,2:13] <- nomTotalAll[23:40,2:13]/erpTarget[37:54,7:18]
#total
migrationALL[43:60,2:13] <- nomTotalAll[43:60,2:13]/erpTarget[1:18,7:18]

write.csv(migrationANZ, file.path(cleanDataFolder, "migrationANZ_WA.xls"), row.names = FALSE)
write.csv(migrationCOB, file.path(cleanDataFolder, "migrationCOB_WA.xls"), row.names = FALSE)
write.csv(migrationALL, file.path(cleanDataFolder, "migrationALL_AUS.xls"), row.names = FALSE)
