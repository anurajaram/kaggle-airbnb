# kaggle-airbnb
Airbnb competition on Kaggle 
Dataset is available from this link:  https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/data

A description of all the files in this repository are given below:

1. tree_airbnb_factorize.R 
   ctree() to create predictive model for estimating destination for airbnb users.

2. lang-subsets.R
   Predictive analysis for airbnb kaggle competition, to estimate which destination users want to travel, based on their language and       gender. 

3. s1_a.csv
  Kaggle submission Excel (.csv) file combining output from two R programs:
   1. tree_airbnb_factorize.R and 
   2. lang-subsets.R
(note: s1_b is a copy of the same file)
This file gives a score of 0.79055

4. airbnb-nonUS-travelers2.R
   R program to design modified prediction tree model. A subset of the training set is used, without data from users who traveled to     “US”   or “NDF”. 

5. chk_j9.csv
   .csv Excel submission file by combining outputs of two programs:
    1. airbnb-nonUS-travelers2.R and 
    2. s1_a.csv
This file gives a score of 0.80885
