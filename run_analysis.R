run_analysis <- function() {
        
        #load necessary libraries (dplyr, plyr, data.table)
        library(plyr)
        library(dplyr)
        library(data.table)

        #check to see the directory exists, if it doesn't, create it.
        mainDir <- "c:/data_science_data/Project/GCD_Cource_Project"
        subDir <- "data2"
        
        dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
        
        ##download the raw data file (.zip) from the UCI website if it doesn't exists
        if (!file.exists("data/tracking_data.zip")) {
                url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(url, "data/tracking_data.zip")
        }
        
        ##unzip the file in the data directory
        if (!file.exists("data/UCI HAR Dataset")) {
                unzip("data/tracking_data.zip", exdir = "./data")
        }
        
        #read files into var names
        f.features <- read.table("data/UCI HAR Dataset/features.txt")
        f.act_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")
        f.sb_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
        f.sb_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
        f.X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
        f.X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
        f.y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
        f.y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
        
        
        
        #create column names for X_test and X_train from second column of features
        colnames(f.X_test) <- f.features[,2] 
        colnames(f.X_train) <- f.features[,2] 
                
        #C Bind subject_test (sb_test) with y_test and x_test
        mg_test <- bind_cols(f.sb_test,f.y_test, f.X_test)
        
        #C Bind subject_train (sb_train with y_train and x_train)
        mg_train <- bind_cols(f.sb_train,f.y_train, f.X_train)

        #R Bind the mg_train to the bottom of mg_test into var mg_complete
        mg_complete <- rbind(mg_test, mg_train)

        #rename the first two columns
        names(mg_complete)[1] <- "participant_ident"; names(mg_complete)[2] <- "activity_label"
                
        #subset mg_complete so that mg_mean_std only contains the 1st two columns and all mean and std columns
        mg_mean_std <- mg_complete[,c(1,2,grep("mean\\(\\)|std\\(\\)",names(mg_complete)))]
        
        #clean up column headers (all but the first two)
        names(mg_mean_std) <- gsub("\\(\\)|^t", "", names(mg_mean_std))
        names(mg_mean_std) <- gsub("\\-|\\,", "\\.", names(mg_mean_std))
        names(mg_mean_std) <- tolower(names(mg_mean_std))
        
        ##rename the data in the activities column using descriptive names from act_labels
        mg_mean_std$activity_label <- mapvalues(mg_mean_std$activity_label, as.integer(act_labels$V1), as.character(act_labels$V2))
        
        ##group by participant_ident and activity level.  Get mean across columns.
        mg_mean_summary <- mg_mean_std %>% group_by(participant_ident, activity_label) %>%
                summarize_each(funs(mean))
        
        ##export the data as a txt file named final_output.txt, rownames will be set to FALSE
        write.table(mg_mean_summary,"final_output.txt", row.names = FALSE)
        
        return(mg_mean_summary)        
}