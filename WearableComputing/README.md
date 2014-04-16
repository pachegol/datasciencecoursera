Wearable Computing Assignment
========================================================

The run_analysis.R script performs the following activities:

1.Adds all the necessary files to R using _read.table_ function

  * __features.txt__: List of all features.
  * __activity_labels.txt__: Links the class labels with their activity name.
  * __train/X_train.txt__: Training set.
  * __train/y_train.txt__: Training labels.
  * __test/X_test.txt__: Test set.
  * __test/y_test.txt__: Test labels.

2.Merge the training and test sets

3.Calculates means and standard deviations of each feature. it saves the results in a file called __meansAndStdev.txt__

4.Combines all the activity labels, subjects, and features in one data set called __Accelerometer.data__

5.With this dataset, I used the _aggregate_ function to calculate the means for each activity and subject. The script produces a file called __FeatureMeansBySubjectAndActivity.txt__ that it is the one uploaded in the assignment page and you can see it as well in the repo.