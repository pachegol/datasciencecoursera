
# You should create one R script called run_analysis.R that does the following: 
# Merges the training and the test sets to create one data set.
# 

# First, let's establish the location of the file with the information we need
# We need the name of the features to name the variables as well as for use in
# the merge command

# The data came in several folders and subfolders. I ran mine with the location of my data, but
# I added a second command to read the data from your working directory, assuming you put all the text files in the data working directory
# you could also add the file with the command file.choose()

features.data.location <- "~/data/features.txt"
features.data <- read.table(features.data.location)

# features.data <- read.table(file.choose())

# The activity labels would allow us to recode the activity label variable from a number
# to something more meanignful that 1, 2, 3, 4, etc.

activity.labels.data.location <- "~/data/activity_labels.txt"

activity.labels.data <- read.table(activity.labels.data.location)


# Now, let's apply the same process to bring the training and test set data to R
# I decided to bring all the data first before performing any of the required activities

train.X.data.location <- "~/data/train/X_train.txt"

train.X.data <- read.table(train.X.data.location)

train.X.subject.location <- "~/data/train/subject_train.txt"

train.X.subject <- read.table(train.X.subject.location)

names(train.X.subject) <- "subjectNumber"


# One thing worth mentioning is that the data is very well formatted and we do not
# need to change any of the defaults because the data does not have header and the columns 
# or features are separated by blank spaces. This process is more of a test and trial
# than anything else.

train.Y.data.location <- "~/data/train/Y_train.txt"

train.Y.data <- read.table(train.Y.data.location)

test.X.data.location <- "~/data/test/X_test.txt"

test.X.data <- read.table(test.X.data.location)

test.Y.data.location <- "~/data/test/Y_test.txt"

test.Y.data <- read.table(test.Y.data.location)

test.X.subject.location <- "~/data/test/subject_test.txt"

test.X.subject <- read.table(test.X.subject.location)

names(test.X.subject) <- "subjectNumber"



# Now we can merge both train and test X data

X.data <- rbind(train.X.data, test.X.data)

# We can also add the names now

names(X.data) <- features.data[,2]



# Extracts only the measurements on the mean and standard deviation for 
# each measurement.

# We can use apply to calculate means and standard deviation for each column


means.and.stdev <- data.frame(features=features.data[,2], 
                    mean = (sapply(X.data, mean)), 
                    stdev = (sapply(X.data, sd))
                    )

# you can see the results on GitHub as well

write.table(means.and.stdev, "meansAndStdev.txt")


# now, to create the second tidy dataset  we are going to need to add the activities to
# the X.data

# we can change the names of  activities before merging


names(train.Y.data) <- "activity"
names(test.Y.data) <- "activity"

# we can also refactor the activity from numbers to labels using merge

train.act.labels <- merge(train.Y.data, activity.labels.data, by.x = "activity", by.y = "V1")

train.Y.data$activityLabels <- train.act.labels[,2]

test.act.labels <- merge(test.Y.data, activity.labels.data, by.x = "activity", by.y = "V1")

test.Y.data$activityLabels <- test.act.labels[,2]

Y.data <- rbind(train.Y.data, test.Y.data)

subject.data <- rbind(train.X.subject, test.X.subject)

table(subject.data) # to see how many subjects we have. I know it's 30 from the description



# we can bind the columns that we need from X.data , Y.data, and subject.data

Accelerometer.data <- cbind(X.data, subjectNumber = subject.data$subjectNumber, activityLabels = Y.data$activityLabels)

# now we have a dataset (10,299 obs x 563 features) comprise of
# 7,352 train observations
# 2947 test observations
# 561 features from acceloremeter information (X,Y,Z velocities and accelerations)
# 1 feature or column identifying the subject that performed the activity. There were 30 subjects
# 1 feature telling us the kind of activity that the user of the smartphone was. There were 5 activities
# doing at the time

table(Accelerometer.data$subjectNumber, Accelerometer.data$activityLabels)

# to see which subjects performed which activity so that I can calculate the means correctly

# 
# Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 

 


newDataSet <- aggregate(Accelerometer.data[,1:561], by = list(subjectNumber = Accelerometer.data$subjectNumber, activityLabel = Accelerometer.data$activityLabels), mean)


# We can write this dataset to disc using the write.table commmand


write.table(newDataSet,file="FeatureMeansBySubjectAndActivity.txt")


