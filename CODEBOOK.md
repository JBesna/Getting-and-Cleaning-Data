Note: I originally had the CODE BOOK as part of the README file. Moved to a separate file to avoid confusion.

CODE BOOK: field 1: activity_name description: one of six activities that were studied 
allowable values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS 
type: factor with 6 levels 
note: each subject performed all activities in the study

field 2: subject_number 
description: captures the number of the study participants 
allowable values: 1:30 
type: integer 
note: each subject performed all activities in the study

fields 3-81: average of various statistics in the study 
description: each field is the average value of either a mean or standard. These are all the fields that contained either mean() or std() in the train/test data. deviation in the data set. See names(final_data) for a list of the field names 
allowable values: [-1,1] 
type: continuous number

For full details, see original site:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
