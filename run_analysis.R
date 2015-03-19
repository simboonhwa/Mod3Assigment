run_analysis <- function(){

# ------------------prepare the features column-----------------------
feature.df <- read.csv("./RAW/features.txt", stringsAsFactors=F,sep=" ",header=F)
pattern <- "mean|std"
feature.extract.df <- feature.df[grep(pattern,feature.df$V2),]
# ---- extract the row number with mean & std ------------------
extract.l <- feature.extract.df$V1
# ---- extract description with mean & std --------------------
feature.df$extract <- feature.df$V1 %in% extract.l
library(plyr)
# ---- convert the boolean to 16 or -16 ------------------------
xwidth.f <- revalue(factor(feature.df$extract), c("TRUE"=16,"FALSE"=-16))
xwidth <- as.numeric(levels(xwidth.f)[as.numeric(xwidth.f)])
#x.train <- read.fwf("./RAW/train/X_train.txt", width=xwidth, header=F)
x.train <- read.fwf("./RAW/train/X_train.txt", width=xwidth, header=F, skip=7000)
x.test<- read.fwf("./RAW/test/X_test.txt", width=xwidth, header=F, skip=2000)
#x.test<- read.fwf("./RAW/test/X_test.txt", width=xwidth, header=F)
x.all <- rbind(x.train, x.test)
# ---- assign the column name ------------------------
colnames(x.all) <- gsub("\\()","",feature.extract.df$V2)  
#y.train <- read.csv("./RAW/train/y_train.txt", stringsAsFactors=F, header=F)  
y.train <- read.csv("./RAW/train/y_train.txt", stringsAsFactors=F, header=F, skip=7000)  
y.test  <- read.csv("./RAW/test/y_test.txt", stringsAsFactors=FALSE, header=F, skip=2000)
#y.test  <- read.csv("./RAW/test/y_test.txt", stringsAsFactors=FALSE, header=F)
y.all <- rbind(y.train, y.test)

activities.map <- c("1"="WALKING","2"="WALKING_UPSTAIR","3"="WALKING_DOWNSTAIRS","4"="SITTING","5"="STANDING","6"= "LAYING")
y.f <- revalue(factor(y.all$V1),activities.map)
y.all <- data.frame(y.f)
colnames(y.all)<-"activity"
    
#subject.train  <- read.csv("./RAW/train/subject_train.txt", stringsAsFactors=F, header=F)
subject.train  <- read.csv("./RAW/train/subject_train.txt", stringsAsFactors=F, header=F, skip=7000)
subject.test  <- read.csv("./RAW/test/subject_test.txt", stringsAsFactors=F, header=F, skip=2000)
#subject.test  <- read.csv("./RAW/test/subject_test.txt", stringsAsFactors=F, header=F)
subject.all <- rbind(subject.train, subject.test)
colnames (subject.all) <- "Subject"
consolidate.df <- data.frame(subject.all,y.all,x.all)	

variable.l <- list(Groupsubject=consolidate.df$Subject, GroupActivity=consolidate.df$activity)
consolidate.mean.df <- aggregate(consolidate.df, by=variable.l,FUN=mean, na.rm=TRUE)

consolidate.mean.df$Subject <- NULL
consolidate.mean.df$activity <- NULL

#write.table(consolidate.mean.df, file = "MyData.txt",row.names=FALSE)
}
