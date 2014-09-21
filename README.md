Run_analysis Process
============
STEP 1

read.table -> get the raw data from the files

dim(), head() -> grasp the general info. of the data and start analyzing

cbind(),rbind() -> merge the training and test data sets into one


STEP 2

create an empty dataframe temp2 to put subject & label columns

select(), matches() -> filter all the columns and leave with the ones contain only mean() or std(), but NOT meanFreq()

merge all the columns with mean an std into the dataset extract

STEP 3

e.g. extract$label[extract$label =="1"] <-"WALKING" to replace all the activity numbers with descriptive activity names

STEP 4

remove all "()"s from the column name, however, the rest stays the same.

STEP 5

arrange() from dplyr package ->order the tidy data set with respect the subject number. Then, calculate the results we need using the ddply from dplyr and plyr packages.


