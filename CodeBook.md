### Introduction

This document describes the code inside  run_analysis.R.

The code is splitted (by comments) in 1-8 sections:

1. Reading and combine Test files of the 
   subjects, their activities and the data.
   
2. Reading and combine Train files of the 
   subjects, their activities and the data   

3. Combine the TEST and TRAIN files into one data set.

4. Reading the features file and annoted the labels
   of the data set with the original names.
   
5. Replacing the activities names instead of numeric ids.
  
6. Extract the labels contain the "mean" or "std" patterns
   and their ids.
   
7. Changing the classes in order to be able to remove columns.

8. Recreating the data set without activities names
   using their numeric code make the mission of finding
   the averages simpler. At the end step the ids will be 
   replaced by names.

The final dity data set loaded to "TidyDataSet.txt" file looks like:

Subject           Activity tBodyAcc-mean()-X    tBodyAcc-mean()-Y   
      1            WALKING 0.277330758736842  -0.0173838185273684 
      1   WALKING_UPSTAIRS 0.255461689622641  -0.0239531492643396 
      1 WALKING_DOWNSTAIRS 0.289188320408163 -0.00991850461020408 

     

