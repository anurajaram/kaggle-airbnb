
# __________________________________________________________________
# //////////////////////////////////////////////////////////////////
#
# Author - Anupama Rajaram
# Filename - Code for Airbnb Kaggle competition - jan 18
#
# Description - We assume all users have two standard destination 
# choices NDF&US (in that order). Based on some basic segmentation,
# according to age, gender and browser language, some users may 
# have a third location preference too.
#
# Kaggle Score - 0.83231. 
# note if we simply take the first two scores, it directly gives a 
# score of 0.82716! 
# __________________________________________________________________
# //////////////////////////////////////////////////////////////////

# To clean up the memory of your current R session run the following line
rm(list=ls(all=TRUE))

options(digits=2)

#===================================================================#
#=========== Section 1: Data Management ============================#

# Load text file into local variable called 'data' - 51243 rows and 3 columns
data = read.delim(file = 'train_users_2.csv', header = TRUE, 
                  sep = ',', dec = '.')

test = read.delim(file = 'test_users.csv', header = TRUE, 
                  sep = ',', dec = '.')

# Data exploration - Display the data after transformation
head(data)
summary(data)


#============= Recoding incorrect values ==============#
data$age[data$age >= 100] <- NA  # many users have age = 2014
data$lang[data$language == "-unknown-"] <- NA 

test$age[test$age >= 100] <- NA 
test$lang[test$language == "-unknown-"] <- NA 


# creating new variable called "agegr" to divide users in age bins.
# 0 <- NA, 5 <- child (less than 18 yrs), 25 <- adult (18 to 54), 
# 60 <- seniors (55 to 100)
data$agegr <- 0
data$agegr[data$age<18] <- 5
data$agegr[data$age>=18 & data$age<55] <- 25
data$agegr[data$age>=55] <- 60

test$agegr <- 0
test$agegr[test$age<18] <- 5
test$agegr[test$age>=18 & test$age<55] <- 25
test$agegr[test$age>=55] <- 60


# variables for destination
test$locn <- "NDF" # assuming first option for all users is "NDF"
test$locn2 <- "US" # assuming second option for all users is "US"
test$locn3 <- NA
test$locn4 <- NA

# Using feature engineering, it is shown that together (agegr, language and gender) 
# influence destination. Rules are as follows, that we directly apply to the test set.
test$locn3[test$agegr == 0 & test$language== "en" & test$gender=="-unknown-"] <- "FR"
test$locn3[test$agegr == 25 & test$language== "en" & test$gender=="MALE"] <- "FR"
test$locn3[test$agegr == 25 & test$language== "en" & test$gender=="FEMALE"] <- "FR"
test$locn3[test$agegr == 25 & test$language == "de"] <- "DE"
test$locn3[test$agegr == 25 & test$language == "es"] <- "ES"
test$locn4[test$agegr == 25 & test$language == "es"] <- "FR"
test$locn3[test$agegr == 25 & test$language == "fr"] <- "FR"
test$locn3[test$agegr == 25 & test$language == "it"] <- "IT"
test$locn3[test$agegr == 25 & test$language == "ko"] <- "FR"
test$locn4[test$agegr == 25 & test$language == "ko"] <- "IT"
test$locn3[test$agegr == 25 & test$language == "ru"] <- "IT"
test$locn4[test$agegr == 25 & test$language == "ru"] <- "ES"
test$locn3[test$agegr == 25 & test$language == "zh"] <- "FR"


# create submission file
submit <- data.frame(id = test$id, country1 = test$locn, id2 = test$id, country2 = test$locn2, 
                     id3 = test$id, country3 = test$locn3, id4 = test$id, country4 = test$locn4)
write.csv(submit, file = "submit-chk2.csv", row.names = FALSE)
# note the submission file will need to formatted so that there are only two columns.
# this can be done directly using Excel itself. (the easiest way) 
