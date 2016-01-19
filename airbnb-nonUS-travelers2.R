
# __________________________________________________________________
# //////////////////////////////////////////////////////////////////
#
# Author - Anupama Rajaram
# 
# Program Description - Program for AirBnB Kaggle competition
#           Using ctree() with age/ lang subset data to create
#           statistical models. use these to predict outcomes for                   
#           subset of test-data.
#           Here we are taking only travellers to non-US, non-NDF 
#           countries to create a new prediction model and create
#           new outcomes.
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

# subset datasets based on travelers not headed to destination set [US, NDF, other]
age3140 <- subset(data, (country_destination != "NDF" & country_destination != "US"
                         & country_destination != "other"))
test_age3140 <- test

# ========== recode factor variables to equalize datasets 
# from test and train subsets =========== #
age3140$gender <- factor(age3140$gender, levels = c("FEMALE", "MALE", "OTHER", 
                                              "-unknown-"))
test_age3140$gender <- factor(test_age3140$gender, levels = c("FEMALE", "MALE", "OTHER", 
                                              "-unknown-"))

age3140$signup_method <- factor(age3140$signup_method, levels = c("basic", "facebook",
                                                            "google"))
test_age3140$signup_method <- factor(test_age3140$signup_method, levels = c("basic", "facebook",
                                                            "google"))

age3140$language <- factor(age3140$language, levels = c("ca", "cs", "da", "de", "el", 
                                                  "en", "es", "fi", "fr", "hu", 
                                                  "id", "it", "ja", "ko", "nl", 
                                                  "no", "pl", "pt", "ru", "sv", 
                                                  "th", "tr", "zh"))
test_age3140$language <- factor(test_age3140$language, levels = c("ca", "cs", "da", "de", "el", 
                                                  "en", "es", "fi", "fr", "hu", 
                                                  "id", "it", "ja", "ko", "nl", 
                                                  "no", "pl", "pt", "ru", "sv", 
                                                  "th", "tr", "zh"))

age3140$affiliate_channel <- factor(age3140$affiliate_channel, 
                                 levels = c("content", "direct", "other", 
                                            "remarketing", "sem-brand", 
                                            "sem-non-brand", "seo"))
test_age3140$affiliate_channel <- factor(test_age3140$affiliate_channel, 
                                 levels = c("content", "direct", "other", 
                                            "remarketing", "sem-brand", 
                                            "sem-non-brand", "seo"))

age3140$affiliate_provider <- factor(age3140$affiliate_provider,
                                  levels = c("baidu", "bing", "craigslist", 
                                             "daum", "direct", "email-marketing"
                                             , "facebook", "facebook-open-graph",
                                             "google", "gsp", "meetup", "naver",
                                             "other", "padmapper", "vast", "yahoo",
                                             "yandex"))
test_age3140$affiliate_provider <- factor(test_age3140$affiliate_provider,
                                  levels = c("baidu", "bing", "craigslist", 
                                             "daum", "direct", "email-marketing"
                                             , "facebook", "facebook-open-graph",
                                             "google", "gsp", "meetup", "naver",
                                             "other", "padmapper", "vast", "yahoo",
                                             "yandex"))

age3140$first_affiliate_tracked <- factor(age3140$first_affiliate_tracked,
                                       levels = c("linked", "local ops", "marketing",
                                                  "omg", "product", "tracked-other",
                                                  "untracked"))
test_age3140$first_affiliate_tracked <- factor(test_age3140$first_affiliate_tracked,
                                       levels = c("linked", "local ops", "marketing",
                                                  "omg", "product", "tracked-other",
                                                  "untracked"))



# Data exploration - Display the data after transformation
head(test_age3140)


#============= Recoding incorrect values ==============#

# checking for number of NAs for each variable
sapply(test_age3140, function(x) sum(is.na(x)))
sapply(age3140, function(x) sum(is.na(x)))

# checking how many unique values under each variable
sapply(age3140, function(x) length(unique(x)))
sapply(test_age3140, function(x) length(unique(x)))


# recode missing variables
age3140$age[age3140$age >= 100] <- NA  # many users have age = 2014
test_age3140$age[test_age3140$age >= 100] <- NA 

# ================================================ #
# ======== Section 2: Predictions ================ #
# predictions based on non-US, non-NDF travelers

fml3 = country_destination ~ gender + signup_method + language + affiliate_channel+
  affiliate_provider + first_device_type + first_affiliate_tracked + signup_flow +
  signup_app 

tr_age3140 <- ctree(fml3, data = age3140)
plot(tr_age3140)
# awesome plot! :-)

# data exploration
summary(tr_age3140)

# forecast values and write to file
Pred_age40 <- predict(tr_age3140, test_age3140)
# throwing error with factor levels, only when "first_browser" is added.

submit_tstage40 <- data.frame(id = test_age3140$id, 
                              country = Pred_age40)
# unfortunately this gives only options = US, NDF. so no use!
write.csv(submit_tstage40, file = "jan9_nonUS_traveler_tree.csv", row.names = FALSE)
