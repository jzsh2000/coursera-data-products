## iris dataset

`iris` is a data frame with 150 cases (rows) and 5 variables (columns) named
_Sepal.Length_, _Sepal.Width_, _Petal.Length_, _Petal.Width_, and _Species_.

This famous (Fisher's or Anderson's) iris data set gives the measurements in
centimeters of the variables sepal length and width and petal length and width,
respectively, for 50 flowers from each of 3 species of iris. The species are
_Iris setosa_, _versicolor_, and _virginica_.

## shiny application

This shiny application includes two parts, __data viewer__ and __class
predictor__. 

__data viewer__ generates a plot for the original `iris` data. The `variable 1`
and `variable 2` are the two variables used in x-axis or y-axis, respectively.
You can adjust the point size by moving the `point size` slider bar. By
default, the scatter plot is colored by iris species, but this functionality
could be turned off by setting `color by species` to 'False'.

__class predictor__ predicts _Species_ variable with the four features:
_Sepal.Length_, _Sepal.Width_, _Petal.Length_, _Petal.Width_. Currently, only
the `rpart` method could be used. The `random seed` influences the result of
train-test splitting. The `training percentage` decides how many data points
are retained in the training set. The `cross-validation fold` controls the
cross-validation behavior, notice that the larger the fold is, the longer time
will the program needs to run. The output is a decision tree plot and the
confusion matrix on the test set.
