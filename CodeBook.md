---
title: "CodeBook.md"
author: "Lyle McMillin"
date: "January 23, 2016"
output: html_document
---
This codebook describe the steps I took to download and transform the data.  

###Merges the training and the test sets to create one data set.

I downloaded the zip file from the following URL (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The data was read into a series of data frames with the read.table function.  The variable names create are as follows:

        *f.features
        *f.act_labels
        *f.sb_test
        *f.sb_train
        *f.X_test
        *f.X_train
        *f.y_test
        *f.y_train
        
Next, the script binds the columns for the all of the test files and the train files into two separate, temporary data frames (mg\_test and mg\_train)

Those data frames are then row bound into mg_complete.

###Uses descriptive activity names to name the activities in the data set
mg\_complete is then filtered so that only the mean() and std() columns remain.

The columns are all renamed removing any unwanted characters and made lowercase.

These are the column names for the final output:

        "participant\_ident"         
        "activity_label"            
        "bodyacc.mean.x"           
        "bodyacc.mean.y"            
        "bodyacc.mean.z"            
        "bodyacc.std.x"            
        "bodyacc.std.y"             
        "bodyacc.std.z"             
        "gravityacc.mean.x"        
        "gravityacc.mean.y"         
        "gravityacc.mean.z"         
        "gravityacc.std.x"         
        "gravityacc.std.y"          
        "gravityacc.std.z"          
        "bodyaccjerk.mean.x"       
        "bodyaccjerk.mean.y"        
        "bodyaccjerk.mean.z"        
        "bodyaccjerk.std.x"        
        "bodyaccjerk.std.y"         
        "bodyaccjerk.std.z"         
        "bodygyro.mean.x"          
        "bodygyro.mean.y"           
        "bodygyro.mean.z"           
        "bodygyro.std.x"           
        "bodygyro.std.y"            
        "bodygyro.std.z"            
        "bodygyrojerk.mean.x"      
        "bodygyrojerk.mean.y"       
        "bodygyrojerk.mean.z"       
        "bodygyrojerk.std.x"       
        "bodygyrojerk.std.y"        
        "bodygyrojerk.std.z"        
        "bodyaccmag.mean"          
        "bodyaccmag.std"            
        "gravityaccmag.mean"        
        "gravityaccmag.std"        
        "bodyaccjerkmag.mean"       
        "bodyaccjerkmag.std"        
        "bodygyromag.mean"         
        "bodygyromag.std"           
        "bodygyrojerkmag.mean"      
        "bodygyrojerkmag.std"      
        "fbodyacc.mean.x"           
        "fbodyacc.mean.y"           
        "fbodyacc.mean.z"          
        "fbodyacc.std.x"            
        "fbodyacc.std.y"            
        "fbodyacc.std.z"           
        "fbodyaccjerk.mean.x"       
        "fbodyaccjerk.mean.y"       
        "fbodyaccjerk.mean.z"      
        "fbodyaccjerk.std.x"        
        "fbodyaccjerk.std.y"        
        "fbodyaccjerk.std.z"       
        "fbodygyro.mean.x"          
        "fbodygyro.mean.y"          
        "fbodygyro.mean.z"         
        "fbodygyro.std.x"           
        "fbodygyro.std.y"           
        "fbodygyro.std.z"          
        "fbodyaccmag.mean"          
        "fbodyaccmag.std"           
        "fbodybodyaccjerkmag.mean" 
        "fbodybodyaccjerkmag.std"   
        "fbodybodygyromag.mean"     
        "fbodybodygyromag.std"     
        "fbodybodygyrojerkmag.mean" 
        "fbodybodygyrojerkmag.std" 

###Extracts only the measurements on the mean and standard deviation for each measurement.

mg\_complete is then grouped by participant\_ident and activity\_labels.  The mean of each column is taken and the results are outputted to mg_mean_summary.

###From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The function returns a data frame that can then be written to a CSV by the user.