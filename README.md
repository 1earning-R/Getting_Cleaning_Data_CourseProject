## Final Project for "Getting and Cleaning Data"

-----------------------------------------------

This repository contains the author's submission to Johns Hopkins University's 'Getting and Cleaning Data' class offered on coursera.com. The raw data used in this project are available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The purpose of this project is entirely pedagogical, providing practice in cleaning datasets by following the principles of tidy data [(Wickam 2014)](https://vita.had.co.nz/papers/tidy-data.html):

1. Each variable forms a column
2. Each observation forms a row
3. Each type of observational unit forms a table

### The Data
The raw data were collected by [Reyes-Ortiz et. al](http://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones) and contain 'features' calculated from accelerometer and gyroscope signals collected during an experiment in which volunteers, wearing a smartphone equipped with standard acclerometer and gyroscope, performed 6 different activities: walking, walking up stairs, walking down stairs, sitting, standing, and lying<sup>[1](#footnote1)</sup>. 
The data collected in this experiment were processed to reduce noise. Calculations of physical properties and statistical measurements were then made from the data in 2.56 second windows (the data were collected at 50 counts/second, resulting in 128 measurements per window). These windows overlapped adjacent windows such that 64 measurements were shared by any two neighboring windows. For a more complete discussion of the measurements, refer to CodeBook.md.The resulting dataset of statistical measurements contained 10,299 observations of 561 variables. A wealth of information but unwieldy. Lastly, the observations were divided into two datasets for machine learning purposes: training and testing.


The challenge presented by this project was to reunite these two datasets and filter it down to only the variables (called 'features' in the dataset) that were calculated by taking the means and the standard deviations of the physical properties.

### The Function
The function written to perform this analysis is called, [run_analysis()](https://github.com/1earning-R/Getting_Cleaning_Data_CourseProject/blob/master/scripts/run_analysis.R). The function calls read.table to read relevant information from the raw data, including features.txt and activity_labels.txt to obtain the variable names of the dataset and the factor labels of the activity variable, respectively. The desired mean and standard deviation variables contain either "-mean(" or "-std(" in their names, so run_analysis() calls grep() to search for these strings and index the datasets. The variable called **dataset** is created to denote from which dataset the observation originated. The variable **subject_id** is created to denote which subject performed the activity (1-30). Finally, the two datasets are combined into one tidy dataset with rbind(). This data frame is saved to the file name provided by the input variable: **tidy_filename**.

After creating the new, tidy dataset, the function uses the select, group_by, and summarize functions from the dplyr package to create a summary dataset. Select() is used to remove the **dataset** variable. The data are then grouped by **subject_id** and **activity**. Lastly, **summarize** returns the mean for each group. This data table is saved to the file name provided by the input variable: **summary_filename**.

The function takes the following inputs.

1. **directory**, containing the raw data 
  * This directory's structure should be unaltered after downloading and uncompressing.
  * The default for **directory** is "UCI_HAR_Dataset"
2. **tidy_filename**, the name of the .csv file containing the new, tidy dataset
  * This tidied dataset will include observations from both the training and testing datasets.
  * It will also have added variables to denote the subject identification number (1-30), activity (walking, walking upstairs, walking downstairs, sitting, standing, or laying), and whether it came from the train or test dataset (train, test).
  * The variable names will mostly be preserved from the names provided in the features.txt file found in the raw data, except parentheses will be removed and dashes will be replaced with periods. This is to facilitate reading the names into R.
  * This new, tidy dataset will be saved in a folder named "data/" in the working directory. The function will create this folder if it does not exist.
  * The default for **tidy_filename** is "result.csv""
3. **summary_filename**, the name of the .csv file containing a summary dataset
  * This summary dataset will be the grouped by subject and activity with each variable from the previous dataset averaged for each of the 180 activity, subject pairs.
  * This dataset does not contain information about which dataset (training or testing) the observations originated
  * This summary dataset will also be saved in the "data/" directory
  * The default for **summary_filename** is "summary.csv"
  

#### This repository contains the following files:

- 'scripts/run_analysis.R': A function which performs the tasks outlined in the above section.

- 'data/summary.csv': A summary of the dataset produced by run_analysis(). This summary dataset is grouped by **subject_id** and **activity** and provides, grouped by each subject/activity pair, the mean values of the mean and standard deviation measurements provided in the raw data.

- 'CodeBook.md': A file describing the variables contained in the tidy dataset and the subsequent summary dataset produced by run_analysis()

- 'README.md': This file. The one you see before you.

**Note that the tidy dataset was not committed to this repository. This is because even reduced to a fraction of the raw data's original size, it is too large to upload. If you are willing to share your github expertise, feel free to reach out to me and help me figure out how to upload a compressed file without GitHub automagically decompressing it.**

----------------------------------------------------
<a name="footnote1">1</a>: The original codebook for this dataset described the action as laying, but the author is a snob and gets hung up on minor details like the fact that lay is a transitive verb.