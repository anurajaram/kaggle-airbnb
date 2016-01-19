
# __________________________________________________________________
# //////////////////////////////////////////////////////////////////
#
# Author - Anupama Rajaram
# Filename - Airbnb_analy_jan4.R
#
# Program Description - Program for AirBnB Kaggle competition
#           In this program we will perform some exploratory data
#           analysis. Then we will use logistic regression to compute 
#           destination outcomes
#
# Dataset - kaggle_train_smaller.csv
#           This is a smaller subset of the training set.
#
# Note: anything commented as 'Data Exploration' is purely for 
#       debugging purposes, and can be deleted without affecting this
#       script.
# __________________________________________________________________
# //////////////////////////////////////////////////////////////////


# To clean up the memory of your current R session run the following line
rm(list=ls(all=TRUE))


#===================================================================#
#=========== Section 1: Data Management ============================#

# Load text file into local variable called 'data' - 51243 rows and 3 columns
data = read.delim(file = 'train_users_2.csv', header = TRUE, 
                  sep = ',', dec = '.')

test = read.delim(file = 'test_users.csv', header = TRUE, 
                  sep = ',', dec = '.')


# ========== recode missing variables =========== #

df$weekday <- factor(df$weekday, levels = c("Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag")) 

data$gender <- factor(data$gender, levels = c("FEMALE", "MALE", "OTHER", 
                                              "-unknown-"))

test$gender <- factor(test$gender, levels = c("FEMALE", "MALE", "OTHER", 
                                              "-unknown-"))

data$signup_method <- factor(data$signup_method, levels = c("basic", "facebook",
                                                            "google"))

test$signup_method <- factor(test$signup_method, levels = c("basic", "facebook",
                                                            "google"))


data$language <- factor(data$language, levels = c("ca", "cs", "da", "de", "el", 
                                                  "en", "es", "fi", "fr", "hu", 
                                                  "id", "it", "ja", "ko", "nl", 
                                                  "no", "pl", "pt", "ru", "sv", 
                                                  "th", "tr", "zh"))

test$language <- factor(test$language, levels = c("ca", "cs", "da", "de", "el", 
                                                  "en", "es", "fi", "fr", "hu", 
                                                  "id", "it", "ja", "ko", "nl", 
                                                  "no", "pl", "pt", "ru", "sv", 
                                                  "th", "tr", "zh"))

data$affiliate_channel <- factor(data$affiliate_channel, 
                                 levels = c("content", "direct", "other", 
                                            "remarketing", "sem-brand", 
                                            "sem-non-brand", "seo"))

test$affiliate_channel <- factor(test$affiliate_channel, 
                                 levels = c("content", "direct", "other", 
                                            "remarketing", "sem-brand", 
                                            "sem-non-brand", "seo"))


data$affiliate_provider <- factor(data$affiliate_provider,
                                  levels = c("baidu", "bing", "craigslist", 
                                             "daum", "direct", "email-marketing"
                                             , "facebook", "facebook-open-graph",
                                             "google", "gsp", "meetup", "naver",
                                             "other", "padmapper", "vast", "yahoo",
                                             "yandex"))

test$affiliate_provider <- factor(test$affiliate_provider,
                                  levels = c("baidu", "bing", "craigslist", 
                                             "daum", "direct", "email-marketing"
                                             , "facebook", "facebook-open-graph",
                                             "google", "gsp", "meetup", "naver",
                                             "other", "padmapper", "vast", "yahoo",
                                             "yandex"))

data$first_affiliate_tracked <- factor(data$first_affiliate_tracked,
                                       levels = c("linked", "local ops", "marketing",
                                                  "omg", "product", "tracked-other",
                                                  "untracked"))

test$first_affiliate_tracked <- factor(test$first_affiliate_tracked,
                                       levels = c("linked", "local ops", "marketing",
                                                  "omg", "product", "tracked-other",
                                                  "untracked"))



# interpret acct_date and f_booking as date variables
data$acct_date2 = as.Date(data$date_account_created, "%m/%d/%Y")
data$maiden_bookg = as.Date(data$date_first_booking, "%m/%d/%Y")

test$acct_date2 = as.Date(test$date_account_created, "%m/%d/%Y")
test$maiden_bookg = as.Date(test$date_first_booking, "%m/%d/%Y")



# Data exploration - Display the data after transformation
head(data)


#============= Recoding incorrect values ==============#

sapply(training.data.raw,function(x) sum(is.na(x)))

# checking for number of NAs for each variable
sapply(data, function(x) sum(is.na(x)))
sapply(test, function(x) sum(is.na(x)))

# checking how many unique values under each variable
sapply(data, function(x) length(unique(x)))
sapply(data, function(x) length(unique(x)))


data$age[data$age >= 100] <- NA  # many users have age = 2014
data$lang[data$language == "-unknown-"] <- NA 

test$age[test$age >= 100] <- NA 
test$lang[test$language == "-unknown-"] <- NA 





# first tree prediction
attach(data)
tra = tree(country_destination ~ gender + age + signup_flow,
            data = data, na.action = na.omit)

plot(tra)


Prediction <- predict(tra, test, type = "class")

submit <- data.frame(userId = test$id, country = Prediction)
write.csv(submit, file = "jan8.csv", row.names = FALSE)



#===================================================================
# new tree decision
la = c("ca", "cs", "da", "de", "el", "en", "es", "fi", "fr", "hu", "id", "it", 
       "ja", "ko", "nl", "no", "pl", "pt", "ru", "sv", "th", "tr", "zh")

la_fi <- factor(la)
as.integer(la_fi)

la_fi
l <- as.integer(la_fi)
l

test$signup_method <- as.character(test$signup_method)
data$signup_method <- as.character(data$signup_method)

test$language <- as.character(test$language)
data$language <- as.character(data$language)

test$affiliate_channel <- as.character(test$affiliate_channel)
data$affiliate_channel <- as.character(data$affiliate_channel)

test$affiliate_provider <- as.character(test$affiliate_provider)
data$affiliate_provider <- as.character(data$affiliate_provider)

test$first_device_type <- as.character(test$first_device_type)
data$first_device_type <- as.character(data$first_device_type)

data$country_destination <- as.character(data$country_destination)

#test$ <- as.character(test$)
#data$ <- as.character(data$)

tr_chn = tree(country_destination ~ language + gender + age + signup_flow
           + signup_method +affiliate_channel,
             data = data, na.action = na.omit)

plot(tr_chn)


Prediction_chn <- predict(tr_chn, test, type = "class")

submit_chn <- data.frame(id = test$id, country = Prediction_chn)
write.csv(submit_chn, file = "jan8_tree_chn.csv", row.names = FALSE)




# third tree (random forest ) prediction

set.seed(21)
rf <- randomForest(country_destination ~ age + gender + signup_method + language
                   + affiliate_provider + affiliate_channel + acct_date2 ,
                   data = data , mtry = 3, importance = TRUE)

rf <- randomForest()



# fourth tree
fml = country_destination ~ gender + age + signup_method + language +
  affiliate_provider + first_device_type

#signup_flow, signup_app, is still left.
tra = tree(fml, data = data)

plot(tra, type = "simple")
plot(tra)
summary(tra)

Prediction <- predict(tra, test, type = "class")
submit <- data.frame(userId = test$id, country = Prediction)
write.csv(submit, file = "jan8.csv", row.names = FALSE)


# iteration 6 
trc <- ctree(fml, data = data)
plot(trc)
# awesome plot! :-)

Prediction_ctree <- predict(trc, test)
submit_t1 <- data.frame(id = test$id, country = Prediction_ctree)
write.csv(submit_t1, file = "jan8_tree_plot.csv", row.names = FALSE)



# lang based decisions
d1 <- test

d1$ctry <- "US"
d1$ctry[which(d1$language == "el")] = "ES"
d1$ctry[which(d1$language == "es")] = "other"
d1$ctry[which(d1$language == "fr")] = "fr"
d1$ctry[which(d1$language == "ja")] = "other"
d1$ctry[which(d1$language == "cs")] = "other"
d1$ctry[which(d1$language == "no")] = "GB"
d1$ctry[which(d1$language == "pt")] = "other"
d1$ctry[which(d1$language == "sv")] = "other"
d1$ctry[which(d1$language == "tr")] = "other"

submit_t1$ctry <- d1$ctry

s1 <- submit_t1
s1$flag <- 0
s1$flag[which(s1$country != s1$ctry)] = 9

write.csv(s1, file = "s1.csv", row.names = FALSE)


# addition made on jan9 2016
# predictions based on age
age2130 <- subset(data, (age>20 & age<31))
agelang2130 <- subset(age2130, language == "en")

test_age2130 <- subset(test, (age>20 & age<31))
test_age2130_lang <- subset(test_age2130, language == "en")

fml = country_destination ~ gender + signup_method + language + affiliate_channel+
  affiliate_provider + first_device_type + first_affiliate_tracked

tr_age2130_lang <- ctree(fml, data = agelang2130)
plot(tr_age2130_lang)
# awesome plot! :-)

Pred_ctree <- predict(tr_age2130_lang, test_age2130_lang)
submit_tst_agelang <- data.frame(id = test_age2130_lang$id, 
                                 country = Pred_ctree)
write.csv(submit_tst_agelang, file = "jan9_agelangtree.csv", row.names = FALSE)



# predictions based on just age
# predictions based on age

fml2 = country_destination ~ gender + signup_method + language + affiliate_channel+
  affiliate_provider + first_device_type + first_affiliate_tracked

tr_age2130 <- ctree(fml2, data = age2130)
plot(tr_age2130)
# awesome plot! :-)

Pred_age <- predict(tr_age2130, test_age2130)
submit_tstage <- data.frame(id = test_age2130$id, 
                                 country = Pred_age)
write.csv(submit_tstage, file = "jan9_agetree.csv", row.names = FALSE)




# predictions based on just age group 31-40
age31400 <- subset(data, (age>30 & age<41))
test_age3140 <- subset(test, (age>30 & age<41))

fml3 = country_destination ~ gender + signup_method + language + affiliate_channel+
  affiliate_provider + first_device_type + first_affiliate_tracked + signup_flow +
  signup_app + first_browser

tr_age3140 <- ctree(fml3, data = age31400)
plot(tr_age3140)
# awesome plot! :-)

Pred_age40 <- predict(tr_age3140, test_age3140)
# throwing error with factor levels
submit_tstage40 <- data.frame(id = test_age3140$id, 
                            country = Pred_age40)
write.csv(submit_tstage, file = "jan9_age40tree.csv", row.names = FALSE)