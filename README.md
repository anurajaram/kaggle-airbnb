# kaggle-airbnb
Airbnb competition on Kaggle 
Dataset is available from this link:  https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/data

A description of all the files in this repository are given below:

<em>Submission 1:</em>
1. tree_airbnb_factorize.R 
   ctree() to create predictive model for estimating destination for airbnb users.

2. lang-subsets.R
   Predictive analysis for airbnb kaggle competition, to estimate which destination users want to travel, based on their language and       gender. 

3. s1_a.csv
  Kaggle submission Excel (.csv) file combining output from two R programs:
   >> tree_airbnb_factorize.R and 
   >> lang-subsets.R
(note: s1_b is a copy of the same file)
This file gives a score of 0.79055


<em>Submission 2:</em>
1. airbnb-nonUS-travelers2.R
   R program to design modified prediction tree model. A subset of the training set is used, without data from users who traveled to     “US”   or “NDF”. 

2. chk_j9.csv
   .csv Excel submission file by combining outputs of two programs:
    >> airbnb-nonUS-travelers2.R and 
    >> s1_a.csv
This file gives a score of 0.80885
