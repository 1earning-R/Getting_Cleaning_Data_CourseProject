# Code Book For Tidied Dataset

-----------------------------

## Data Collection and Explanation
### Filtering The Sensor Measurements

*The following is a summary of the processing performed by [Reyes-Ortiz et. al](http://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones). Follow link for more information.*

The measurements in the raw data were obtained using the methods outlined in the README file. The accelerometer (denoted **Acc** in the data) and gyroscope (denoted **Gyro** in the data) sensors each collected measurements along three spatial axes, labeled with standard notation **X**, **Y**, and **Z**. The accelerometer measured acceleration in units of g (9.8 meters/sec^2^), and the gyroscope measured angular velocity in units of radians/sec. These measurements were filtered by frequency to reduce noise in the data. 

The accelerometer measurements were further filtered to divide the measurement into acceleration due to **Gravity**, frequencies below 0.3 Hz, and acceleration due to the motion of the volunteer (denoted as **Body** in the data). The gyroscope measurements were assumed not to have a gravitational component.

### Calculating Physical Properties

*The following is a summary of the processing performed by [Reyes-Ortiz et. al](http://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones). Follow link for more information.*

A first order time derivative (**Jerk**^[Jerk is the fourth order time derivative of distance. This makes it the fourth item in the familiar set: distance,velocity, acceleration, jerk.]) was taken for each accelerometer and gyroscope measurement^[A more appropriate name for the time derivative of angular velocity would be angular acceleration. Probably to reduce ambiguity, the original dataset referred to the time order derivative for both acceleration and angular velocity as jerk. The tidy data set produced by run_analysis() maintains that convention.]. This measures how abruptly changes in motion occurred. **Jerk** was not calculated for the gravitational components.

The magnitudes (**Mag**) of the overall acceleration for both **Body** and **Gravity** and of the overall angular velocities were found using:

**Mag**^2^ = **X**^2^ + **Y**^2^ + **Z**^2^

The magnitudes were also calculated for each **Jerk** signal.

### Fast Fourier Transform (FFT)

*The following is a summary of the processing performed by [Reyes-Ortiz et. al](http://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones). Follow link for more information.*

An FFT was applied to each of the measured and calculated signals above, with the exception of the **Gravity** signals. The FFT converted time dependent signal (represented in the data by the prefix, **t**) into relative strength of frequencies present in the signal (represented by prefix **f**).

## The Variable Names
### The Measurement Variables Contained in the Dataset

The above processing produced the following 33 signals for each 2.56 second window as described in README. The analysis function, run_analysis() selected the **mean** and standard deviation, **std** reported in the original dataset for each, resulting in a total of 66 measurement variables.

1. **tBodyAcc.X**
  * X component of acceleration due to volunteer's motion
  * Numerical, units of g
2. **tBodyAcc.Y**
  * Y component of acceleration due to volunteer's motion
  * Numerical, units of g
3. **tBodyAcc.Z**
  * Z component of acceleration due to volunteer's motion
  * Numerical, units of g
4. **tGravityAcc.X**
  * X component of acceleration due to gravity
  * Numerical, units of g
5. **tGravityAcc.Y**
  * Y component of acceleration due to gravity
  * Numerical, units of g
6. **tGravityAcc.Z** 
  * Z component of acceleration due to gravity
  * Numerical, units of g
7. **tBodyAccJerk.X**
  * X component of instantaneous change in acceleration
  * Numerical, units of g/sec
8. **tBodyAccJerk.Y**
  * Y component of instantaneous change in acceleration
  * Numerical, units of g/sec
9. **tBodyAccJerk.Z**
  * Z component of instantaneous change in acceleration
  * Numerical, units of g/sec
10. **tBodyGyro.X**
  * X component of angular velocity
  * Numerical, units of radians/sec
11. **tBodyGyro.Y**
  * Y component of angular velocity
  * Numerical, units of radians/sec
12. **tBodyGyro.Z**
  * Z componenet of angular velocity
  * Numerical, units of radians/sec
13. **tBodyGyroJerk.X**
  * X component of instantaneous change in angular velocity
  * Numerical, units of radians/sec^2^
14. **tBodyGyroJerk.Y**
  * Y component of instantaneous change in angular velocity
  * Numerical, units of radians/sec^2^
15. **tBodyGyroJerk.Z**
  * Z component of instantaneous change in angular velocity
  * Numerical, units of radians.sec^2^
16. **tBodyAccMag**
  * Overall magnitude of acceleration due to volunteer's motion
  * Numerical, units of g
17. **tGravityAccMag**
  * Overall magnitude of acceleration due to gravity
  * Numerical, units of g
18. **tBodyAccJerkMag**
  * Instantaneous change in overall magnitude due to volunteer's motion
  * Numerical, units of g/sec
19. **tBodyGyroMag**
  * Overall magnitude of angular velocity
  * Numerical, units of radians/sec
20. **tBodyGyroJerkMag**
  * Instantaneous change in overall magnitude of angular velocity
  * Numerical, units of radians/sec^2^
21. **fBodyAcc.X**
  * Frequency domain signal of x component acceleration due to volunteer's motion
  * Numerical, units of Hz
22. **fBodyAcc.Y**
  * Frequency domain signal of y component acceleration due to volunteer's motion
  * Numerical, units of Hz
23. **fBodyAcc.Z**
  * Frequency domain signal of z component acceleration due to volunteer's motion
  * Numerical, units of Hz
24. **fBodyAccJerk.X**
  * Frequency domain signal of x component of instantaneous change in acceleration due to volunteer's motion
  * Numerical, units of Hz
25. **fBodyAccJerk.Y**
  * Frequency domain signal of y component of instantaneous change in acceleration due to volunteer's motion
  * Numerical, units of Hz
26. **fBodyAccJerk.Z**
  * Frequency domain signal of z component of instantaneous change in acceleration due to volunteer's motion
  * Numerical, units of Hz
27. **fBodyGyro.X**
  * Frequency domain signal of x component of angular velocity
  * Numerical, units of Hz
28. **fBodyGyro.Y**
  * Frequency domain signal of y component of angular velocity
  * Numerical, units of Hz
29. **fBodyGyro.Z**
  * Frequency domain signal of z component of angular velocity
  * Numerical, units of Hz
30. **fBodyAccMag**
  * Frequency domain signal of overall acceleration due to volunteer's motion
  * Numerical, units of Hz
31. **fBodyAccJerkMag**
  * Frequency domain signal of instantaneous change in overall acceleration due to volunteer's motion
  * Numerical, units of Hz
32. **fBodyGyroMag**
  * Frequency domain signal of overall angular velocity
  * Numerical, units of Hz
33. **fBodyGyroJerkMag**
  * Frequency domain signal of instantaneous change in overall angular velocity
  * Numerical, units of Hz

### Identification Variables
In addition to the 66 measurement variables, the result tidied dataset contains 3 identification variables:

1. **dataset**
  * Identifies which parent dataset (training or testing) contained the observation before merging in run_analysis()
  * Factor w/ 2 levels "test_set", "train_set"
2. **subject_id**
  * Identifies which volunteer performed the activity during the experiment
  * Integer between 1 and 30, inclusive
3. **activity**
  * Labels the observation with the activity performed at time of measurement
  * Factor w/ 6 levels "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"
  
&nbsp;
&nbsp;
  
  
# Code Book for Summary Dataset

------------------------------

## Producing the Summary Dataset
The summary data were produced by grouping the tidied dataset (described above) by **activity** and **subject_id**, then averaging each measurement variable listed above for each of the 180 activity, subject pairs. The result is a dataset in which there is only one observation from each activity per each subject.

## The Variable Names
The variables from summary dataset are identical in name and unit to the variables in the tidied dataset (described above). The **dataset** variable was ommitted from the summary dataset.