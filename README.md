----------
# **GETTING AND CLEANING DATA** #
# Course Project #
----------

run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set. *[Remark 2]*
2. Extracts only the measurements on the mean and standard deviation for each measurement. *[Remark 1]*
3. Uses descriptive activity names to name the activities in the data set. *[Remark 3]*
4. Appropriately labels the data set with descriptive variable names.*[Remark 4]*
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. *[Remark 5]*


*"remark 1,2,3,4 & 5" refer to comment in the "run_analysis" script*

----------


**Remark 1 section**

----------

From feature.txt, the script will extract and construct the column position and respective description. These will be used to extract respective column in dataset as well as for column naming.  


----------

**Remark 2 section**

----------

Dataset (X,Y and subject) from train and test are merged into single X, Y and subject data frame. 

----------

**Remark 3 section**

----------

Descriptions that are extracted during Remark 1 are used here to populate the column name as to provide meaningful description

----------

**Remark 4 section**

----------

Dataset are translated into meaningful description

----------

**Remark 5 section**

----------

Data frames (X,Y & subject) are merged to form a single data frame. Mean are computed by grouping subject and activity

----------

The dataset includes the following files:
=========================================

- 'README.md'

- 'code book.doc': Shows information about the variables used on the feature vector.

