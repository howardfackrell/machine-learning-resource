# machine-learning-resource
Resources for learning about Machine Learning (ML)


## Videos
| Source | Video | length | level | Notes |
|--------|-------|--------|-------|-------|
|Pluralsight [David Chappell] | Understanding Machine Learning | 39m | beginner | Pretty basic, similar material in other Pluralsight videos
|Pluralsight [Abhishek Kumar] | R Programming Fundamentals | 7h 0m | beginner | |
|Pluralsight [Casimir Saternos] | RStudio:Get Started | 3h 14m | intermediate | |
|Pluralsight [Jerry Kurata] | Understanding Machine Learning with R |1h 25m | beginner | Good introduction, with an example }
|Pluralsight [Jerry Kurata] | Understanding Machine Learning with Python | 1h 54m | beginner | |
|Pluralsight [Matthew Renze] | Beginning Data Visualization with R | 3h 1m | beginner | |
|Pluralsight [Matthew Renze] | Exploratory Data Analysis with R | 2h 30m | beginner | |
|Pluralsight [Matthew Renze] | Multivariate Data Visualization with R | 2h 11m | intermediate | |

## Courses
|Site|Course Name|
|----|-----------|
|udacity.com|[Intro to Machine Learning](https://www.udacity.com/course/intro-to-machine-learning--ud120)|
|coursera.com|[Machine Learning Spcicialization - 6 courses](https://www.coursera.org/specializations/machine-learning)|


## Anaconda system under docker
If you have docker installed, you can run an anaconda image for either python 2 or 3.

```
docker pull continuumio/anaconda
docker run -i -t -p 8888:8888 continuumio/anaconda /bin/bash
```
from the shell started above you can install packages and start a jupyter notebook

```
conda install jupyter
jupyter notebook --ip='*' --port=8888 --no-browser
```
then open the browser on your host mahine to http://<docker-machine>:8888


## Cheat Sheets
- [R and R Studio](https://www.rstudio.com/resources/cheatsheets/)

## Places to find Data
- [Department of Transportation](https://www.transportation.gov/)
- [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml)

## Included Examples
### example/flightdelay (in R)
This is the example from the Pluralsight video 'Understanding Machine Learning with R'. The data comes from the DOT. The exercise is to predict which flights will be delayed by 15 minutes or more.

### example/income (in R)
This dataset is from the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/machine-learning-databases/adult/). The excercise is to predict whether individuals make more or less than 50,000.00 based on some demographics. There is a data file and a separate test file.

