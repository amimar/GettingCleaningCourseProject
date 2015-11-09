library(data.table)

# 1
# reading and combine Test files of the 
# subjects, their activities and the data

Tst <- fread("UCI HAR Dataset/test/subject_test.txt")        
TXt <- fread("UCI HAR Dataset/test/X_test.txt")				 
Tyt <- fread("UCI HAR Dataset/test/y_test.txt")			    
TXts <- cbind(Activity=Tyt$V1,TXt)
TXtss <- cbind(Subject=Tst$V1,TXts)

# 2
# reading and combine Train files of the 
# subjects, their activities and the data

Rst <- fread("UCI HAR Dataset/train/subject_train.txt")					 
RXt <- fread("UCI HAR Dataset/train/X_train.txt")						 
Ryt <- fread("UCI HAR Dataset/train/y_train.txt")						 
RXts <- cbind(Activity=Ryt$V1,RXt)
RXtss <- cbind(Subject=Rst$V1,RXts)

# 3
# combine the TEST and TRAIN file to one data set

bindData <- rbind(TXtss,RXtss)

# 4
# reading the features file and annoted the labels
# of the data set with orginal names. 

Features <- fread("UCI HAR Dataset/features.txt")                  
colnames(bindData)[c(3:563)] <- Features$V2

# 5
# replacing the activities names instead of numeric ids

bindData$Activity <- as.character(bindData$Activity)
bindData$Activity[bindData$Activity == "1"] <- "WALKING"
bindData$Activity[bindData$Activity == "2"] <- "WALKING_UPSTAIRS"
bindData$Activity[bindData$Activity == "3"] <- "WALKING_DOWNSTAIRS"
bindData$Activity[bindData$Activity == "4"] <- "SITTING"
bindData$Activity[bindData$Activity == "5"] <- "STANDING"
bindData$Activity[bindData$Activity == "6"] <- "LAYING"

# 6
# extract the labels contain the "mean" or "std" pattern
# and their ids

dropcols <- Features[which(!(grepl("mean", Features$V2) | grepl("std", Features$V2))), ]

# 7
# changing the classes in order to be able 
# removing columns

bindData <- as.data.frame(bindData)
dropcols <- as.data.frame(dropcols)

for(i in 1:nrow(dropcols)) {
  bindData[dropcols$V2[i]] <- NULL
}

# end of steps 1-4 of the assignment
#-------------------------------------

# 8
# recreating the data set without activities names
# using their numeric code make the mission of finding
# the averages simpler. At the end step the ids will be 
# replaced by names

bindData2 <- rbind(TXtss,RXtss)
bindData2 <- as.data.frame(bindData2)
colnames(bindData2)[c(3:563)] <- Features$V2


newDF = bindData2[FALSE,]
newDF <- as.matrix(newDF)

for(i in 1:30) { # subjects
	for(j in 1:6) {  # activities
       s <- bindData2[(bindData2$Subject==i & bindData2$Activity == j),]
       sm <- colMeans(s)
       newDF <- rbind(newDF,sm)   
   }
}


for(i in 1:nrow(newDF)) {

	if (newDF[i,2] == 1) {newDF[i,2] = "WALKING"}
	if (newDF[i,2] == 2) {newDF[i,2] = "WALKING_UPSTAIRS"}
	if (newDF[i,2] == 3) {newDF[i,2] = "WALKING_DOWNSTAIRS"}
	if (newDF[i,2] == 4) {newDF[i,2] = "SITTING"}
	if (newDF[i,2] == 5) {newDF[i,2] = "STANDING"}
	if (newDF[i,2] == 6) {newDF[i,2] = "LAYING"}
	
}


library(gdata)

# 8
# this function aligned nicely the colunms names
# with the columns itself.
# found here:
# http://stackoverflow.com/questions/13590887/print-a-data-frame-with-columns-aligned-as-displayed-in-r

print.to.file <- function(df, filename) {
  cnames <- colnames(df)
  n      <- as.matrix(nchar(cnames))

  d <- apply(df, 2, format)
  n <- apply(cbind(n, nchar(d[1,])), 1, max)

  fmts <- paste0("%",n, "s")
  for(i in 1:length(cnames)) {
    cnames[i] <- sprintf(fmts[i], cnames[i])
    d[,i] <- sprintf(fmts[i], trim(d[,i]))
  }
  d <- rbind(cnames, d)
  write.table(d, filename, quote=F, row.names=F, col.names=F)
}

print.to.file(newDF,"TidyDataSet.txt")
 
#=== end =====



