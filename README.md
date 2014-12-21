Getting And Cleaning Course Project
==================

In this project, we are taking data from Samsung Galaxy Phone users and providing averages across numerous variables. This data is provided at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. For this script to run properly, the user will need to download the ZIP datafile. The larger ZIP file will need to be unzipped inside your working directory while preserving the directory names it provides.
  
First, the script pulls information that will can be used to provide more descriptive labels to our variables for measurements and for the activities. The CodeBook will provide more context for the variable names for the measures.
From here, the script reads the training and test sujbect data into memory and combines them. In both cases, I am pulling the subject and activity information and appending the data to the base information using the cbind function. This allows me to preserve the order of the three files. These datasets are combined, using rbind, to give one large combined data set, combinedData. This is all done with a single command to minimize memory used.

From here, the script resolves the activity ID column to include the activity name using the merge function within the combinedData dataframe.

Once the descriptive activity name is available, we use dplyr functionality to string together the group_by and summarise_each functions to provide us a mean/average for each of the non-grouped variables.

Finally, we use write.table to provide a file for further research...and submission for the course project.
