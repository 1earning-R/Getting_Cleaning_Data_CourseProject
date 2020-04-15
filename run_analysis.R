run_analysis <- function(directory="UCI_HAR_Dataset/",
                         tidy_filename="result.txt",
                         summary_filename="summary.txt"){
  ##  Function to tidy a dataset which was randomly
  ##  divided into subsets train and test for machine learning
  ##  purposes. The data contain features calculated from 
  ##  accelerometer signals collected during an experiment in which
  ##  volunteers, wearing accelerometers, performed 6 different
  ##  activities: walking, walking up stairs, walking down stairs,
  ##  sitting, standing, and laying.
  
  ##  This function filters for mean and std features for
  ##  each measurement, adds columns for activity and subject id, and
  ##  and merges the two datasets.
  
  ##  Additionally, this function creates a separate dataset in which
  ##  the average features from the above dataset are listed for each 
  ##  activity and each volunteer.
  
  require(dplyr)
  
  
  ##  RELEVANT PATHS IN THE DIRECTORY:
  n <- nchar(directory)
  if(!substr(directory,n,n)=="/"){paste0(directory,"/")}
  data_tstpath <- paste0(directory,"test/X_test.txt")
  data_trnpath <- paste0(directory,"train/X_train.txt")
  actv_tstpath <- paste0(directory,"test/y_test.txt")
  actv_trnpath <- paste0(directory,"train/y_train.txt")
  list_ftrpath <- paste0(directory,"features.txt")
  list_actpath <- paste0(directory,"activity_labels.txt")
  sbjc_tstpath <- paste0(directory,"test/subject_test.txt")
  sbjc_trnpath <- paste0(directory,"train/subject_train.txt")
  
  ##  READ IN DATA
  tst_data <- read.table(data_tstpath)
  trn_data <- read.table(data_trnpath)
  ##  READ IN FEATURE NAMES
  features <- as.character(read.table(list_ftrpath)[,2])
  ## REMOVE DUPLICATE "BODY" STRING IN FEATURE NAMES
  features <- sapply(features, temp<-function(n) sub("BodyBody","Body",n))
  
  ##  REMOVE PARENTHESES AND DASHES FOR SMOOTHER IMPORTING INTO R
  new_names <- sapply(features, tmp <- function(n) gsub("-",".",n))
  new_names <- sapply(new_names, tmp <- function(n) gsub("[(][)]","",n))
  names(tst_data) <- new_names; names(trn_data) <- new_names
  
  ##  SEARCH FOR MEAN AND STD MEASUREMENTS AND FILTER DATASETS
  mean_std <- grep("-mean[(]|-std[(]",features)
  tst_data <- tst_data[,mean_std]; trn_data <- trn_data[,mean_std]
  
  ##  READ IN ACTIVITY KEY AND ACTIVITY DATA
  actv_trn <- read.table(actv_trnpath)
  actv_tst <- read.table(actv_tstpath)
  list_act <- read.table(list_actpath)
  act_lvls <- as.character(list_act[,2])
  ##  APPLY KEY TO ACTIVITY DATA
  actv_trn <- factor(actv_trn[,1], labels = act_lvls)
  actv_tst <- factor(actv_tst[,1], labels = act_lvls)
  
  ##  READ IN SUBJECT ID DATA
  sbjc_trn <- read.table(sbjc_trnpath)[,1]
  sbjc_tst <- read.table(sbjc_tstpath)[,1]
  
  ##  COMBINE INTO RESULT DATASET
  new_trn <- cbind(dataset = rep("train_set",nrow(trn_data)),
                   subject_id = sbjc_trn,
                   activity = actv_trn,
                   trn_data)
  new_tst <- cbind(dataset = rep("test_set",nrow(tst_data)),
                   subject_id = sbjc_tst,
                   activity = actv_tst,
                   tst_data)
  result <- rbind(new_trn,new_tst)
  
  ##  GROUP BY SUBJECT AND ACTIVITY
  grp_result <- group_by(result, activity, subject_id)
  
  ##  SUMMARIZE GROUPED DATASET
  sum_result <- select(result,-dataset) %>%
    group_by(activity, subject_id) %>%
    summarize_all(mean)
  
  if (!dir.exists("data")) {dir.create("data")}
  tidy_filepath <- paste("data", tidy_filename, sep="/")
  summary_filepath <- paste("data", summary_filename, sep = "/")
  write.table(result, file = tidy_filepath, row.names = F)
  write.table(sum_result, file = summary_filepath, row.names = F)
}