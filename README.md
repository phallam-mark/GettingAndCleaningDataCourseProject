# run_analysis.R README

Pre-requisites for running 'run_analysis.R':
- specify your working directory and place the following files in it:
	- X_test.txt
	- X_train.txt
	- features.txt
	- y_test.txt
	- y_train.txt
	- subject_test.txt
	- subject_train.txt

All of the above files can be found within the 'UCI HAR Dataset.zip' archive, which can be obtained at:
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

The R 'dplyr' library must be installed.

When run, the script will produce 'Final_Tidy_Data.txt' as it's output.