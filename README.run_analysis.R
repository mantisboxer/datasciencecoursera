# description for run_analysis.R

this script depends on dplyr and tidyr scrips, available through the install.packages command

The dataset of interest can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Make sure to set the working directory to the location of the extracted UCI HAR Dataset folder

running the script will create 2 main dataframes - a full combined dataset, composed of the average and stdev data from the project, and a summary table, showing the average mean and standard deviation grouped by activity type and subject

see the codebook (run_analysis_Codebook) for more details
