#Assignment Steps

# ----------------------------------------------------------------------------
# get the data from remote site
# ----------------------------------------------------------------------------

# From assignment location
dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download and save the file to local directory
download.file(dataurl,"course_3_assignment.zip" , method = "curl")

#unzip the downloaded file and save the extracted files in
#our working directory
unzip("./course_3_assignment.zip", overwrite = TRUE)


# ----------------------------------------------------------------------------
# set library usage
# ----------------------------------------------------------------------------
# use the dplyr and data.table library
library(dplyr)		
library(data.table)	

# ----------------------------------------------------------------------------
# read the data
# ----------------------------------------------------------------------------

# change the wd to where files are stored
setwd(paste0(getwd(),"/","UCI HAR Dataset"))

# read the column names
features_cols <- read.table("features.txt", header = FALSE)
activity_cols <- c("activity")
subject_cols  <- c("subject")

# read the labels for the activities
activity_labels <-read.table("activity_labels.txt", header = FALSE)


#load the training data
subject_train <- read.table("./train/subject_train.txt", header = FALSE, col.names = subject_cols)
x_train <- read.table("./train/X_train.txt", header = FALSE, col.names = features_cols$V2)
y_train <- read.table("./train/y_train.txt", header = FALSE, col.names = activity_cols)

#load the test data
subject_test <- read.table("./test/subject_test.txt", header = FALSE, col.names = subject_cols)
x_test <- read.table("./test/X_test.txt", header = FALSE, col.names = features_cols$V2)
y_test <- read.table("./test/y_test.txt", header = FALSE, col.names = activity_cols)

# ----------------------------------------------------------------------------
# prep the data
# ----------------------------------------------------------------------------

#add the subject and adctivity column to the x_test dataframe
x_train <- mutate(x_train, subject = subject_train$subject)
x_train <- mutate(x_train, activity = y_train$activity)

#add the subject and adctivity column to the x_test dataframe
x_test <- mutate(x_test, subject = subject_test$subject)
x_test <- mutate(x_test, activity = y_test$activity)



# ----------------------------------------------------------------------------
# Question 1: Merges the training and the test sets to create one data set
# ----------------------------------------------------------------------------
# add a column that has valid column header names that were transposed by
# the read.table function
features_cols <- mutate(features_cols, V3 = make.names(features_cols$V2))

x_all <- rbind(x_train, x_test)
names(x_all) <- c(features_cols$V3, "activity","subject")
# now have 10299 observations in the dataset


# ----------------------------------------------------------------------------
# Question 2: Extracts only the measurements on the 
#			  mean and standard deviation for each measurement.
# ----------------------------------------------------------------------------
# I understood the qustion as asking to show only the columns that 
# contain mean or standard deviation values
# I choose the columns with mean() or std() in their column names
# I validated by using the grep command
# grep("mean", features_cols$V2, value=TRUE)
# grep("std", features_cols$V2, value=TRUE)

# get a list of the column numbers
std_mean_cols <- grep("mean|std" , features_cols$V3, value = FALSE)

# select the columns with mean or std in their column names to new data.frame
# also include subject(562) activity(563) columns
x_mean_std <- select(x_all, c(std_mean_cols,562,563))


# ----------------------------------------------------------------------------
# Question 3: Uses descriptive activity names to name the activities 
#			  in the data set
# ----------------------------------------------------------------------------
# mutate the data frame and replace value in activity column
# with the activity label

x_mean_std <- x_mean_std %>% mutate(activity = as.character(factor(activity
								,levels=1:6
								,labels=activity_labels$V2
								)))



# ----------------------------------------------------------------------------
# Question 4: Appropriately labels the data set with descriptive variable 
#			  names.
# ----------------------------------------------------------------------------
# add a column to the feaatures_cols data frame that will hold the 
# new column names
features_cols <- mutate(features_cols, NewColumnNames=V2)

#create a list of patterns to search for and the replacement values
replace_list  <- c( "tBody"             ="time Body"
					,"fBody"            ="f Body"
					,"tGravity"         =" time Gravity"
					,"Acc"              =" Acceleration"
					,"-mean"            =" mean"
					,"-meanFreq"        =" mean Freq"
					,"-std"             =" Standard Deviation"
					,"-arCoeff"         =" Autoregression Coefficient"
					,"-mad"             =" Median Absolute Deviation"
					,"-sma"             =" Signal Magnitude Area"
					,"-iqr"             =" Interquartile range"
					,"BodyGyro"         =" Body Gyro"
					,"JerkMag"          =" Jerk Mag"
					,"\\("              =""
					,"\\)"              =""
					)	

library(stringr)
# str_replace_all is from the stringr library
features_cols$NewColumnNames <-features_cols$NewColumnNames %>% 
								str_replace_all(replace_list)

#enforce the rules so that the column names are valid
features_cols$NewColumnNames <- make.names(features_cols$NewColumnNames)

# put the list of descriptive column names into a list vector
# use grep to find the mean and Standard deviation columns
std_mean_cols <-c(grep("mean|Standard"
					   , features_cols$NewColumnNames
					   , value = TRUE)
					   ,"subject"
					   ,"activity"
					   )
# list of 81 column names

# apply the descriptive column names to the data frame
names(x_mean_std) <- c(std_mean_cols)


# ----------------------------------------------------------------------------
# Question 5: From the data set in step 4, creates a second, 
#			  independent tidy data set with the average of 
#			  each variable for each activity and each subject.
# ----------------------------------------------------------------------------
# to create the tidy data I grouped the data by Subjects and then by
# Activities and then use the summarize_all function to
# average the columns by group
# the result is one observation: mean for each subject‐activity
# pair (30 subjects * 6 activities = 180 observations in total)

# this method follows the tidy data WIDE format 
# referenced by Wickham, Hadley (2014) Tiday Data, 
# The Journal of Statistical Software, vol. 59, 2014.
# http://vita.had.co.nz/papers/tidy-data.pdf

tidy_data <- x_mean_std %>% 
			group_by(subject, activity) %>% 
			summarise_all(mean)

# ----------------------------------------------------------------------------
# output the Tidy Data 
# ----------------------------------------------------------------------------
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
