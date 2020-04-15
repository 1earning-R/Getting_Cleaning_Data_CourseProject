## Final Project for "Getting and Cleaning Data"

-----------------------------------------------

This repository contains the author's submission to Johns Hopkins University's 'Getting and Cleaning Data' class offered on coursera.com. The raw data used in this project are available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The purpose of this project is entirely pedagogical, providing practice in cleaning data sets by following the principles of tidy data [(Wickam 2014)](https://vita.had.co.nz/papers/tidy-data.html):

1. Each variable forms a column
2. Each observation forms a row
3. Each type of observational unit forms a table

### The Data
The raw data were collected by [Reyes-Ortiz et. al](http://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones) and contain 'features' calculated from accelerometer and gyroscope signals collected during an experiment in which volunteers, wearing a smartphone equipped with standard acclerometer and gyroscope, performed 6 different activities: walking, walking up stairs, walking down stairs, sitting, standing, and lying<sup>[1](#footnote1)</sup>. 
The data collected in this experiment were processed to reduce noise. Calculations of physical properties and statistical measurements were then made from the data in 2.56 second windows (the data were collected at 50 counts/second, resulting in 128 measurements per window). These windows overlapped adjacent windows such that 64 measurements were shared by any two neighboring windows. For a more complete discussion of the measurements, refer to [CodeBook.md](https://github.com/1earning-R/Getting_Cleaning_Data_CourseProject/blob/master/CodeBook.md). The resulting data set of statistical measurements contained 10,299 observations of 561 variables. Lastly, the observations were divided into two data sets for machine learning purposes: training and testing.

### The Assignment
The challenge presented by this project was to reunite the two data sets described above and filter the new data set down to only the mean and standard deviation variables presented in the raw data. Additionally, two more variables needed to be appended: a factor vector describing the activity being performed during each observation and an integer vector listing the ID number of the volunteer performing the activity. From this new tidied data set, a summary data set was to be produced that would contain the mean values of the mean and standard deviation variables in the first data set, grouped by activity and volunteer.

### The Function
The function written to perform this analysis is called, [run_analysis()](https://github.com/1earning-R/Getting_Cleaning_Data_CourseProject/blob/master/scripts/run_analysis.R). It performs the following tasks.

##### Reads Data Files and Assigns Variable Names
The function calls read.table() to read  the files *"train/X_train.txt"* and *"test/X_test.txt"*. These two data.frames contain the raw data to be merged and filtered. The variable names for these two data.frames are stored separately in *"features.txt"*. These names are read using read.table() then altered slightly. The function calls sub() through sapply() to remove the redundant "Body" string from names in which it appears twice. The function also calls gsub() through sapply() to remove parentheses and replace "-" with "." in order to facilitate reading the variable names into R later. These variable names are then applied to both data.frames.

##### Filters for Mean and Standard Deviations
Part of the assignment is to reduce the data down to just the variables that report the mean values and standard deviations of the 33 properties listed in [CodeBook.md](https://github.com/1earning-R/Getting_Cleaning_Data_CourseProject/blob/master/CodeBook.md). These names of these variables contain the strings "-mean()" or "-std()", so grep is used to create an index that reduces the data.frames to only those variables.

##### Converts Activity to a Factor with Appropriate Labels
The function calls as.character() and read.table() to obtain the key that relates the activity descriptions (walking, walking upstairs, walking downstairs, sitting, standing, and laying) to the integer vectors contained in *"y_train.txt"* and *"y_test.txt"*. These integer vectors are converted to factors using factor() with the optional **labels** variable set to equal the activity key.

##### Reads Subject Identification Data
The function calls read.table() to get the the integer vectors contained in *"train/subject_train.txt"* and *"test/subject_test.txt"*. 

##### Creates Variable to Denote Parent Data Set
The function calls rep() to create two character vectors with lengths equal to the number of rows of the train and test data.frames. These vectors contain "train_set" and "test_set" to distinguish which observation originated from which data.frame.

##### Combines Data into Tidy Data Set
The function calls cbind() to combine in order:

- The "test_set" and "train_set" character vectors to their respective data.frames with the assigned name, **dataset**.

- The subject identification integer vectors to their respective data.frames with the assigned name, **subject_id**.

- The activity factor vectors to their respective data.frames with the assigned name, **activity**.

The two data.frames are then combined using rbind().  
This new data.frame is written to the file name provided by the input variable, **tidy_filename**, by calling write.table() with the optional **row.names** variable set to FALSE.

##### Produces a Summary Data Set
Finally, the function uses the select(), group_by(), and summarize() functions from the dplyr package to create a summary data set. Select() is used to remove the **dataset** variable. The data are then grouped by **subject_id** and **activity**. Lastly, **summarize** returns the mean for each group. This data table is saved to the file name provided by the input variable, **summary_filename**, by calling write.table() with the optional **row.name** variable set to FALSE.

#### The function takes the following inputs.

1. **directory**, containing the raw data 
  * This directory's structure should be unaltered after downloading and decompressing the zipped raw data file.
  * The default for **directory** is *"UCI_HAR_Dataset/"*
2. **tidy_filename**, the name of the .txt file containing the new, tidy data set
  * This new, tidy data set will be saved in a folder named "data/" in the working directory. The function will create this folder if it does not exist.
  * The default for **tidy_filename** is *"result.txt"*
3. **summary_filename**, the name of the .txt file containing a summary data set
  * This summary data set will also be saved in the "data/" directory
  * The default for **summary_filename** is *"summary.txt"*
  

### The Files
#### This repository contains the following files:

- 'run_analysis.R': A function which performs the tasks outlined in the above section.

- 'data/result.txt': The tidied data containing the average and standard deviation measurements for all observations in the raw data.

- 'data/summary.txt': A summary of the data set produced by run_analysis(). This summary data set is grouped by **subject_id** and **activity** and provides, grouped by each subject/activity pair, the mean values of the mean and standard deviation measurements provided in the raw data.

- 'data/example.txt': An abbreviated example of the tidied data set that is small enough to be viewed in GitHub. This example was produced by randomly selecting 200 observations from the tidied data set with the code below, where **result** is the tidied data set.

```
set.seed(28)
example_index <- sample(1:dim(result)[1],200)
write.table(result[example_index,], file = "data/example.txt", row.names = F)  
```

- 'CodeBook.md': A file describing the variables contained in the tidy data set and the subsequent summary data set produced by run_analysis()

- 'README.md': This file.

----------------------------------------------------
##### Footnotes
<a name="footnote1">1</a>: The original codebook for this data set described the action as laying, but the author is a snob and gets hung up on minor details like the fact that lay is a transitive verb.