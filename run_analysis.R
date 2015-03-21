run_analysis <- function(){

#########################################################################
# 	****************  Remark 1 *****************
# 	Base on information from feature.txt, key words "mean" & "std" 
#	are extract and filtered. The description will be used to polluate the 
#	column and position will use to determin which column to extract
#########################################################################
# --- convert the boolean to 16 or -16. This will use pass as width ----
# --- arg im read.fwf --------------------------------------------------
library(plyr)
xwidth.f <- revalue(factor(feature.df$extract), c("TRUE"=16,"FALSE"=-16))
xwidth <- as.numeric(levels(xwidth.f)[as.numeric(xwidth.f)])

#########################################################################
# 	****************  Remark 2 *****************
# 	Read in the train & test dataset merge them together
#########################################################################

#--------- Read in x dataset ----------------------------------------- 
x.train <- read.fwf("./RAW/train/X_train.txt", width=xwidth, header=F)
x.test<- read.fwf("./RAW/test/X_test.txt", width=xwidth, header=F)
x.all <- rbind(x.train, x.test)

#--------- Read in y dataset ----------------------------------------- 
y.train <- read.csv("./RAW/train/y_train.txt", stringsAsFactors=F, header=F)  
y.test  <- read.csv("./RAW/test/y_test.txt", stringsAsFactors=FALSE, header=F)
y.all <- rbind(y.train, y.test)

#--------- Read in subject dataset ----------------------------------------- 
subject.train  <- read.csv("./RAW/train/subject_train.txt", stringsAsFactors=F, header=F)
subject.test  <- read.csv("./RAW/test/subject_test.txt", stringsAsFactors=F, header=F)
subject.all <- rbind(subject.train, subject.test)

#########################################################################
# 	****************  Remark 3 *****************
# 	create descriptive column and value
#########################################################################
# ---- assign descriptive column name to respective DF -----------------
colnames(x.all) <- gsub("\\()","",feature.extract.df$V2)  

colnames (subject.all) <- "Subject"

#########################################################################
# 	****************  Remark 4 *****************
# 	Labels the dataset with activity name
#########################################################################
activities.map <- c("1"="WALKING","2"="WALKING_UPSTAIR","3"="WALKING_DOWNSTAIRS","4"="SITTING","5"="STANDING","6"= "LAYING")
y.f <- revalue(factor(y.all$V1),activities.map)
y.all <- data.frame(y.f)
colnames(y.all)<-"activity"
    

# ---- merge all three DF into one big DF -------------------------------
consolidate.df <- data.frame(subject.all,y.all,x.all)	

#########################################################################
# 	****************  Remark 5 *****************
# 	mean are computed for each column group accordingly
#       to subject and activity
#########################################################################
variable.l <- list(Groupsubject=consolidate.df$Subject, GroupActivity=consolidate.df$activity)
consolidate.mean.df <- aggregate(consolidate.df, by=variable.l,FUN=mean, na.rm=TRUE)

# ---- remove both columns subject & activity -------------------------------
consolidate.mean.df$Subject <- NULL
consolidate.mean.df$activity <- NULL

write.table(consolidate.mean.df, file = "MyData.txt",row.names=FALSE)
}
