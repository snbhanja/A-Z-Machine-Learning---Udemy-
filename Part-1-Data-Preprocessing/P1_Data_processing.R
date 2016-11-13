# Data Processing

# Import the Dataset
dataset = read.csv('Data.csv')

#Taking care of missing data
dataset$Age = ifelse(is.na(dataset$Age), 
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)
                    # If condition statement,
                    # expression to execute if condition is true,
                    # expression to execute if condition is false
dataset$Salary = ifelse(is.na(dataset$Salary), 
                     ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Salary)

# Encoding categorical data. Here we dont need to ne hot encode data like in Python, because R has Factors
dataset$Country = factor(dataset$Country,
                        levels = c('France','Spain','Germany'),
                        labels = c(1, 2, 3))
dataset$Purchased = factor(dataset$Purchased,
                           levels = c('No','Yes'),
                           labels = c(0, 1))

#Split the dataset into training set and test set
# Import the caTools library
# This library not installed before.So, we will install and activate it
install.packages('caTools')
library(caTools)

# In python we used RandomState = 0 to get same results. Here in R we will use seed
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
# In python the splitRatio is for test set, while in R splitRatio is for Trainset
# Enter split in console
# It returns TRUE if observation is included in trainingset and FALSE if observation goes to Testset.
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#Feature Scaling
training_set[, 2:3] = scale(training_set[,2:3])
test_set[,2:3] = scale(test_set[,2:3])
# column indices are 0,1,2,3.  Out of this columns 0 and 3 are numeric data.
# Columns 1 and 2 we can scale




