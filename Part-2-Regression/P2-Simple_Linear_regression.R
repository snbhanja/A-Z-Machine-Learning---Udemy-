# Data Processing

# Import the Dataset
dataset = read.csv('Salary_Data.csv')
# dataset has two column, YearsExperience and Salary

#Split the dataset into training set and test set
# Import the caTools library
# This library not installed before.So, we will install and activate it
#install.packages('caTools')
#library(caTools)

# In python we used RandomState = 0 to get same results. Here in R we will use seed
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
# The first argument of split methode is dependent variable
# In python the splitRatio is for test set, while in R splitRatio is for Trainset
# Enter split in console
# It returns TRUE if observation is included in trainingset and FALSE if observation goes to Testset.
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#Feature Scaling
#training_set[, 2:3] = scale(training_set[,2:3])
#test_set[,2:3] = scale(test_set[,2:3])
# column indices are 0,1,2,3.  Out of this columns 0 and 3 are numeric data.
# Columns 1 and 2 we can scale
# --- Feature scaling not required here as SimplelinearRegression takes care of this

# Fitting simple linear regression to the training set
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)

summary(regressor)

# Predicting the test set results
y_pred = predict(regressor, newdata = test_set)

# Visualising the Training set results
# Install ggplot library
#install.packages("ggplot2")
#library(ggplot2)

# 1. Plot all the observation points in trainingset
# 2. Add a title.
# 3. Add a label to X axis and Y axis
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience(Training Set)') +
  xlab('Years of experience') +
  ylab('Salary')

# Visualising the Test set results
ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience(Test Set)') +
  xlab('Years of experience') +
  ylab('Salary')



  
             



  






