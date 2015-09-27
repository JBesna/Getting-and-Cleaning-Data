# Getting-and-Cleaning-Data

The run_analysis.r program will work if you dowloand the folder:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and set the working directory to the unzipped folder.

The program uses the dplyr package. It takes accelorameter data
from cell phones for 30 users (subject_number in the final data) across six 
different activities (activity_name in the final data)

The program imports the following text files:
activity_labels.txt - this has the activity names
features.txt - this has the labels for the data variables
subject_train/test.txt - this has the subject #'s (aka the participants)
y_train/test.txt - this has the training activity numbers
X_train/text.txt - this has the numeric measures for each activity

The program imports the train data first, then the test data.
On both the train and test data, a key field is added to that 
the various tables can be merged into one table.

Once all of the train data tables are combined into train_data3 and
all of the test data tables are combined into test_data3,
those 2 tables are combined vertically using rbind.

The numeric measures only include measures where feature name contains "mean()" or "std()". 
Note: there are features with "Mean" in the name, but these are not included in this program.

After the train and test data is combined in the combined_data data frame,
the data is melted by activity name and subject number. Averages are produced
using dcast at the unique activity name / subject number combination.

The final output is named final_data and it is written to a text file 
called output.txt

CODE BOOK:
field 1: activity_name
description: one of six activities that were studied
allowable values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
type: factor with 6 levels
note: each subject performed all activities in the study

field 2: subject_number
description: captures the number of the study participants
allowable values: 1:30
type: integer
note: each subject performed all activities in the study

fields 3-77: average of various statistics in the study
description: each field is the average value of either a mean or standard
deviation in the data set. See names(final_data) for a list of the field names
allowable values: [-1,1]
type: continuous number


