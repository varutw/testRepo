This file explains how run_analysis.R works. It reads X data that is

collected from the accelerometers from the 30 Samsung Galaxy S smartphone

users, in different activities. The X data has numerous kind of features.

run_analysis.R reads both test set and train set, and merge into one dataset.
 
Then, it selects only the features that are related to mean and standard deviation,

but excludes meanFreq, which its purpose is not about the mean by its definition.

Afterthat, run_analysis.R calculates the average value of each features, for each

subject and activity. Finally, it creates tidy dataset as an outcome.
