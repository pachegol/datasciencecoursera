Wearable Computing Code Book
========================================================

The data
-------------------------
It is from an experiment to determine human activity using smartphone data. 
This info comes directly from the help file:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data." 

"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details."
 

The variables
-------------------------

For each record it is provided:

  1.Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
  
  2.Triaxial Angular velocity from the gyroscope.
  
  3.A 561-feature vector with time and frequency domain variables.
  
  4.Its activity label.
  
  5.An identifier of the subject who carried out the experiment.

The transformations
-------------------------


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