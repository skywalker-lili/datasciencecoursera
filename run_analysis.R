##The path of file depends on individual setting. To enable the following code, please do as follows:
##1. Unzipp the zip data to following path: "E:/R/Coursera/getdata/" to have a folder like "UCI HAR Dataset"
##2. Rename the folder to "UCIHARDataset". Insider the folder, there should be two folders "test" and "train"
##Or users can have their own path of file but remeber to change the path accordingly in the setwd() command

setwd("E:/R/Coursera/getdata/UCIHARDataset/test")
##set the wordking directory to where I store unzipped TEST data, could change according to your path

X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
##read the three data files containing the dataset, labels for activities and labels of volunteers

testdata <- cbind(subject_test,y_test,X_test)
##column bind the three to create the "testdata" dataframe

setwd("E:/R/Coursera/getdata/UCIHARDataset/train")
##set the wordking directory to where I store unzipped TRAINING data

X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
##read the three txt files containing the data set, the labels for activities and the labels for volunteers

traindata <- cbind(subject_train,y_train,X_train)
##column bind the three to create the "traindata" dataframe

data <- rbind(testdata, traindata)
##row bind the test data and the training data to create one dataframe that covers all data

data <- data[complete.cases(data),]
##clean the data to leave only Non NA data

ncolumns <- ncol(data)
for(i in 1:ncolumns) {
  as.numeric(data[,i])
} 
##coerce all columns into numerci vector, easy for future operation

colnames(data)[1] <- c("VolunteerLabel")
colnames(data)[2] <- c("ActivityLabel")
##Rename the first two columns to descriptive column names

othercolnames <- read.table("E:/R/Coursera/getdata/UCIHARDataset/features.txt")
##Read the feature.txt to get descriptive column names of rest of the columns. Here the path depends on where the features.txt is stored
othercolnames <- as.character(othercolnames[,2])
##shape the othercolnames into a character vector that can be used to rename columns in "data"
colnames(data)[3:563] <- othercolnames
##so far the columns of "data" all have descriptive names


means <- grepl("mean",names(data))
stds <- grepl("std",names(data))
meansorstds <- means|stds
##according to the feature_info.txt and project instruction, I need to pick up the columns that contains the text "mean" or "std"
##the above code can create a logical vector with the same sequence as the column names of the object "data", indicating the right columns I need
dataneeded <- data[,meansorstds]
##this line takes out the columns containing means and standard variations
dataneeded <- cbind(data[,1:2],dataneeded)
##this line creates the data frame "dataneeded¡°, which contains the volunteer labels, the activity labels and the columns of means and stds

activities <- read.table("E:/R/Coursera/getdata/UCIHARDataset/activity_labels.txt")
activities[,1] <- as.numeric(activities[,1])
activities[,2] <- as.character(activities[,2])
##read desciptive names for activities labels

dataneeded[,2] <- as.numeric(dataneeded[,2])
for(i in 1:6){
dataneeded[which(dataneeded[,2] == i),2] <- activities[i,2]
}
##So far, the activity labels have become descriptive activity names

install.packages("reshape2")
library(reshape2)
##Enable "reshape2" package because I need to use melt() and dcase() functions

x <- melt(dataneeded,id.vars=c("VolunteerLabel","ActivityLabel"))
tidydata <- dcast(x, VolunteerLabel + ActivityLabel ~ variable,mean)
##"tidydata" is what is asked by the project:
##Tidy data set with the average of each variable for each activity and each subject

write.table(tidydata,file="Tidydata.txt")
##Output the file to current working directory