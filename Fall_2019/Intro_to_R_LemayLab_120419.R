#####################
#     Intro to R    #
#   Elizabeth Chin  #
#     09/27/2019    #
#####################

# Purpose: This session aims to get you:   

#* up and running with the R language and R Studio  
#* using good practices for reproducible computations and analyses  
#* reading, understanding, and manipulating dataframes  
#* variable types  
#* subsetting data  

#There are 5 main areas in the RStudio interface (on EC's computer anyways):  
  
# * Prompt/command panel aka "Console" (top right)  
# * Script area (top left)  
# * Environment, Workspace & History (bottom left)  
# * Plots, Packages, Help, Files (bottom right)  
# * Menus that bring up different dialogs  

# You can change the layout of these windows by going to the menu at the top > tools > global options > pane layout   

# We're going to use the script area to write our R commands into files and then send the commands to the prompt/command panel to execute them.  

# By putting the commands into a file, we ensure that we have them after the R session and we can reconstruct 
# what we did. We'll refine the text in the script/file so that it works.  

## Five tips for writing code  

# + annotate your code  
#   + write code for humans, not computers  
# + use new lines and indents to organize your code  
#   + no one likes a run on sentence  
#+ troubleshoot small sections of code at a time  
#   + baby steps before big steps  
#+ use the ? to get more info for functions    
#   + Dr. Google is also your friend   
#+ there can be multiple answers to the same problem  
#   + don't be afraid to try different things   
    #+ it's unlikely you're going to permanently break anything  

# Importing Data   

# First, we are going to tell R to use this as the working directory. Next, we can read in our data.  

# We are using the example ASA24-2016 ddata set, which can be downloaded from the [ASA24 researcher website.](https://epi.grants.cancer.gov/asa24/researcher/sample.html)  

# Be sure to download this file: "Sample Analysis Files and Data Dictionaries for ASA24-2016, ASA24-Canada-2016, and ASA24-Australia-2016"

# It will download as a zip folder to wherever your downloads normally live. Move the folder to the working directory and unzip it.  

# We are going to read in the file: Snow_2018-05-30_42236_Items.csv   
# We specify that the top row contains the column names using 'header = T' 

####################### 
#  let's get started  #
####################### 

#set the working directory
#You'll change the directory to wherever your data lives on your computer
setwd("/Users/elizabeth.chin/Desktop/Intro_to_R/Fall_2019/") #press CMD + ENTER (mac) or CTRL + ENTER (win) to run a line

#what's my working directory?
getwd()

#load the data
#don't forget that the data is nested in sub directories
items<- read.csv("./data/Snow_2018-05-30_42236_Items.csv", header=T)
#read-in commands for other types of data: read.delim(), read.table()-- check out ?read.csv() for more

#another way to load the data, without setting the working directory first
#items<- read.csv("/Users/elizabeth.chin/Desktop/Intro_to_R_labmeeting/ASA242016/Studies_created_after_May312018/2016Recall/Snow_2018-05-30_42236_Items.csv", header=T)

#Ideally we'd use version control (e.g. git) for the files in this RIntro directory.  
#We can talk about this later if you're interested.  

####################################
# Creating and assigning variables #
####################################

#So assignments to create or overwrite variables in R are of the form:  
#variable = value
#variable <- value
#(For completeness, you may also see `->` being used, and also a call to the assign() function.)  

#You can create new variables yourself, e.g.,  

x = 4
name = "Ebeth"
gotIt = TRUE

#Note that these variables appear in the bottom-left panel of the RStudio GUI.
#We can also list the names of the variables we have created with the `ls()` function

ls()

#We can also remove variables when we no longer need their values using `rm()`,   
#e.g.,   

rm()
rm(x, name)

#Be careful not to remove a variable you do want. 
#After a call to rm(), it is gone unless you happened to save()/saveRDS() the variable earlier. 
  
###############################
# Types of variables and data #
###############################
#Adapted from [here](https://www.statmethods.net/input/datatypes.html)

#There are many types of data structures in R, including:  
  
# * vectors (numerical, characters, logical)
# * matrices
#   * all columns must have the same mode (numeric, character,etc.) and be the same length
# * arrays
#   * similar to matrices, but can have more than 2 dimensions  
# * data frames
#   * like a matrix, but different columns can have different modes (numeric, character, factor, etc.)
# * lists
#   * ordered collection of objects (components)
#   * allows you to gather a variety of objects under one name


#R has 6 basic data types:
# * character ("a", "dog")
# * numeric (real or decimal) (2, 1.1)
# * integer (2L (L tells R to store this as an integer))
# * logical (TRUE or FALSE)
# * complex (1 + 4i)

########################
# Inspecting your data #
########################

#We assigned the datafile to an object we called `items`.
#What is it? You can see some details about it in the "Environment" panel in the bottom left panel of the 
# RStudio GUI. But that only shows you some information. We can query the object for much more information.
#You should get into the habit of doing this for objects you create.   

#The functions we use all the time for this include:  
  
# * size
#   * dim() #dimensions
#   * nrow() #n of rows
#   * ncol() #n of columns
#   * length() # n of columns
# + names
#   * names() # column names
#   * colnames()
 #  * rownames() 
# + summary
#   + str() #structure 
#   + summary() #basic statistics (mean, median...)
# + class()

#Many of these functions are generic and can be applied to different types of data (not just data frames)

#What does these functions do?
#Look them up with the help command, e.g.,

help("class")
?names
names(items)

############
# **DIY:** #
############
#############################################################################################
# ***use the functions listed above to get some summary information about 'items'***
# ***what can you tell me about the data?***  
#  ***data type:*** DATA FRAME  
#  ***dimensions:*** 51 x 130    
#  ***variable types include:***  numeric, integers, factors
#  ***how many types of Food Sources (FoodSrce) are there?*** 7
#############################################################################################

str(items)
?factor # categorical variable

#We can also glance at the data using the head() or tail() functions:   
  
head(items) #first six lines (default)
tail(items) #last six lines
head(items, n=3) #first three lines


############
# **DIY:** #
############
#############################################################################################
# ***can you show me the last four lines of 'items'?***
#############################################################################################
tail(items, n=4)

#The View() function is also an easy way to peep at your data in a new window that you can sort, filter, and search. 
#You can also double-click on the name in the Environment window.   

View(items)

########################
# Indexing data frames #
########################

#'items' is a data frame consisting of 51 rows and 130 columns. 
# We can extract specific elements from 'items' by specifying the "coordinates". 
# Row numbers come first then columns.  

#object_name[rownum, colnum]

## Extract columns: 
items[,21] #get the FoodCode column as a vector
items[21] #get the FoodCode column as a data frame, notice no comma!
items[,-21] #get every column EXCEPT column 21
items[,c(21:24)] #get columns 21:24. notice the 'c', which acts to 'concatenate' multiple items together

#we can also extract using the name
items['FoodCode'] #data frame
items[['FoodCode']] #vector
items[,'FoodCode'] #vector, notice the ,
items$FoodCode #vector
#the last three are equivalent

## Extract rows
items[1,] #get the first row
items[c(1:5),] #get the first five rows
items[-1,] #get everything EXCEPT the first row

#'items' rownames are just 1-n. We can still summon a specific row using the rowname instead of location 
#(it just so happens in this case that the rowname is the same as the row number)

rownames(items)
items['1',] #get the first row
items[,'FoodCode']# get the column named FoodCode

## Extracting specific data points  

#We can combine the indexing of rows and columns to get specific data points:  

items[1,1] #the first row and first column (vector)
items[c(1:3), 21] #the first three elements of the 21st column (vector)

############
# **DIY:** #
############
#############################################################################################
#  ***1) extract the column named "Food_Description" and assign to a dataframe called "fd"***
colnames(items)
fd<- items[130]
?write.csv #if you wanted to save your object or data frame
#example (file will show up in your working directory): write.csv(fd, "example_name.csv")

#  ***2) What is the class of 'fd'? *** 
class(fd)
#  ***3) Show me the first 5 rows of 'fd'***
fd[c(1:5),]
head(fd,n=5)
#############################################################################################

#############################################################################################
# ***extract columns 95, 119, and 1 (in that order)***
#############################################################################################  
# ***How would you get rows 6 through 10 and all columns EXCEPT the last one?***
#############################################################################################


#ereturn column names
colnames(items)
#one way to get column "CALC"
items[,37] #inconvenient because we don't always know the colun number, we don't always want to have to get it
items[, 'CALC'] #use the column name

#the preferred way/most commonly used
items$CALC #notice the drop down menu that appears
#you can use this to auto-complete your column name

## Column Summary Statistics

#We can also use the summary() function on just one column

?summary() #what does this do?
summary(items$CALC) #easy way
summary(items[,37]) #another way, but more typing :(


#summary(items[,21])
#summary(items)

#Another way to select columns in a data frame
#you will need to know the column names
#uses the $

#get the food description
items$Food_Description #preferred way to select columns
#it's easy to select the wrong column number by indexing

###RECAP###
#select columns
# 1) indexing w/ the column number (same for rows)
# 2) indexing w/ the column name (same for rows)
# 3) directly selecting the col name w/ $


############
# **DIY:** #
############
#############################################################################################
# ***can you get the summary for columns 121 to 124 from 'items'?***
# 1) use the column numbers
# 2) use the column names
#############################################################################################  

#1) summary w/ col numbers
summary(items[,c(121:124)])
#2) summary w/ column names
summary(items$D_TOTAL)
summary(items$D_CHEESE)
summary(items[,'D_TOTAL'])


# Conditiomal Subsetting

# We can return just part of the data that meet certain conditions

#Conditions can be defined using the following: 
  
# + '==' means 'equal to'
# + '!=' means 'not equal to'
# + '>' means 'greather than'
# + '>=' means 'greater than or equal to'
# + '<' means 'less than'
# + '<=' means 'less than or equal to'

#Joiners   

# + '|' means 'or'
# + '&' means 'and'

# e.g. Return all the foods (rows) in items where the value for "OILS" is 0

items$OILS == 0 #returns a logical vector
oil_items<-items[items$OILS==0,] #returns all rows in the dataframe where the vector is TRUE. Notice the comma-- it returns all the columns

#another way to return the rows of your dataframe
?subset()
subset(items, OILS==0) #another way using the subset function

#You can also use conditional subsetting on characters (i.e. not numbers)   
items$FoodSrce != "Other cafeteria" #notice the ""
subset(items, FoodSrce != "Other cafeteria")

############
# **DIY:** #
############
#############################################################################################
# ***Return all rows where the PROT value is greather than or equal to 5. How many rows are there?***
#############################################################################################
#use subset
prot<-subset(items, PROT >= 5)
dim(prot) #15 x 130
nrow(prot)#15

# Counting factors 

#Sometimes we want to know how many of a specific factor we have in our data. We can do this a few ways:   
#e.g. how many counts are there for each FOODSRC?

?table
class(items$FoodSrce) #factor; not numeric
table(items$FoodSrce)


####################### 
# The 'dplyr' package #
####################### 

# [dplyr](https://dplyr.tidyverse.org/) is an R library used for data manipulation. 
# We'll briefly cover the following functions:   
#   + select
#   + filter

# But these are just a few of many dplyr functions that are helpful for data manipulation and organization!   
# First, we need to install and load the dplyr package:   

#install the package. you'll only need to do this once
install.packages('dplyr')

#after it's installed, you need to load it. you'll do this EVERYTIME you want to use it in a single R or Rmd file 
#(not every time you want to use a specific function though)

library(dplyr)


## dplyr::select

#The 'select' function makes it easy to select columns.   
#Let's use it to select the FoodCode and Food_Description from items, and assign it to a new df called "tiny_items"

?select()

dim(items)

tiny_items<- select(items, 
                    c(FoodCode, Food_Description)) #remember the c!

#select(items, c("FoodCode", "Food_Description")) #you can also use the "" but you don't need it.

## dplyr::filter

#The 'filter' function is similar to 'subset' and  makes it easy to select certain rows from a column given a specific condition.   
#E.g. Filter tiny_items to only include FoodCodes greater than 60000000. 

?filter()
filter(tiny_items, 
       FoodCode <= 60000000) #FoodCode is numeric

#Notice that all columns are returned   

#Filter can also be used on columns of a non-numeric class   
#E.g. Filter dataframe tiny_items to only include rows where the Food_Description is "Cheerios"  

class(tiny_items$Food_Description)
filter(tiny_items,
       Food_Description != "Cheerios") #notice the ""

##
# == exact match/equal to
# != not equal to 
# | "or"
# & "and" 

# Here's an example of two rules   
filter(tiny_items, 
       Food_Description == "Cheerios" | 
         Food_Description == "Banana, raw") #case sensitive 

############
# **DIY:** #
############
#############################################################################################
#  ***1) select the columns: FoodCode, Food_Description, SUGR, and TFAT from 'items' (in that order) 
#             and assign to a new dataframe called "df"***   

df <- items[,c("FoodCode","Food_Description", "SUGR", "TFAT")]
View(df)
df <- select(items, 
             c("FoodCode", "Food_Description", "SUGR", "TFAT"))
View(df)
#check out just the column names
colnames(df)

#  ***2) filter 'df' to only include rows where the values of SUGR are greater than 4 and the FoodCode is 
#           less than or equal to 50000000. Assign to a new dataframe called 'df2'***

df2<- filter(df, 
       SUGR > "4" | 
         FoodCode <= "50000000")
View(df2)
dim(df)


#  ***3) what are the dimensions of df2? What is the median of TFAT in df2? What is the median of TFAT in df?***

dim(df2)
summary(df2)
summary(df2$TFAT)
summary(df$TFAT)
#############################################################################################