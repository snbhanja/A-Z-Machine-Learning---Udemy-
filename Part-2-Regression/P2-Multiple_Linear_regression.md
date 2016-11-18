
## Multiple Linear Regression using R


```R
# Data Processing
# Import the Dataset
dataset = read.csv('datasets/50_Startups.csv')
```


```R
summary(dataset)
```


       R.D.Spend      Administration   Marketing.Spend         State   
     Min.   :     0   Min.   : 51283   Min.   :     0   California:17  
     1st Qu.: 39936   1st Qu.:103731   1st Qu.:129300   Florida   :16  
     Median : 73051   Median :122700   Median :212716   New York  :17  
     Mean   : 73722   Mean   :121345   Mean   :211025                  
     3rd Qu.:101603   3rd Qu.:144842   3rd Qu.:299469                  
     Max.   :165349   Max.   :182646   Max.   :471784                  
         Profit      
     Min.   : 14681  
     1st Qu.: 90139  
     Median :107978  
     Mean   :112013  
     3rd Qu.:139766  
     Max.   :192262  



```R
# Encoding categorical data. Here we dont need to ne hot encode data like in Python, because R has Factors
dataset$State = factor(dataset$State,
                        levels = c('New York','California','Florida'),
                        labels = c(1, 2, 3))
```


```R
summary(dataset)
```


       R.D.Spend      Administration   Marketing.Spend  State      Profit      
     Min.   :     0   Min.   : 51283   Min.   :     0   1:17   Min.   : 14681  
     1st Qu.: 39936   1st Qu.:103731   1st Qu.:129300   2:17   1st Qu.: 90139  
     Median : 73051   Median :122700   Median :212716   3:16   Median :107978  
     Mean   : 73722   Mean   :121345   Mean   :211025          Mean   :112013  
     3rd Qu.:101603   3rd Qu.:144842   3rd Qu.:299469          3rd Qu.:139766  
     Max.   :165349   Max.   :182646   Max.   :471784          Max.   :192262  



```R
#Splitting the dataset into training set and test set
# In python we used RandomState = 0 to get same results. Here in R we will use seed
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
# The first argument of split methode is dependent variable
# In python the splitRatio is for test set, while in R splitRatio is for Trainset
# Enter split in console
# It returns TRUE if observation is included in trainingset and FALSE if observation goes to Testset
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
```


```R
# --- Feature scaling not required here as SimplelinearRegression takes care of this
```


```R
# Fitting multiple linear regression to the Training Set
regressor = lm(formula = Profit ~ .,
              data = training_set)
# . dot indicates that, R takes Profit as a linear combination 
# of all independent variable
```


```R
summary(regressor)
```


    
    Call:
    lm(formula = Profit ~ ., data = training_set)
    
    Residuals:
       Min     1Q Median     3Q    Max 
    -33128  -4865      5   6098  18065 
    
    Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
    (Intercept)      4.965e+04  7.637e+03   6.501 1.94e-07 ***
    R.D.Spend        7.986e-01  5.604e-02  14.251 6.70e-16 ***
    Administration  -2.942e-02  5.828e-02  -0.505    0.617    
    Marketing.Spend  3.268e-02  2.127e-02   1.537    0.134    
    State2           1.213e+02  3.751e+03   0.032    0.974    
    State3           2.376e+02  4.127e+03   0.058    0.954    
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
    Residual standard error: 9908 on 34 degrees of freedom
    Multiple R-squared:  0.9499,	Adjusted R-squared:  0.9425 
    F-statistic:   129 on 5 and 34 DF,  p-value: < 2.2e-16




```R
# The lower the p-value, the more impact the independent variable has on dependent variable.
# The * stars indicate that, when p-value is between 0 and 0.001, the significance
# level is '***'. That means the independent variable is highly statistically significant.
# Here the Profit is mainly governed by R.D.Spend
```


```R
# Predict the test set results
Y_pred = predict(regressor, newdata = test_set)
```


```R
Y_pred
```


<dl class=dl-horizontal>
	<dt>4</dt>
		<dd>173981.087289013</dd>
	<dt>5</dt>
		<dd>172655.638294541</dd>
	<dt>8</dt>
		<dd>160250.020750651</dd>
	<dt>11</dt>
		<dd>135513.899440935</dd>
	<dt>16</dt>
		<dd>146059.361208703</dd>
	<dt>20</dt>
		<dd>114151.026047729</dd>
	<dt>21</dt>
		<dd>117081.624376537</dd>
	<dt>24</dt>
		<dd>110671.313743947</dd>
	<dt>31</dt>
		<dd>98975.2939884832</dd>
	<dt>32</dt>
		<dd>96867.0305670216</dd>
</dl>




```R
summary(test_set)
```


       R.D.Spend      Administration   Marketing.Spend  State     Profit      
     Min.   : 61136   Min.   : 91392   Min.   :     0   1:4   Min.   : 97484  
     1st Qu.: 69713   1st Qu.:111412   1st Qu.:125639   2:1   1st Qu.:111169  
     Median : 94166   Median :117157   Median :280220   3:5   Median :126347  
     Mean   : 98655   Mean   :123028   Mean   :234696         Mean   :132829  
     3rd Qu.:126354   3rd Qu.:139802   3rd Qu.:319100         3rd Qu.:153345  
     Max.   :144372   Max.   :153514   Max.   :383200         Max.   :182902  



```R
test_set$Profit
```


<ol class=list-inline>
	<li>182901.99</li>
	<li>166187.94</li>
	<li>155752.6</li>
	<li>146121.95</li>
	<li>129917.04</li>
	<li>122776.86</li>
	<li>118474.03</li>
	<li>108733.99</li>
	<li>99937.59</li>
	<li>97483.56</li>
</ol>




```R

```


```R

```
