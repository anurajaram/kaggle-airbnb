# kaggle-airbnb
Airbnb competition on Kaggle 
Dataset is available from this link:  https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/data

A description of all the files in this repository are given below:

<em>Submission 1:</em></br>
1. tree_airbnb_factorize.R 
   ctree() to create predictive model for estimating destination for airbnb users.

2. lang-subsets.R
   Predictive analysis for airbnb kaggle competition, to estimate which destination users want to travel, based on their language and       gender. 

3. s1_a.csv
  Kaggle submission Excel (.csv) file combining output from two R programs:
   <ol>
      <li>tree_airbnb_factorize.R and </li>
      <li>lang-subsets.R </li>
   </ol>
(note: s1_b is a copy of the same file)
This file gives a score of <font color="red">0.79055</font>

<hr>
<em>Submission 2:</em></br>
1. airbnb-nonUS-travelers2.R
   R program to design modified prediction tree model. A subset of the training set is used, without data from users who traveled to     “US”   or “NDF”. 

2. chk_j9.csv
   .csv Excel submission file by combining outputs of two programs:
    <ol>
         <li>airbnb-nonUS-travelers2.R and </li>
         <li>s1_a.csv</li>
    </ol>
This file gives a score of <font color="red">0.80885</font>

<hr>
<em>Submission 3:</em></br>
1. highscore_jan18.R <br />
   We assume all users have two standard destination choices NDF&US (in that order). Based on some basic segmentation,
   according to age, gender and browser language, some users may have a third location preference too.

2. submit-chk2.csv <br />
   .csv Excel submission file by formatting output of program highscore_jan18.R. <br />
   This file gives a score of <font color="red">0.83231 </font>

