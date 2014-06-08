CodeBook.md for tidydata.txt
========================================================

Hi, nice to meet you:) This is the CodeBook for course project. Thanks for reading. According to the instruction of courser project, tidydata.txt is a seperate file "with the average of each variable for each activity and each subject". Here, the environment is that

Since most of the column names in tidydata.txt directly comes from the feature_info.txt and features.txt in our Samsung Data package and you must have read them quite well, I won't introduce them one by one to save both your and my time.

However, in the tidydata.txt, I add the first two columns to label the volunteers and activities they did when the record is produced. The names of the two columns are:

**Column 1**
- "VolunteerLabel"
- integer variable from 1 to 30
- indicating the correspondence record is produced by volunteer No.1 to No.3

**Column 2**
- "ActivityLabel"
- character variable extracted from "activity_labels.txt"
- quite descriptive names, you should be OK with it

**Column 3 to 81**
- numeric variables
- names and naming rules are identical with names in features.txt and feastures_info.txt; the order is also relatively the same despite that 482 columns in original .txt files are discarded due to project requirement
- In a column, each value stands for each average value of this column's measurement for each pair(or "group" if you are more familiar with Stackoverflow's wording) of volunteer and activity.

*That's all, hope it doesn't take you too much time!*