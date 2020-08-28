-   [Introduction to R](#introduction-to-r)
    -   [A Tour of the RStudio GUI (Graphical User
        Interface)](#a-tour-of-the-rstudio-gui-graphical-user-interface)
    -   [Five tips for writing code](#five-tips-for-writing-code)
-   [Importing Data](#importing-data)
-   [Creating and assigning
    variables](#creating-and-assigning-variables)
    -   [Types of variables and data](#types-of-variables-and-data)
-   [Inspecting your data](#inspecting-your-data)
-   [Indexing data frames](#indexing-data-frames)
    -   [Extract columns:](#extract-columns)
    -   [Extract rows](#extract-rows)
    -   [Extracting specific data
        points](#extracting-specific-data-points)
    -   [Column Summary Statistics](#column-summary-statistics)
-   [Conditiomal Subsetting](#conditiomal-subsetting)
-   [Counting factors](#counting-factors)
-   [The ‘dplyr’ package](#the-dplyr-package)
    -   [dplyr::select](#dplyrselect)
    -   [dplyr::filter](#dplyrfilter)
-   [Recap](#recap)

Introduction to R
=================

This session aims to get you:

-   up and running with the R language and R Studio  
-   using good practices for reproducible computations and analyses  
-   reading, understanding, and manipulating dataframes
    -   variable types  
    -   subsetting data

This is adapted from the UC Davis [DSI Introduction to R
Bootcamp.](https://github.com/dsidavis/RIntro18)

A Tour of the RStudio GUI (Graphical User Interface)
----------------------------------------------------

There are 5 main areas in the RStudio interface:

-   Prompt/command panel aka “Console” (top right… on EC’s setup. May be
    different for your computer!)  
-   Script area (top left)  
-   Environment, Workspace & History (bottom left)  
-   Plots, Packages, Help, Files (bottom right)  
-   Menus that bring up different dialogs.

You can change the layout of these windows by going to the menu at the
top &gt; tools &gt; global options &gt; pane layout

We’re going to use the script area to write our R commands into files
and then send the commands to the prompt/command panel to execute them.

By putting the commands into a file, we ensure that we have them after
the R session and we can reconstruct what we did. We’ll refine the text
in the script/file so that it works.

Open a new file by going to File &gt; New File. There are different
types of R/RStudio files.

-   R Script (.R)  
-   R markdown and R Notebook (.Rmd)

This is an R Notebook file. Some parts of the file are text (‘markdown’)
and others (‘chunks’) are code that can be executed.

Why use R Notebooks?

-   easy to organize notes from code  
-   can easily run all lines in a code chunk at once (‘play’ button)
    -   run a **single** line of code by pressing CMD + ENTER or CTRL +
        ENTER
-   can run all previous chunks of code at once (downward play button)  
-   can format the output (e.g. figures) easily

We’re not going to get into the specifics of markdown or configuring
notebooks in this session, but here are some
[resources](https://bioinformaticsworkbook.org/Appendix/Markdown.html).  
[R Markdown: The Definitive
Guide](https://bookdown.org/yihui/rmarkdown/markdown-syntax.html)  
[R Markdown
Cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)

Five tips for writing code
--------------------------

-   annotate your code
    -   write code for humans, not computers  
-   use new lines and indents to organize your code
    -   no one likes a run on sentence  
-   troubleshoot small sections of code at a time
    -   baby steps before big steps  
-   use the ? to get more info for functions
    -   Dr. Google is also your friend  
-   there can be multiple answers to the same problem
    -   don’t be afraid to try different things  
    -   it’s unlikely you’re going to permanently break anything

Importing Data
==============

First, we are going to tell R to use this as the working directory.
Next, we can read in our data.  
**note that one of the key differences between a vanilla R script and an
R markdown (Rmd) file is that the working directory is exclusive to a
specific chunk for the Rmd. For a regular .R file, the working directory
is global.**

We are using the example ASA24-2016 ddata set, which can be downloaded
from the [ASA24 researcher
website.](https://epi.grants.cancer.gov/asa24/researcher/sample.html).
We are specifically using the file Snow\_2018-05-30\_42236\_Items.csv,
which you can directly download in the /data/ folder.

We are going to read in the file: Snow\_2018-05-30\_42236\_Items.csv  
We specify that the top row contains the column names using ‘header =
T’  
**when using R markdown or R notebook, you *must* press ‘play’ to open a
file after setting the working directory. You *cannot* run this next
chunk line-by-line**

    #set the working directory
    #You'll change the directory to wherever your data lives on your computer
    setwd("/Users/elizabeth.chin/Desktop/Intro_to_R/Fall_2019/")

    #you can check your working directory with:
    getwd()

    ## [1] "/Users/elizabeth.chin/Desktop/Intro_to_R/Fall_2019"

    #load the data
    items<- read.csv("./data/Snow_2018-05-30_42236_Items.csv", header=T)
    #read-in commands for other types of data: read.delim(), read.table()-- check out ?read.csv() for more

    #another way to load the data, without setting the working directory first
    #items<- read.csv("/Users/elizabeth.chin/Desktop/Intro_to_R_labmeeting/ASA242016/Studies_created_after_May312018/2016Recall/Snow_2018-05-30_42236_Items.csv", header=T)

Ideally we’d use version control (e.g. git) for the files in this RIntro
directory.  
We can talk about this later if you’re interested.

Creating and assigning variables
================================

So assignments to create or overwrite variables in R are of the form:

    variable = value
    variable <- value

(For completeness, you may also see `->` being used, and also a call to
the assign() function.)

You can create new variables yourself, e.g.,

    x = 4
    name = "Ebeth"
    gotIt = TRUE

Note that these variables appear in the bottom-left panel of the RStudio
GUI. We can also list the names of the variables we have created with
the `ls()` function

    ls()

    ## [1] "gotIt" "items" "name"  "x"

We can also remove variables when we no longer need their values using
`rm()`,  
e.g.,

    rm(x, name)

**Be careful not to remove a variable you do want. After a call to rm(),
it is gone unless you happened to save()/saveRDS() the variable
earlier.**

Types of variables and data
---------------------------

Adapted from [here](https://www.statmethods.net/input/datatypes.html)

There are many types of data structures in R, including:

-   vectors (numerical, characters, logical)
-   matrices
    -   all columns must have the same mode (numeric, character,etc.)
        and be the same length
-   arrays
    -   similar to matrices, but can have more than 2 dimensions  
-   data frames
    -   like a matrix, but different columns can have different modes
        (numeric, character, factor, etc.)
-   lists
    -   ordered collection of objects (components)
    -   allows you to gather a variety of objects under one name

R has 6 basic data types:

-   character (“a”, “dog”)
-   numeric (real or decimal) (2, 1.1)
-   integer (2L (L tells R to store this as an integer))
-   logical (TRUE or FALSE)
-   complex (1 + 4i)

Sometimes data are called ‘fators’ – that’s basically just a categorical
variable (e.g. Male or Female; small, medium, or large)

Inspecting your data
====================

We assigned the datafile to a variable we called `items`. What is it?
You can see some details about it in the “Environment” panel in the
bottom left panel of the RStudio GUI. But that only shows you some
information. We can query the object for much more information. You
should get into the habit of doing this for objects you create.

The functions we use all the time for this include:

-   size
    -   `dim()`
    -   `nrow()`
    -   `ncol()`
    -   `length()`
-   names
    -   `names(`)
    -   `colnames()`
    -   `rownames()`
-   summary
    -   `str()`
    -   `summary()`
-   `class()`

Many of these functions are generic and can be applied to different
types of data (not just data frames)

What does these functions do? Look them up with the help command, e.g.,

    help("class")
    ?names

**DIY:** ***use the functions listed above to get some summary
information about ‘items’***

    dim(items) #get the dimensions

    ## [1]  51 130

    class(items) #what type of object/data

    ## [1] "data.frame"

    str(items) #types of variables in 'items' 

    ## 'data.frame':    51 obs. of  130 variables:
    ##  $ RecallRecId        : Factor w/ 1 level "f52ae861-cd5b-4ec2-9af1-eec184537f78": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ UserName           : Factor w/ 1 level "Snow373": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ UserID             : Factor w/ 1 level "4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ RecallNo           : int  4 4 4 4 4 4 4 4 4 4 ...
    ##  $ RecallAttempt      : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ RecallStatus       : int  2 2 2 2 2 2 2 2 2 2 ...
    ##  $ IntakeStartDateTime: Factor w/ 1 level "05/20/2018 0:00": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ IntakeEndDateTime  : Factor w/ 1 level "05/20/2018 23:59": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ ReportingDate      : Factor w/ 1 level "05/21/2018": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Lang               : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Occ_No             : int  1 1 1 1 1 1 1 1 2 2 ...
    ##  $ Occ_Time           : Factor w/ 8 levels "05/20/2018 11:00",..: 1 1 1 1 1 1 1 1 2 2 ...
    ##  $ Occ_Name           : int  1 1 1 1 1 1 1 1 6 6 ...
    ##  $ EatWith            : int  4 4 4 4 4 4 4 4 1 1 ...
    ##  $ WatchTVuseComputer : int  1 1 1 1 1 1 1 1 4 4 ...
    ##  $ Location           : int  1 1 1 1 1 1 1 1 6 6 ...
    ##  $ FoodNum            : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ FoodType           : int  1 2 2 1 1 1 2 2 1 1 ...
    ##  $ FoodSrce           : Factor w/ 7 levels "","Fast food or drive-thru restaurant",..: 6 6 6 6 6 6 6 6 4 4 ...
    ##  $ CodeNum            : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ FoodCode           : int  57123000 11112110 63107010 32131000 61210220 92101000 12210200 91101010 94100100 91746100 ...
    ##  $ ModCode            : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ HowMany            : num  1 1 8 6 9.6 ...
    ##  $ SubCode            : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ PortionCode        : int  10205 10205 61935 61009 30000 30000 63480 22000 30000 61538 ...
    ##  $ FoodAmt            : num  28 244 48 678 299 ...
    ##  $ KCAL               : num  105.8 122 42.7 1240.7 146.3 ...
    ##  $ PROT               : num  3.385 8.052 0.523 79.326 2.03 ...
    ##  $ TFAT               : num  1.884 4.831 0.158 93.835 0.358 ...
    ##  $ CARB               : num  20.5 11.7 11 17.6 34.5 ...
    ##  $ MOIS               : num  1.44 217.67 35.96 473.79 260.4 ...
    ##  $ ALC                : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ CAFF               : num  0 0 0 0 0 ...
    ##  $ THEO               : num  0 0 0 0 0 ...
    ##  $ SUGR               : num  1.22 12.35 5.87 11.39 24.81 ...
    ##  $ FIBE               : num  2.632 0 1.248 2.034 0.896 ...
    ##  $ CALC               : num  112.3 292.8 2.4 691.6 32.8 ...
    ##  $ IRON               : num  9.2876 0.0488 0.1248 7.3902 0.3881 ...
    ##  $ MAGN               : num  35.8 26.8 13 101.7 32.8 ...
    ##  $ PHOS               : num  134.7 224.5 10.6 1213.6 50.8 ...
    ##  $ POTA               : num  179 342 172 1451 531 ...
    ##  $ SODI               : num  139.16 114.68 0.48 2922.18 5.97 ...
    ##  $ ZINC               : num  4.684 1.171 0.072 9.017 0.209 ...
    ##  $ COPP               : num  0.1078 0.0146 0.0374 0.4407 0.1254 ...
    ##  $ SELE               : num  6.972 6.1 0.48 130.176 0.299 ...
    ##  $ VC                 : num  6.048 0.488 4.176 23.73 100.316 ...
    ##  $ VB1                : num  0.3716 0.0952 0.0149 0.7458 0.1373 ...
    ##  $ VB2                : num  0.397 0.451 0.035 1.939 0.116 ...
    ##  $ NIAC               : num  5.871 0.224 0.319 8.211 0.836 ...
    ##  $ VB6                : num  0.6692 0.0927 0.1762 1.0441 0.2269 ...
    ##  $ FOLA               : num  199.9 12.2 9.6 142.4 56.7 ...
    ##  $ FA                 : num  195 0 0 0 0 ...
    ##  $ FF                 : num  5.32 12.2 9.6 142.38 56.73 ...
    ##  $ FDFE               : num  336.3 12.2 9.6 142.4 56.7 ...
    ##  $ VB12               : num  1.9 1.29 0 4.2 0 ...
    ##  $ VARA               : num  277.2 134.2 1.44 759.36 5.97 ...
    ##  $ RET                : num  277 134 0 685 0 ...
    ##  $ BCAR               : num  0 9.76 12.48 779.7 23.88 ...
    ##  $ ACAR               : num  0 0 12 162.7 23.9 ...
    ##  $ CRYP               : num  0 0 0 27.1 80.6 ...
    ##  $ LYCO               : num  0 0 0 4183 0 ...
    ##  $ LZ                 : num  41.7 0 10.6 1715.3 80.6 ...
    ##  $ ATOC               : num  0.182 0.0732 0.048 7.458 0.5971 ...
    ##  $ VK                 : num  0.504 0.488 0.24 40.002 0 ...
    ##  $ CHOLE              : num  0 19.5 0 1274.6 0 ...
    ##  $ SFAT               : num  0.42 3.0671 0.0538 32.6457 0.0418 ...
    ##  $ S040               : num  0 0.188 0 0.617 0 ...
    ##  $ S060               : num  0 0.0976 0 0.3187 0 ...
    ##  $ S080               : num  0 0.0488 0 0.1898 0 ...
    ##  $ S100               : num  0 0.11956 0.00048 0.40002 0 ...
    ##  $ S120               : num  0 0.1342 0.00096 0.35256 0 ...
    ##  $ S140               : num  0.00504 0.427 0.00096 2.3391 0 ...
    ##  $ S160               : num  0.3688 1.3615 0.049 19.4857 0.0418 ...
    ##  $ S180               : num  0.0364 0.5929 0.0024 8.0072 0 ...
    ##  $ MFAT               : num  0.6653 1.3664 0.0154 35.7984 0.0657 ...
    ##  $ M161               : num  0.00308 0.06588 0.0048 1.82382 0.00896 ...
    ##  $ M181               : num  0.6488 1.2395 0.0106 33.1881 0.0537 ...
    ##  $ M201               : num  0.0126 0.00488 0 0.41358 0 ...
    ##  $ M221               : num  0.00056 0 0 0.00678 0 0 0 0 0 0 ...
    ##  $ PFAT               : num  0.681 0.1781 0.035 19.6213 0.0896 ...
    ##  $ P182               : num  0.6597 0.1513 0.0221 16.5907 0.0687 ...
    ##  $ P183               : num  0.019 0.0195 0.013 1.7492 0.0209 ...
    ##  $ P184               : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ P204               : num  0 0 0 0.658 0 ...
    ##  $ P205               : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ P225               : num  0 0 0 0.0407 0 ...
    ##  $ P226               : num  0 0 0 0.176 0 ...
    ##  $ VITD               : num  0.952 2.928 0 8.814 0 ...
    ##  $ CHOLN              : num  7.34 40.02 4.7 871.23 18.51 ...
    ##  $ VITE_ADD           : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ B12_ADD            : num  1.9 0 0 0 0 ...
    ##  $ F_TOTAL            : num  0 0 0.322 0 1.194 ...
    ##  $ F_CITMLB           : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ F_OTHER            : num  0 0 0.322 0 0 ...
    ##  $ F_JUICE            : num  0 0 0 0 1.19 ...
    ##  $ V_TOTAL            : num  0 0 0 1.08 0 ...
    ##  $ V_DRKGR            : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ V_REDOR_TOTAL      : num  0 0 0 1.08 0 ...
    ##  $ V_REDOR_TOMATO     : num  0 0 0 1.08 0 ...
    ##   [list output truncated]

***what can you tell me about the data?***  
***data type:***  
***dimensions:***  
***variable types include:***  
***how many types of Food Sources (FoodSrce) are there?***

We can also glance at the data using the `head()` or `tail()` functions:

    head(items) #first ten lines (default)

    ##                            RecallRecId UserName
    ## 1 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 2 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 3 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 4 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 5 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 6 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                 UserID RecallNo RecallAttempt RecallStatus
    ## 1 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 2 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 3 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 4 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 5 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 6 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ##   IntakeStartDateTime IntakeEndDateTime ReportingDate Lang Occ_No
    ## 1     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 3     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 4     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 5     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 6     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ##           Occ_Time Occ_Name EatWith WatchTVuseComputer Location FoodNum
    ## 1 05/20/2018 11:00        1       4                  1        1       1
    ## 2 05/20/2018 11:00        1       4                  1        1       2
    ## 3 05/20/2018 11:00        1       4                  1        1       3
    ## 4 05/20/2018 11:00        1       4                  1        1       4
    ## 5 05/20/2018 11:00        1       4                  1        1       5
    ## 6 05/20/2018 11:00        1       4                  1        1       6
    ##   FoodType               FoodSrce CodeNum FoodCode ModCode HowMany SubCode
    ## 1        1 Other store (any type)       1 57123000       0     1.0       0
    ## 2        2 Other store (any type)       2 11112110       0     1.0       0
    ## 3        2 Other store (any type)       3 63107010       0     8.0       0
    ## 4        1 Other store (any type)       4 32131000       0     6.0       0
    ## 5        1 Other store (any type)       5 61210220       0     9.6       0
    ## 6        1 Other store (any type)       6 92101000       0    12.0       0
    ##   PortionCode FoodAmt      KCAL      PROT      TFAT     CARB     MOIS ALC
    ## 1       10205   28.00  105.8400  3.385200  1.884400 20.50440   1.4364   0
    ## 2       10205  244.00  122.0000  8.052000  4.831200 11.71200 217.6724   0
    ## 3       61935   48.00   42.7200  0.523200  0.158400 10.96320  35.9568   0
    ## 4       61009  678.00 1240.7400 79.326000 93.835200 17.62800 473.7864   0
    ## 5       30000  298.56  146.2944  2.030208  0.358272 34.45382 260.4040   0
    ## 6       30000  355.20    3.5520  0.426240  0.071040  0.00000 353.0333   0
    ##     CAFF THEO     SUGR    FIBE     CALC     IRON     MAGN      PHOS
    ## 1   0.00    0  1.22080 2.63200 112.2800 9.287600  35.8400  134.6800
    ## 2   0.00    0 12.34640 0.00000 292.8000 0.048800  26.8400  224.4800
    ## 3   0.00    0  5.87040 1.24800   2.4000 0.124800  12.9600   10.5600
    ## 4   0.00    0 11.39040 2.03400 691.5600 7.390200 101.7000 1213.6200
    ## 5   0.00    0 24.81034 0.89568  32.8416 0.388128  32.8416   50.7552
    ## 6 142.08    0  0.00000 0.00000   7.1040 0.035520  10.6560   10.6560
    ##        POTA      SODI     ZINC      COPP      SELE       VC       VB1
    ## 1  179.4800  139.1600 4.684400 0.1078000   6.97200   6.0480 0.3715600
    ## 2  341.6000  114.6800 1.171200 0.0146400   6.10000   0.4880 0.0951600
    ## 3  171.8400    0.4800 0.072000 0.0374400   0.48000   4.1760 0.0148800
    ## 4 1450.9200 2922.1800 9.017400 0.4407000 130.17600  23.7300 0.7458000
    ## 5  531.4368    5.9712 0.208992 0.1253952   0.29856 100.3162 0.1373376
    ## 6  174.0480    7.1040 0.071040 0.0071040   0.00000   0.0000 0.0497280
    ##         VB2     NIAC       VB6     FOLA    FA       FF     FDFE   VB12
    ## 1 0.3967600 5.870760 0.6692000 199.9200 194.6   5.3200 336.2800 1.8956
    ## 2 0.4514000 0.224480 0.0927200  12.2000   0.0  12.2000  12.2000 1.2932
    ## 3 0.0350400 0.319200 0.1761600   9.6000   0.0   9.6000   9.6000 0.0000
    ## 4 1.9390800 8.210580 1.0441200 142.3800   0.0 142.3800 142.3800 4.2036
    ## 5 0.1164384 0.835968 0.2269056  56.7264   0.0  56.7264  56.7264 0.0000
    ## 6 0.2699520 0.678432 0.0035520   7.1040   0.0   7.1040   7.1040 0.0000
    ##       VARA    RET     BCAR     ACAR    CRYP    LYCO        LZ    ATOC
    ## 1 277.2000 277.20   0.0000   0.0000  0.0000    0.00   41.7200 0.18200
    ## 2 134.2000 134.20   9.7600   0.0000  0.0000    0.00    0.0000 0.07320
    ## 3   1.4400   0.00  12.4800  12.0000  0.0000    0.00   10.5600 0.04800
    ## 4 759.3600 684.78 779.7000 162.7200 27.1200 4183.26 1715.3400 7.45800
    ## 5   5.9712   0.00  23.8848  23.8848 80.6112    0.00   80.6112 0.59712
    ## 6   0.0000   0.00   0.0000   0.0000  0.0000    0.00    0.0000 0.03552
    ##        VK   CHOLE       SFAT    S040    S060    S080    S100    S120
    ## 1  0.5040    0.00  0.4200000 0.00000 0.00000 0.00000 0.00000 0.00000
    ## 2  0.4880   19.52  3.0670800 0.18788 0.09760 0.04880 0.11956 0.13420
    ## 3  0.2400    0.00  0.0537600 0.00000 0.00000 0.00000 0.00048 0.00096
    ## 4 40.0020 1274.64 32.6457000 0.61698 0.31866 0.18984 0.40002 0.35256
    ## 5  0.0000    0.00  0.0417984 0.00000 0.00000 0.00000 0.00000 0.00000
    ## 6  0.3552    0.00  0.0071040 0.00000 0.00000 0.00000 0.00000 0.00000
    ##      S140       S160    S180       MFAT      M161       M181    M201
    ## 1 0.00504  0.3687600 0.03640  0.6652800 0.0030800  0.6487600 0.01260
    ## 2 0.42700  1.3615200 0.59292  1.3664000 0.0658800  1.2395200 0.00488
    ## 3 0.00096  0.0489600 0.00240  0.0153600 0.0048000  0.0105600 0.00000
    ## 4 2.33910 19.4857200 8.00718 35.7984000 1.8238200 33.1881000 0.41358
    ## 5 0.00000  0.0417984 0.00000  0.0656832 0.0089568  0.0537408 0.00000
    ## 6 0.00000  0.0071040 0.00000  0.0532800 0.0000000  0.0000000 0.00000
    ##      M221      PFAT       P182      P183 P184    P204 P205    P225    P226
    ## 1 0.00056  0.680960  0.6596800 0.0190400    0 0.00000    0 0.00000 0.00000
    ## 2 0.00000  0.178120  0.1512800 0.0195200    0 0.00000    0 0.00000 0.00000
    ## 3 0.00000  0.035040  0.0220800 0.0129600    0 0.00000    0 0.00000 0.00000
    ## 4 0.00678 19.621320 16.5906600 1.7492400    0 0.65766    0 0.04068 0.17628
    ## 5 0.00000  0.089568  0.0686688 0.0208992    0 0.00000    0 0.00000 0.00000
    ## 6 0.00000  0.003552  0.0035520 0.0000000    0 0.00000    0 0.00000 0.00000
    ##    VITD     CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE
    ## 1 0.952   7.33600        0  1.8956 0.00000        0  0.0000 0.00000
    ## 2 2.928  40.01600        0  0.0000 0.00000        0  0.0000 0.00000
    ## 3 0.000   4.70400        0  0.0000 0.32160        0  0.3216 0.00000
    ## 4 8.814 871.23000        0  0.0000 0.00000        0  0.0000 0.00000
    ## 5 0.000  18.51072        0  0.0000 1.19424        0  0.0000 1.19424
    ## 6 0.000   9.23520        0  0.0000 0.00000        0  0.0000 0.00000
    ##   V_TOTAL V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER
    ## 1  0.0000       0        0.0000         0.0000             0
    ## 2  0.0000       0        0.0000         0.0000             0
    ## 3  0.0000       0        0.0000         0.0000             0
    ## 4  1.0848       0        1.0848         1.0848             0
    ## 5  0.0000       0        0.0000         0.0000             0
    ## 6  0.0000       0        0.0000         0.0000             0
    ##   V_STARCHY_TOTAL V_STARCHY_POTATO V_STARCHY_OTHER V_OTHER V_LEGUMES
    ## 1               0                0               0       0         0
    ## 2               0                0               0       0         0
    ## 3               0                0               0       0         0
    ## 4               0                0               0       0         0
    ## 5               0                0               0       0         0
    ## 6               0                0               0       0         0
    ##   G_TOTAL G_WHOLE G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT
    ## 1  0.9184  0.9184         0   0.0000       0.0000       0       0.0000
    ## 2  0.0000  0.0000         0   0.0000       0.0000       0       0.0000
    ## 3  0.0000  0.0000         0   0.0000       0.0000       0       0.0000
    ## 4  0.0000  0.0000         0   9.3564       3.3222       0       3.3222
    ## 5  0.0000  0.0000         0   0.0000       0.0000       0       0.0000
    ## 6  0.0000  0.0000         0   0.0000       0.0000       0       0.0000
    ##   PF_ORGAN PF_POULT PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS
    ## 1        0        0           0            0  0.0000      0         0
    ## 2        0        0           0            0  0.0000      0         0
    ## 3        0        0           0            0  0.0000      0         0
    ## 4        0        0           0            0  6.0342      0         0
    ## 5        0        0           0            0  0.0000      0         0
    ## 6        0        0           0            0  0.0000      0         0
    ##   PF_LEGUMES D_TOTAL D_MILK D_YOGURT D_CHEESE    OILS SOLID_FATS
    ## 1          0  0.0000 0.0000        0   0.0000  0.0000     0.0000
    ## 2          0  1.0004 1.0004        0   0.0000  0.0000     3.3428
    ## 3          0  0.0000 0.0000        0   0.0000  0.0000     0.0000
    ## 4          0  1.6272 0.4068        0   1.2204 20.4756    45.9684
    ## 5          0  0.0000 0.0000        0   0.0000  0.0000     0.0000
    ## 6          0  0.0000 0.0000        0   0.0000  0.0000     0.0000
    ##   ADD_SUGARS A_DRINKS FoodComp
    ## 1     0.1988        0        1
    ## 2     0.0000        0        1
    ## 3     0.0000        0        1
    ## 4     0.0000        0        1
    ## 5     0.0000        0        1
    ## 6     0.0000        0        1
    ##                                                                     Food_Description
    ## 1                                                                           Cheerios
    ## 2                                                         Milk, cow's, fluid, 2% fat
    ## 3                                                                        Banana, raw
    ## 4 Egg omelet or scrambled egg, with cheese, meat, and tomatoes, fat added in cooking
    ## 5                                       Orange juice, canned, bottled or in a carton
    ## 6                                                  Coffee, made from ground, regular

    tail(items) #last ten lines

    ##                             RecallRecId UserName
    ## 46 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 47 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 49 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 50 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 51 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 46 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 47 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 49 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 50 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 51 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 46            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 47            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 49            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 50            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 51            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No        Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 46      8 05/21/2018 3:00        6       3                  5        1
    ## 47      8 05/21/2018 3:00        6       3                  5        1
    ## 48      8 05/21/2018 3:00        6       3                  5        1
    ## 49      8 05/21/2018 3:00        6       3                  5        1
    ## 50      8 05/21/2018 3:00        6       3                  5        1
    ## 51      8 05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType               FoodSrce CodeNum FoodCode ModCode
    ## 46      29        1 Other store (any type)      46 51301010       0
    ## 47      29        1 Other store (any type)      47 83107000       0
    ## 48      29        1 Other store (any type)      48 25230210       0
    ## 49      29        1 Other store (any type)      49 14410130       0
    ## 50      29        1 Other store (any type)      50 14104110       0
    ## 51      29        1 Other store (any type)      51 14106200       0
    ##     HowMany SubCode PortionCode  FoodAmt      KCAL     PROT     TFAT
    ## 46  1.50000       0       64355 42.00000 113.40000 4.355400 1.444800
    ## 47  0.75000       0       21000 10.35000  70.38000 0.099360 7.746975
    ## 48  1.50000       0       62008 42.00000  55.02000 7.110600 1.470000
    ## 49 15.94687       0          98 15.94687  20.09306 3.356817 0.000000
    ## 50 15.94687       0          98 15.94687  49.27584 4.361470 3.254757
    ## 51 15.94687       0          98 15.94687  59.48184 3.903795 4.828714
    ##          CARB      MOIS ALC CAFF THEO       SUGR  FIBE     CALC       IRON
    ## 46 20.7732000 14.502600   0    0    0 2.55360000 1.764  57.9600 1.47840000
    ## 47  0.0589950  2.240775   0    0    0 0.05899500 0.000   0.8280 0.02173500
    ## 48  0.4074000 31.512600   0    0    0 0.00000000 0.000   2.1000 0.24360000
    ## 49  1.6792059 10.440419   0    0    0 0.83880562 0.000 125.8208 0.00000000
    ## 50  0.6474431  7.062871   0    0    0 0.04146187 0.000 121.3557 0.01913625
    ## 51  0.1084387  6.539813   0    0    0 0.07973437 0.000 118.9637 0.11481750
    ##         MAGN      PHOS      POTA      SODI      ZINC        COPP      SELE
    ## 46 19.320000  64.26000  76.44000 217.98000 0.4956000 0.067620000 12.096000
    ## 47  0.103500   2.17350   2.07000  65.72250 0.0155250 0.001966500  0.238050
    ## 48  7.560000 109.62000 194.04000 551.88000 0.6594000 0.072660000 13.272000
    ## 49 18.338906  50.39213  62.67122 209.86087 0.6554166 0.089143031  2.328244
    ## 50  4.305656  82.92375  10.04653 100.14637 0.7080412 0.006857156  5.708981
    ## 51  4.305656  70.80412  12.91697  95.68125 0.4784062 0.005103000  2.312297
    ##       VC         VB1        VB2       NIAC        VB6      FOLA  FA
    ## 46 0.084 0.197820000 0.11340000 2.49186000 0.04494000 35.700000 8.4
    ## 47 0.000 0.001035000 0.00196650 0.00000000 0.00082800  0.517500 0.0
    ## 48 0.000 0.141120000 0.11172000 2.39274000 0.16548000  0.000000 0.0
    ## 49 0.000 0.065701125 0.08691047 0.88664625 0.09041878  1.435219 0.0
    ## 50 0.000 0.003348844 0.06330909 0.02312297 0.01339537  3.189375 0.0
    ## 51 0.000 0.002392031 0.06219281 0.01483059 0.01259803  2.870437 0.0
    ##           FF      FDFE      VB12     VARA       RET       BCAR ACAR
    ## 46 27.300000 41.580000 0.0000000  0.00000  0.000000  0.4200000    0
    ## 47  0.517500  0.517500 0.0124200  1.65600  1.552500  0.6210000    0
    ## 48  0.840000  0.840000 0.1512000  0.00000  0.000000  0.0000000    0
    ## 49  1.435219  1.435219 0.2950172  8.93025  8.770781  0.4784062    0
    ## 50  3.189375  3.189375 0.2248509 23.12297 22.644562  4.4651250    0
    ## 51  2.870437  2.870437 0.1323591 31.57481 30.618000 12.4385625    0
    ##         CRYP LYCO        LZ       ATOC          VK     CHOLE     SFAT
    ## 46 0.0000000    0 18.480000 0.07980000  2.05800000  0.000000 0.337260
    ## 47 0.4140000    0  1.242000 0.33948000 16.87050000  4.347000 1.211260
    ## 48 0.0000000    0  0.000000 0.12180000  0.00000000 17.220000 0.467460
    ## 49 0.0000000    0  0.000000 0.04305656  0.03189375  4.146187 0.000000
    ## 50 0.1594687    0  0.637875 0.07654500  0.23920312 12.119625 2.009625
    ## 51 0.0000000    0  0.000000 0.04146187  0.39867188 14.192719 3.040431
    ##          S040       S060       S080       S100       S120      S140
    ## 46 0.00336000 0.00042000 0.00210000 0.01428000 0.00546000 0.0058800
    ## 47 0.00000000 0.00000000 0.00000000 0.00000000 0.00000000 0.0056925
    ## 48 0.00000000 0.00168000 0.00000000 0.00000000 0.00000000 0.0189000
    ## 49 0.00000000 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000
    ## 50 0.07000678 0.05756822 0.03635887 0.08978091 0.10221947 0.3269109
    ## 51 0.15659831 0.03891037 0.04879744 0.08978091 0.06346856 0.5761606
    ##         S160      S180      MFAT       M161     M181       M201
    ## 46 0.1936200 0.1003800 0.2696400 0.00924000 0.252420 0.00714000
    ## 47 0.8185815 0.3207465 1.7432505 0.00910800 1.703092 0.02463300
    ## 48 0.3057600 0.1411200 0.7077000 0.04452000 0.653100 0.01008000
    ## 49 0.0000000 0.0000000 0.0000000 0.00000000 0.000000 0.00000000
    ## 50 0.9183805 0.3442930 0.8458222 0.05214628 0.747749 0.00637875
    ## 51 1.2379559 0.5458615 1.3955110 0.14718966 1.174966 0.00000000
    ##            M221      PFAT      P182       P183 P184        P204
    ## 46 0.0000000000 0.6757800 0.6102600 0.06342000    0 0.001260000
    ## 47 0.0022770000 4.6254150 4.0516110 0.56469600    0 0.005175000
    ## 48 0.0000000000 0.1470000 0.1344000 0.00672000    0 0.005460000
    ## 49 0.0000000000 0.0000000 0.0000000 0.00000000    0 0.000000000
    ## 50 0.0003189375 0.1424056 0.1184853 0.01020600    0 0.005581406
    ## 51 0.0000000000 0.1433624 0.1015816 0.04162134    0 0.000000000
    ##            P205        P225      P226       VITD     CHOLN VITE_ADD
    ## 46 0.0008400000 0.000000000 0.0000000 0.00000000  7.854000        0
    ## 47 0.0000000000 0.000000000 0.0005175 0.02070000  3.539700        0
    ## 48 0.0000000000 0.000000000 0.0000000 0.29400000 26.208000        0
    ## 49 0.0000000000 0.000000000 0.0000000 0.01594687  6.123600        0
    ## 50 0.0009568125 0.001594687 0.0000000 0.04784062  2.455819        0
    ## 51 0.0000000000 0.000000000 0.0000000 0.09568125  2.455819        0
    ##    B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE V_TOTAL V_DRKGR V_REDOR_TOTAL
    ## 46       0       0        0       0       0       0       0             0
    ## 47       0       0        0       0       0       0       0             0
    ## 48       0       0        0       0       0       0       0             0
    ## 49       0       0        0       0       0       0       0             0
    ## 50       0       0        0       0       0       0       0             0
    ## 51       0       0        0       0       0       0       0             0
    ##    V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL V_STARCHY_POTATO
    ## 46              0             0               0                0
    ## 47              0             0               0                0
    ## 48              0             0               0                0
    ## 49              0             0               0                0
    ## 50              0             0               0                0
    ## 51              0             0               0                0
    ##    V_STARCHY_OTHER V_OTHER V_LEGUMES G_TOTAL G_WHOLE G_REFINED PF_TOTAL
    ## 46               0       0         0   1.491  0.4158    1.0752 0.000000
    ## 47               0       0         0   0.000  0.0000    0.0000 0.015525
    ## 48               0       0         0   0.000  0.0000    0.0000 1.482600
    ## 49               0       0         0   0.000  0.0000    0.0000 0.000000
    ## 50               0       0         0   0.000  0.0000    0.0000 0.000000
    ## 51               0       0         0   0.000  0.0000    0.0000 0.000000
    ##    PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT PF_SEAFD_HI
    ## 46       0.0000       0       0.0000        0        0           0
    ## 47       0.0000       0       0.0000        0        0           0
    ## 48       1.4826       0       1.4826        0        0           0
    ## 49       0.0000       0       0.0000        0        0           0
    ## 50       0.0000       0       0.0000        0        0           0
    ## 51       0.0000       0       0.0000        0        0           0
    ##    PF_SEAFD_LOW  PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES   D_TOTAL D_MILK
    ## 46            0 0.000000      0         0          0 0.0000000      0
    ## 47            0 0.015525      0         0          0 0.0000000      0
    ## 48            0 0.000000      0         0          0 0.0000000      0
    ## 49            0 0.000000      0         0          0 0.3747516      0
    ## 50            0 0.000000      0         0          0 0.3747516      0
    ## 51            0 0.000000      0         0          0 0.3747516      0
    ##    D_YOGURT  D_CHEESE   OILS SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 46        0 0.0000000 1.2012   0.000000     0.5376        0        1
    ## 47        0 0.0000000 7.5555   0.044505     0.0000        0        1
    ## 48        0 0.0000000 0.0000   0.000000     0.0000        0        1
    ## 49        0 0.3747516 0.0000   0.000000     0.0000        0        1
    ## 50        0 0.3747516 0.0000   2.691832     0.0000        0        1
    ## 51        0 0.3747516 0.0000   4.265789     0.0000        0        1
    ##                                   Food_Description
    ## 46                   Bread, wheat or cracked wheat
    ## 47                             Mayonnaise, regular
    ## 48 Ham, sliced, prepackaged or deli, luncheon meat
    ## 49            Cheese, American, nonfat or fat free
    ## 50                    Cheese, Cheddar, reduced fat
    ## 51                                Cheese, Monterey

    head(items, n=3) #first three lines

    ##                            RecallRecId UserName
    ## 1 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 2 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 3 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                 UserID RecallNo RecallAttempt RecallStatus
    ## 1 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 2 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 3 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ##   IntakeStartDateTime IntakeEndDateTime ReportingDate Lang Occ_No
    ## 1     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 3     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ##           Occ_Time Occ_Name EatWith WatchTVuseComputer Location FoodNum
    ## 1 05/20/2018 11:00        1       4                  1        1       1
    ## 2 05/20/2018 11:00        1       4                  1        1       2
    ## 3 05/20/2018 11:00        1       4                  1        1       3
    ##   FoodType               FoodSrce CodeNum FoodCode ModCode HowMany SubCode
    ## 1        1 Other store (any type)       1 57123000       0       1       0
    ## 2        2 Other store (any type)       2 11112110       0       1       0
    ## 3        2 Other store (any type)       3 63107010       0       8       0
    ##   PortionCode FoodAmt   KCAL   PROT   TFAT    CARB     MOIS ALC CAFF THEO
    ## 1       10205      28 105.84 3.3852 1.8844 20.5044   1.4364   0    0    0
    ## 2       10205     244 122.00 8.0520 4.8312 11.7120 217.6724   0    0    0
    ## 3       61935      48  42.72 0.5232 0.1584 10.9632  35.9568   0    0    0
    ##      SUGR  FIBE   CALC   IRON  MAGN   PHOS   POTA   SODI   ZINC    COPP
    ## 1  1.2208 2.632 112.28 9.2876 35.84 134.68 179.48 139.16 4.6844 0.10780
    ## 2 12.3464 0.000 292.80 0.0488 26.84 224.48 341.60 114.68 1.1712 0.01464
    ## 3  5.8704 1.248   2.40 0.1248 12.96  10.56 171.84   0.48 0.0720 0.03744
    ##    SELE    VC     VB1     VB2    NIAC     VB6   FOLA    FA    FF   FDFE
    ## 1 6.972 6.048 0.37156 0.39676 5.87076 0.66920 199.92 194.6  5.32 336.28
    ## 2 6.100 0.488 0.09516 0.45140 0.22448 0.09272  12.20   0.0 12.20  12.20
    ## 3 0.480 4.176 0.01488 0.03504 0.31920 0.17616   9.60   0.0  9.60   9.60
    ##     VB12   VARA   RET  BCAR ACAR CRYP LYCO    LZ   ATOC    VK CHOLE
    ## 1 1.8956 277.20 277.2  0.00    0    0    0 41.72 0.1820 0.504  0.00
    ## 2 1.2932 134.20 134.2  9.76    0    0    0  0.00 0.0732 0.488 19.52
    ## 3 0.0000   1.44   0.0 12.48   12    0    0 10.56 0.0480 0.240  0.00
    ##      SFAT    S040   S060   S080    S100    S120    S140    S160    S180
    ## 1 0.42000 0.00000 0.0000 0.0000 0.00000 0.00000 0.00504 0.36876 0.03640
    ## 2 3.06708 0.18788 0.0976 0.0488 0.11956 0.13420 0.42700 1.36152 0.59292
    ## 3 0.05376 0.00000 0.0000 0.0000 0.00048 0.00096 0.00096 0.04896 0.00240
    ##      MFAT    M161    M181    M201    M221    PFAT    P182    P183 P184
    ## 1 0.66528 0.00308 0.64876 0.01260 0.00056 0.68096 0.65968 0.01904    0
    ## 2 1.36640 0.06588 1.23952 0.00488 0.00000 0.17812 0.15128 0.01952    0
    ## 3 0.01536 0.00480 0.01056 0.00000 0.00000 0.03504 0.02208 0.01296    0
    ##   P204 P205 P225 P226  VITD  CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB
    ## 1    0    0    0    0 0.952  7.336        0  1.8956  0.0000        0
    ## 2    0    0    0    0 2.928 40.016        0  0.0000  0.0000        0
    ## 3    0    0    0    0 0.000  4.704        0  0.0000  0.3216        0
    ##   F_OTHER F_JUICE V_TOTAL V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO
    ## 1  0.0000       0       0       0             0              0
    ## 2  0.0000       0       0       0             0              0
    ## 3  0.3216       0       0       0             0              0
    ##   V_REDOR_OTHER V_STARCHY_TOTAL V_STARCHY_POTATO V_STARCHY_OTHER V_OTHER
    ## 1             0               0                0               0       0
    ## 2             0               0                0               0       0
    ## 3             0               0                0               0       0
    ##   V_LEGUMES G_TOTAL G_WHOLE G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT
    ## 1         0  0.9184  0.9184         0        0            0       0
    ## 2         0  0.0000  0.0000         0        0            0       0
    ## 3         0  0.0000  0.0000         0        0            0       0
    ##   PF_CUREDMEAT PF_ORGAN PF_POULT PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS PF_SOY
    ## 1            0        0        0           0            0       0      0
    ## 2            0        0        0           0            0       0      0
    ## 3            0        0        0           0            0       0      0
    ##   PF_NUTSDS PF_LEGUMES D_TOTAL D_MILK D_YOGURT D_CHEESE OILS SOLID_FATS
    ## 1         0          0  0.0000 0.0000        0        0    0     0.0000
    ## 2         0          0  1.0004 1.0004        0        0    0     3.3428
    ## 3         0          0  0.0000 0.0000        0        0    0     0.0000
    ##   ADD_SUGARS A_DRINKS FoodComp           Food_Description
    ## 1     0.1988        0        1                   Cheerios
    ## 2     0.0000        0        1 Milk, cow's, fluid, 2% fat
    ## 3     0.0000        0        1                Banana, raw

**DIY:** ***can you show me the last four lines of ‘items’?***

    tail(items, n = 4)

    ##                             RecallRecId UserName
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 49 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 50 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 51 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 49 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 50 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 51 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 49            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 50            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 51            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No        Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 48      8 05/21/2018 3:00        6       3                  5        1
    ## 49      8 05/21/2018 3:00        6       3                  5        1
    ## 50      8 05/21/2018 3:00        6       3                  5        1
    ## 51      8 05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType               FoodSrce CodeNum FoodCode ModCode
    ## 48      29        1 Other store (any type)      48 25230210       0
    ## 49      29        1 Other store (any type)      49 14410130       0
    ## 50      29        1 Other store (any type)      50 14104110       0
    ## 51      29        1 Other store (any type)      51 14106200       0
    ##     HowMany SubCode PortionCode  FoodAmt     KCAL     PROT     TFAT
    ## 48  1.50000       0       62008 42.00000 55.02000 7.110600 1.470000
    ## 49 15.94687       0          98 15.94687 20.09306 3.356817 0.000000
    ## 50 15.94687       0          98 15.94687 49.27584 4.361470 3.254757
    ## 51 15.94687       0          98 15.94687 59.48184 3.903795 4.828714
    ##         CARB      MOIS ALC CAFF THEO       SUGR FIBE     CALC       IRON
    ## 48 0.4074000 31.512600   0    0    0 0.00000000    0   2.1000 0.24360000
    ## 49 1.6792059 10.440419   0    0    0 0.83880562    0 125.8208 0.00000000
    ## 50 0.6474431  7.062871   0    0    0 0.04146187    0 121.3557 0.01913625
    ## 51 0.1084387  6.539813   0    0    0 0.07973437    0 118.9637 0.11481750
    ##         MAGN      PHOS      POTA      SODI      ZINC        COPP      SELE
    ## 48  7.560000 109.62000 194.04000 551.88000 0.6594000 0.072660000 13.272000
    ## 49 18.338906  50.39213  62.67122 209.86087 0.6554166 0.089143031  2.328244
    ## 50  4.305656  82.92375  10.04653 100.14637 0.7080412 0.006857156  5.708981
    ## 51  4.305656  70.80412  12.91697  95.68125 0.4784062 0.005103000  2.312297
    ##    VC         VB1        VB2       NIAC        VB6     FOLA FA       FF
    ## 48  0 0.141120000 0.11172000 2.39274000 0.16548000 0.000000  0 0.840000
    ## 49  0 0.065701125 0.08691047 0.88664625 0.09041878 1.435219  0 1.435219
    ## 50  0 0.003348844 0.06330909 0.02312297 0.01339537 3.189375  0 3.189375
    ## 51  0 0.002392031 0.06219281 0.01483059 0.01259803 2.870437  0 2.870437
    ##        FDFE      VB12     VARA       RET       BCAR ACAR      CRYP LYCO
    ## 48 0.840000 0.1512000  0.00000  0.000000  0.0000000    0 0.0000000    0
    ## 49 1.435219 0.2950172  8.93025  8.770781  0.4784062    0 0.0000000    0
    ## 50 3.189375 0.2248509 23.12297 22.644562  4.4651250    0 0.1594687    0
    ## 51 2.870437 0.1323591 31.57481 30.618000 12.4385625    0 0.0000000    0
    ##          LZ       ATOC         VK     CHOLE     SFAT       S040       S060
    ## 48 0.000000 0.12180000 0.00000000 17.220000 0.467460 0.00000000 0.00168000
    ## 49 0.000000 0.04305656 0.03189375  4.146187 0.000000 0.00000000 0.00000000
    ## 50 0.637875 0.07654500 0.23920312 12.119625 2.009625 0.07000678 0.05756822
    ## 51 0.000000 0.04146187 0.39867188 14.192719 3.040431 0.15659831 0.03891037
    ##          S080       S100       S120      S140      S160      S180
    ## 48 0.00000000 0.00000000 0.00000000 0.0189000 0.3057600 0.1411200
    ## 49 0.00000000 0.00000000 0.00000000 0.0000000 0.0000000 0.0000000
    ## 50 0.03635887 0.08978091 0.10221947 0.3269109 0.9183805 0.3442930
    ## 51 0.04879744 0.08978091 0.06346856 0.5761606 1.2379559 0.5458615
    ##         MFAT       M161     M181       M201         M221      PFAT
    ## 48 0.7077000 0.04452000 0.653100 0.01008000 0.0000000000 0.1470000
    ## 49 0.0000000 0.00000000 0.000000 0.00000000 0.0000000000 0.0000000
    ## 50 0.8458222 0.05214628 0.747749 0.00637875 0.0003189375 0.1424056
    ## 51 1.3955110 0.14718966 1.174966 0.00000000 0.0000000000 0.1433624
    ##         P182       P183 P184        P204         P205        P225 P226
    ## 48 0.1344000 0.00672000    0 0.005460000 0.0000000000 0.000000000    0
    ## 49 0.0000000 0.00000000    0 0.000000000 0.0000000000 0.000000000    0
    ## 50 0.1184853 0.01020600    0 0.005581406 0.0009568125 0.001594687    0
    ## 51 0.1015816 0.04162134    0 0.000000000 0.0000000000 0.000000000    0
    ##          VITD     CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE
    ## 48 0.29400000 26.208000        0       0       0        0       0       0
    ## 49 0.01594687  6.123600        0       0       0        0       0       0
    ## 50 0.04784062  2.455819        0       0       0        0       0       0
    ## 51 0.09568125  2.455819        0       0       0        0       0       0
    ##    V_TOTAL V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER
    ## 48       0       0             0              0             0
    ## 49       0       0             0              0             0
    ## 50       0       0             0              0             0
    ## 51       0       0             0              0             0
    ##    V_STARCHY_TOTAL V_STARCHY_POTATO V_STARCHY_OTHER V_OTHER V_LEGUMES
    ## 48               0                0               0       0         0
    ## 49               0                0               0       0         0
    ## 50               0                0               0       0         0
    ## 51               0                0               0       0         0
    ##    G_TOTAL G_WHOLE G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT
    ## 48       0       0         0   1.4826       1.4826       0       1.4826
    ## 49       0       0         0   0.0000       0.0000       0       0.0000
    ## 50       0       0         0   0.0000       0.0000       0       0.0000
    ## 51       0       0         0   0.0000       0.0000       0       0.0000
    ##    PF_ORGAN PF_POULT PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS
    ## 48        0        0           0            0       0      0         0
    ## 49        0        0           0            0       0      0         0
    ## 50        0        0           0            0       0      0         0
    ## 51        0        0           0            0       0      0         0
    ##    PF_LEGUMES   D_TOTAL D_MILK D_YOGURT  D_CHEESE OILS SOLID_FATS
    ## 48          0 0.0000000      0        0 0.0000000    0   0.000000
    ## 49          0 0.3747516      0        0 0.3747516    0   0.000000
    ## 50          0 0.3747516      0        0 0.3747516    0   2.691832
    ## 51          0 0.3747516      0        0 0.3747516    0   4.265789
    ##    ADD_SUGARS A_DRINKS FoodComp
    ## 48          0        0        1
    ## 49          0        0        1
    ## 50          0        0        1
    ## 51          0        0        1
    ##                                   Food_Description
    ## 48 Ham, sliced, prepackaged or deli, luncheon meat
    ## 49            Cheese, American, nonfat or fat free
    ## 50                    Cheese, Cheddar, reduced fat
    ## 51                                Cheese, Monterey

The `View()` function is also an easy way to peep at your data in a new
window that you can sort, filter, and search. You can also double-click
on the name in the Environment window.

    View(items)

Indexing data frames
====================

`items` is a data frame consisting of 51 row sand 130 columns. We can
extract specific elements from `items` by specifying the “coordinates”.
Row numbers come first then columns.

Extract columns:
----------------

    items[,21] #get the FoodCode column as a vector

    ##  [1] 57123000 11112110 63107010 32131000 61210220 92101000 12210200
    ##  [8] 91101010 94100100 91746100 58106725 92410310 13110120 21501000
    ## [15] 51320500 75506010 75117020 14104100 75113080 72116000 14104100
    ## [22] 14010000 75117020 75122100 43102000 51185000 83112500 93101000
    ## [29] 71201015 75113000 27345310 27116100 56205002 92302000 91104200
    ## [36] 75205033 75216111 81103080 91745020 53206020 13110100 11111000
    ## [43] 63223020 91302010 91101000 51301010 83107000 25230210 14410130
    ## [50] 14104110 14106200

    items[21] #get the FoodCode column as a data frame

    ##    FoodCode
    ## 1  57123000
    ## 2  11112110
    ## 3  63107010
    ## 4  32131000
    ## 5  61210220
    ## 6  92101000
    ## 7  12210200
    ## 8  91101010
    ## 9  94100100
    ## 10 91746100
    ## 11 58106725
    ## 12 92410310
    ## 13 13110120
    ## 14 21501000
    ## 15 51320500
    ## 16 75506010
    ## 17 75117020
    ## 18 14104100
    ## 19 75113080
    ## 20 72116000
    ## 21 14104100
    ## 22 14010000
    ## 23 75117020
    ## 24 75122100
    ## 25 43102000
    ## 26 51185000
    ## 27 83112500
    ## 28 93101000
    ## 29 71201015
    ## 30 75113000
    ## 31 27345310
    ## 32 27116100
    ## 33 56205002
    ## 34 92302000
    ## 35 91104200
    ## 36 75205033
    ## 37 75216111
    ## 38 81103080
    ## 39 91745020
    ## 40 53206020
    ## 41 13110100
    ## 42 11111000
    ## 43 63223020
    ## 44 91302010
    ## 45 91101000
    ## 46 51301010
    ## 47 83107000
    ## 48 25230210
    ## 49 14410130
    ## 50 14104110
    ## 51 14106200

    items[,-21] #get every column EXCEPT column 21

    ##                             RecallRecId UserName
    ## 1  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 2  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 3  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 4  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 5  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 6  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 7  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 8  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 9  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 10 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 11 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 12 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 13 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 14 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 15 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 16 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 17 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 18 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 19 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 20 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 21 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 22 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 23 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 24 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 25 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 26 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 27 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 28 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 29 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 30 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 31 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 32 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 33 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 34 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 35 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 36 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 37 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 38 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 39 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 40 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 41 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 42 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 43 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 44 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 45 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 46 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 47 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 49 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 50 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 51 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 1  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 2  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 3  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 4  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 5  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 6  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 7  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 8  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 9  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 10 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 11 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 12 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 13 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 14 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 15 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 16 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 17 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 18 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 19 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 20 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 21 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 22 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 23 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 24 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 25 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 26 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 27 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 28 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 29 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 30 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 31 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 32 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 33 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 34 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 35 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 36 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 37 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 38 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 39 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 40 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 41 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 42 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 43 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 44 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 45 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 46 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 47 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 49 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 50 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 51 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 1             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 2             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 3             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 4             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 5             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 6             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 7             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 8             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 9             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 10            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 11            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 12            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 13            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 14            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 15            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 16            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 17            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 18            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 19            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 20            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 21            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 22            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 23            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 24            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 25            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 26            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 27            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 28            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 29            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 30            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 31            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 32            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 33            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 34            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 35            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 36            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 37            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 38            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 39            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 40            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 41            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 42            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 43            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 44            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 45            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 46            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 47            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 49            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 50            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 51            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No         Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 1       1 05/20/2018 11:00        1       4                  1        1
    ## 2       1 05/20/2018 11:00        1       4                  1        1
    ## 3       1 05/20/2018 11:00        1       4                  1        1
    ## 4       1 05/20/2018 11:00        1       4                  1        1
    ## 5       1 05/20/2018 11:00        1       4                  1        1
    ## 6       1 05/20/2018 11:00        1       4                  1        1
    ## 7       1 05/20/2018 11:00        1       4                  1        1
    ## 8       1 05/20/2018 11:00        1       4                  1        1
    ## 9       2 05/20/2018 14:00        6       1                  4        6
    ## 10      2 05/20/2018 14:00        6       1                  4        6
    ## 11      3 05/20/2018 17:00        3       2                  3        3
    ## 12      3 05/20/2018 17:00        3       2                  3        3
    ## 13      3 05/20/2018 17:00        3       2                  3        3
    ## 14      3 05/20/2018 17:00        3       2                  3        3
    ## 15      3 05/20/2018 17:00        3       2                  3        3
    ## 16      3 05/20/2018 17:00        3       2                  3        3
    ## 17      3 05/20/2018 17:00        3       2                  3        3
    ## 18      3 05/20/2018 17:00        3       2                  3        3
    ## 19      3 05/20/2018 17:00        3       2                  3        3
    ## 20      3 05/20/2018 17:00        3       2                  3        3
    ## 21      3 05/20/2018 17:00        3       2                  3        3
    ## 22      3 05/20/2018 17:00        3       2                  3        3
    ## 23      3 05/20/2018 17:00        3       2                  3        3
    ## 24      3 05/20/2018 17:00        3       2                  3        3
    ## 25      3 05/20/2018 17:00        3       2                  3        3
    ## 26      3 05/20/2018 17:00        3       2                  3        3
    ## 27      3 05/20/2018 17:00        3       2                  3        3
    ## 28      4 05/20/2018 19:30        6       1                  2        7
    ## 29      4 05/20/2018 19:30        6       1                  2        7
    ## 30      5 05/20/2018 22:00        5       1                  6        1
    ## 31      5 05/20/2018 22:00        5       1                  6        1
    ## 32      5 05/20/2018 22:00        5       1                  6        1
    ## 33      5 05/20/2018 22:00        5       1                  6        1
    ## 34      5 05/20/2018 22:00        5       1                  6        1
    ## 35      5 05/20/2018 22:00        5       1                  6        1
    ## 36      5 05/20/2018 22:00        5       1                  6        1
    ## 37      5 05/20/2018 22:00        5       1                  6        1
    ## 38      5 05/20/2018 22:00        5       1                  6        1
    ## 39      6  05/21/2018 0:00        6       1                  4       98
    ## 40      6  05/21/2018 0:00        6       1                  4       98
    ## 41      7  05/21/2018 2:00        7       1                  4        1
    ## 42      7  05/21/2018 2:00        7       1                  4        1
    ## 43      7  05/21/2018 2:00        7       1                  4        1
    ## 44      7  05/21/2018 2:00        7       1                  4        1
    ## 45      7  05/21/2018 2:00        7       1                  4        1
    ## 46      8  05/21/2018 3:00        6       3                  5        1
    ## 47      8  05/21/2018 3:00        6       3                  5        1
    ## 48      8  05/21/2018 3:00        6       3                  5        1
    ## 49      8  05/21/2018 3:00        6       3                  5        1
    ## 50      8  05/21/2018 3:00        6       3                  5        1
    ## 51      8  05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType                           FoodSrce CodeNum ModCode
    ## 1        1        1             Other store (any type)       1       0
    ## 2        2        2             Other store (any type)       2       0
    ## 3        3        2             Other store (any type)       3       0
    ## 4        4        1             Other store (any type)       4       0
    ## 5        5        1             Other store (any type)       5       0
    ## 6        6        1             Other store (any type)       6       0
    ## 7        7        2             Other store (any type)       7       0
    ## 8        8        2             Other store (any type)       8       0
    ## 9        9        1                    Other cafeteria       9       0
    ## 10      10        1                    Other cafeteria      10       0
    ## 11      11        1                                         11       0
    ## 12      12        1                                         12       0
    ## 13      13        1                                         13       0
    ## 14      14        1                                         14       0
    ## 15      14        1                                         15       0
    ## 16      14        1                                         16       0
    ## 17      14        1                                         17       0
    ## 18      14        1                                         18       0
    ## 19      15        1                                         19       0
    ## 20      15        1                                         20       0
    ## 21      15        1                                         21       0
    ## 22      15        1                                         22       0
    ## 23      15        1                                         23       0
    ## 24      15        1                                         24       0
    ## 25      15        1                                         25       0
    ## 26      15        1                                         26       0
    ## 27      15        1                                         27       0
    ## 28      16        1             Other store (any type)      28       0
    ## 29      17        1                              Other      29       0
    ## 30      18        1    Other restaurant, bar or tavern      30       0
    ## 31      19        1    Other restaurant, bar or tavern      31       0
    ## 32      20        1    Other restaurant, bar or tavern      32       0
    ## 33      20        1    Other restaurant, bar or tavern      33       0
    ## 34      21        1    Other restaurant, bar or tavern      34       0
    ## 35      22        2    Other restaurant, bar or tavern      35       0
    ## 36      23        1    Other restaurant, bar or tavern      36  200058
    ## 37      24        1    Other restaurant, bar or tavern      37       0
    ## 38      25        2    Other restaurant, bar or tavern      38       0
    ## 39      26        1                        Other: Gift      39       0
    ## 40      27        1                        Other: Gift      40       0
    ## 41      28        1 Fast food or drive-thru restaurant      41       0
    ## 42      28        1 Fast food or drive-thru restaurant      42       0
    ## 43      28        1 Fast food or drive-thru restaurant      43       0
    ## 44      28        1 Fast food or drive-thru restaurant      44       0
    ## 45      28        1 Fast food or drive-thru restaurant      45       0
    ## 46      29        1             Other store (any type)      46       0
    ## 47      29        1             Other store (any type)      47       0
    ## 48      29        1             Other store (any type)      48       0
    ## 49      29        1             Other store (any type)      49       0
    ## 50      29        1             Other store (any type)      50       0
    ## 51      29        1             Other store (any type)      51       0
    ##     HowMany SubCode PortionCode   FoodAmt       KCAL        PROT
    ## 1   1.00000       0       10205  28.00000  105.84000  3.38520000
    ## 2   1.00000       0       10205 244.00000  122.00000  8.05200000
    ## 3   8.00000       0       61935  48.00000   42.72000  0.52320000
    ## 4   6.00000       0       61009 678.00000 1240.74000 79.32600000
    ## 5   9.60000       0       30000 298.56000  146.29440  2.03020800
    ## 6  12.00000       0       30000 355.20000    3.55200  0.42624000
    ## 7  12.00000       0       63480  30.00000   40.80000  0.30000000
    ## 8   2.00000       0       22000   8.40000   32.50800  0.00000000
    ## 9  10.14000       0       30000 300.14400    0.00000  0.00000000
    ## 10  1.00000       0       61538  48.00000  236.16000  2.07840000
    ## 11  2.00000       0       64369 204.00000  497.76000 22.48080000
    ## 12 24.00000       0       30000 736.80000  272.61600  0.51576000
    ## 13  2.00000       0       61396 240.00000  597.60000  8.40000000
    ## 14  2.00000       0       64195 158.00000  388.68000 36.75080000
    ## 15  2.00000       0       60847 104.00000  283.92000  8.94400000
    ## 16  4.00000       0       22000  20.00000   13.40000  0.87400000
    ## 17  4.00000       0       61401  56.00000   22.40000  0.61600000
    ## 18 85.05000       0          98  85.05000  342.75150 21.17745000
    ## 19  1.25000       0       10205  25.00000    6.25000  0.64500000
    ## 20  1.25000       0       10346  58.75000   11.16250  0.81662500
    ## 21  0.25000       0       10010  28.25000  113.84750  7.03425000
    ## 22  0.12500       0       10205  14.12500   47.74250  3.20920000
    ## 23  0.15625       0       10010  25.00000   10.00000  0.27500000
    ## 24  0.31250       0       10010  46.56250    9.31250  0.40043750
    ## 25  0.15625       0       10111  22.50000  131.40000  4.67550000
    ## 26  0.15750       0       10205   6.30000   29.29500  0.68040000
    ## 27  2.00000       0       21000  29.40000  123.77400  0.38808000
    ## 28 16.00000       0       30000 480.00000  206.40000  2.20800000
    ## 29  4.00000       0       10247 100.00000  542.00000  6.56000000
    ## 30  1.00000       0       10160  55.00000    7.70000  0.49500000
    ## 31  1.50000       0       10205 325.50000  416.64000 32.90805000
    ## 32  1.00000       0       10205 236.00000  247.80000 14.91520000
    ## 33  1.50000       0       10043 244.50000  366.75000  6.35700000
    ## 34  9.60000       0       30000 284.16000    2.84160  0.00000000
    ## 35  2.00000       0       22000   8.20000   31.16000  0.00984000
    ## 36  0.50000       0       10029  79.00000   36.34000  0.98750000
    ## 37  2.00000       0       61345 200.00000  190.00000  6.78000000
    ## 38  0.66660       0       21000   9.53238   50.80759  0.01620505
    ## 39  5.00000 1000179       61667  10.00000   39.40000  0.00000000
    ## 40  2.00000       0       61238  60.00000  294.00000  3.48000000
    ## 41  2.25000       0       61396 270.00000  558.90000  9.45000000
    ## 42  0.37500       0       10205  91.50000   55.81500  2.88225000
    ## 43  3.00000       0       61241  36.00000   11.52000  0.24120000
    ## 44  1.50000       0       21000  31.50000   95.76000  0.09450000
    ## 45  0.75000       0       22000   3.15000   12.19050  0.00000000
    ## 46  1.50000       0       64355  42.00000  113.40000  4.35540000
    ## 47  0.75000       0       21000  10.35000   70.38000  0.09936000
    ## 48  1.50000       0       62008  42.00000   55.02000  7.11060000
    ## 49 15.94687       0          98  15.94687   20.09306  3.35681719
    ## 50 15.94687       0          98  15.94687   49.27584  4.36147031
    ## 51 15.94687       0          98  15.94687   59.48184  3.90379500
    ##           TFAT        CARB       MOIS   ALC    CAFF    THEO        SUGR
    ## 1   1.88440000 20.50440000   1.436400  0.00   0.000  0.0000  1.22080000
    ## 2   4.83120000 11.71200000 217.672400  0.00   0.000  0.0000 12.34640000
    ## 3   0.15840000 10.96320000  35.956800  0.00   0.000  0.0000  5.87040000
    ## 4  93.83520000 17.62800000 473.786400  0.00   0.000  0.0000 11.39040000
    ## 5   0.35827200 34.45382400 260.404032  0.00   0.000  0.0000 24.81033600
    ## 6   0.07104000  0.00000000 353.033280  0.00 142.080  0.0000  0.00000000
    ## 7   2.99100000  3.41400000  23.181000  0.00   0.000  0.0000  3.41400000
    ## 8   0.00000000  8.39832000   0.001680  0.00   0.000  0.0000  8.38320000
    ## 9   0.00000000  0.00000000 300.083971  0.00   0.000  0.0000  0.00000000
    ## 10 10.14240000 34.17120000   0.816000  0.00   6.720 68.6400 30.56640000
    ## 11 22.23600000 51.77520000 102.816000  0.00   0.000  0.0000  7.60920000
    ## 12  0.14736000 70.43808000 665.404080  0.00  58.944  0.0000 66.09096000
    ## 13 38.88000000 53.49600000 137.280000  0.00   0.000  0.0000 49.56000000
    ## 14 25.75400000  0.00000000  91.956000  0.00   0.000  0.0000  0.00000000
    ## 15  6.55200000 47.84000000  38.480000  0.00   0.000  0.0000  1.69520000
    ## 16  0.80200000  1.06600000  16.530000  0.00   0.000  0.0000  0.17200000
    ## 17  0.05600000  5.23040000  49.901600  0.00   0.000  0.0000  2.37440000
    ## 18 28.18557000  1.08864000  31.255875  0.00   0.000  0.0000  0.44226000
    ## 19  0.16500000  0.91250000  22.927500  0.00   0.000  0.0000  0.51250000
    ## 20  0.15862500  2.22075000  54.913625  0.00   0.000  0.0000  0.41712500
    ## 21  9.36205000  0.36160000  10.381875  0.00   0.000  0.0000  0.14690000
    ## 22  3.62730000  0.53957500   6.097762  0.00   0.000  0.0000  0.35171250
    ## 23  0.02500000  2.33500000  22.277500  0.00   0.000  0.0000  1.06000000
    ## 24  0.07915625  2.16050000  43.717531  0.00   0.000  0.0000  1.11750000
    ## 25 11.57850000  4.50000000   1.064250  0.00   0.000  0.0000  0.58950000
    ## 26  1.15290000  4.00050000   0.226800  0.00   0.000  0.0000  0.27783000
    ## 27 13.09476000  1.68756000  13.479900  0.00   0.000  0.0000  1.37886000
    ## 28  0.00000000 17.04000000 441.408000 18.72   0.000  0.0000  0.00000000
    ## 29 36.40000000 50.81000000   2.280000  0.00   0.000  0.0000  0.37000000
    ## 30  0.07700000  1.63350000  52.602000  0.00   0.000  0.0000  1.08350000
    ## 31 20.14845000 26.20275000 242.399850  0.00   0.000  0.0000  4.75230000
    ## 32 14.06560000 16.26040000 188.894400  0.00   0.000  0.0000  3.46920000
    ## 33  7.45725000 66.55290000 161.663400  0.00   0.000  0.0000  0.12225000
    ## 34  0.00000000  0.85248000 283.307520  0.00  56.832  5.6832  0.00000000
    ## 35  0.00000000  8.04338000   0.109880  0.00   0.000  0.0000  7.95564000
    ## 36  2.20410000  3.25480000  71.732000  0.00   0.000  0.0000  1.00330000
    ## 37  2.98000000 41.72000000 145.960000  0.00   0.000  0.0000  9.02000000
    ## 38  5.70131648  0.08197847   3.582268  0.00   0.000  0.0000  0.00000000
    ## 39  0.02000000  9.80000000   0.130000  0.00   0.000  0.0000  6.29000000
    ## 40 16.90800000 35.58600000   3.084000  0.00   8.400 66.6000 24.63600000
    ## 41 29.70000000 63.72000000 164.700000  0.00   0.000  0.0000 57.29400000
    ## 42  2.97375000  4.39200000  80.638950  0.00   0.000  0.0000  4.62075000
    ## 43  0.10800000  2.76480000  32.742000  0.00   0.000  0.0000  1.76040000
    ## 44  0.00000000 25.95600000   5.386500  0.00   0.000  0.0000 25.86780000
    ## 45  0.00000000  3.14937000   0.000630  0.00   0.000  0.0000  3.14370000
    ## 46  1.44480000 20.77320000  14.502600  0.00   0.000  0.0000  2.55360000
    ## 47  7.74697500  0.05899500   2.240775  0.00   0.000  0.0000  0.05899500
    ## 48  1.47000000  0.40740000  31.512600  0.00   0.000  0.0000  0.00000000
    ## 49  0.00000000  1.67920594  10.440419  0.00   0.000  0.0000  0.83880562
    ## 50  3.25475719  0.64744312   7.062871  0.00   0.000  0.0000  0.04146187
    ## 51  4.82871375  0.10843875   6.539813  0.00   0.000  0.0000  0.07973437
    ##         FIBE      CALC       IRON        MAGN        PHOS        POTA
    ## 1  2.6320000 112.28000 9.28760000  35.8400000  134.680000  179.480000
    ## 2  0.0000000 292.80000 0.04880000  26.8400000  224.480000  341.600000
    ## 3  1.2480000   2.40000 0.12480000  12.9600000   10.560000  171.840000
    ## 4  2.0340000 691.56000 7.39020000 101.7000000 1213.620000 1450.920000
    ## 5  0.8956800  32.84160 0.38812800  32.8416000   50.755200  531.436800
    ## 6  0.0000000   7.10400 0.03552000  10.6560000   10.656000  174.048000
    ## 7  0.0000000   2.70000 0.00900000   0.0000000   19.200000   57.300000
    ## 8  0.0000000   0.08400 0.00420000   0.0000000    0.000000    0.168000
    ## 9  0.0000000  30.01440 0.00000000   6.0028800    0.000000    0.000000
    ## 10 1.3440000  50.40000 0.53280000  21.1200000   70.080000  125.280000
    ## 11 4.4880000 244.80000 3.79440000  46.9200000  373.320000  375.360000
    ## 12 0.0000000  14.73600 0.81048000   0.0000000   73.680000   14.736000
    ## 13 0.0000000 280.80000 0.81600000  26.4000000  252.000000  376.800000
    ## 14 0.0000000  50.56000 3.91840000  31.6000000  311.260000  504.020000
    ## 15 3.9520000 183.04000 3.69200000  37.4400000  108.160000  119.600000
    ## 16 0.6600000  11.60000 0.30200000   9.8000000   21.200000   27.600000
    ## 17 0.9520000  12.88000 0.11760000   5.6000000   16.240000   81.760000
    ## 18 0.0000000 613.21050 0.57834000  23.8140000  435.456000   83.349000
    ## 19 0.4000000  40.00000 0.36500000  11.7500000   13.000000   92.250000
    ## 20 1.8212500  36.42500 0.52875000  11.7500000   20.562500  192.112500
    ## 21 0.0000000 203.68250 0.19210000   7.9100000  144.640000   27.685000
    ## 22 0.0000000 134.18750 0.09181250   4.0962500   85.173750   20.763750
    ## 23 0.4250000   5.75000 0.05250000   2.5000000    7.250000   36.500000
    ## 24 0.7915625   4.65625 0.15831250   4.6562500    9.312500   81.484375
    ## 25 1.9350000  17.55000 1.18125000  73.1250000  148.500000  145.125000
    ## 26 0.3150000   6.04800 0.17766000   2.6460000    8.820000   11.403000
    ## 27 0.0000000   8.23200 0.08820000   1.4700000   53.802000   18.816000
    ## 28 0.0000000  19.20000 0.09600000  28.8000000   67.200000  129.600000
    ## 29 4.4000000  24.00000 1.61000000  70.0000000  155.000000 1642.000000
    ## 30 0.6600000   9.90000 0.22550000   3.8500000   11.000000   77.550000
    ## 31 3.9060000  71.61000 1.95300000  58.5900000  318.990000  732.375000
    ## 32 4.0120000  77.88000 2.59600000  49.5600000  148.680000  531.000000
    ## 33 0.9780000  24.45000 2.83620000  29.3400000  102.690000   83.130000
    ## 34 0.0000000   0.00000 0.05683200   8.5248000    2.841600  105.139200
    ## 35 0.0000000   6.80600 0.05822000   0.7380000    0.328000   10.906000
    ## 36 1.8960000  30.02000 0.67150000  10.2700000   16.590000   82.160000
    ## 37 4.8000000   6.00000 0.90000000  52.0000000  154.000000  434.000000
    ## 38 0.0000000   2.00180 0.00000000   0.1906476    1.525181    2.859714
    ## 39 0.0000000   0.30000 0.03000000   0.3000000    0.300000    0.500000
    ## 40 1.6200000  25.20000 1.31400000  31.2000000   66.600000  114.600000
    ## 41 1.8900000 345.60000 0.24300000  37.8000000  283.500000  537.300000
    ## 42 0.0000000 103.39500 0.02745000   9.1500000   76.860000  120.780000
    ## 43 0.7200000   5.76000 0.14760000   4.6800000    8.640000   55.080000
    ## 44 0.0630000   1.89000 0.13230000   0.6300000    1.260000   16.380000
    ## 45 0.0000000   0.03150 0.00157500   0.0000000    0.000000    0.063000
    ## 46 1.7640000  57.96000 1.47840000  19.3200000   64.260000   76.440000
    ## 47 0.0000000   0.82800 0.02173500   0.1035000    2.173500    2.070000
    ## 48 0.0000000   2.10000 0.24360000   7.5600000  109.620000  194.040000
    ## 49 0.0000000 125.82084 0.00000000  18.3389062   50.392125   62.671219
    ## 50 0.0000000 121.35572 0.01913625   4.3056563   82.923750   10.046531
    ## 51 0.0000000 118.96369 0.11481750   4.3056563   70.804125   12.916969
    ##           SODI       ZINC        COPP       SELE           VC          VB1
    ## 1   139.160000 4.68440000 0.107800000   6.972000   6.04800000 0.3715600000
    ## 2   114.680000 1.17120000 0.014640000   6.100000   0.48800000 0.0951600000
    ## 3     0.480000 0.07200000 0.037440000   0.480000   4.17600000 0.0148800000
    ## 4  2922.180000 9.01740000 0.440700000 130.176000  23.73000000 0.7458000000
    ## 5     5.971200 0.20899200 0.125395200   0.298560 100.31616000 0.1373376000
    ## 6     7.104000 0.07104000 0.007104000   0.000000   0.00000000 0.0497280000
    ## 7    20.100000 0.00600000 0.000000000   0.330000   0.00000000 0.0000000000
    ## 8     0.084000 0.00084000 0.000588000   0.050400   0.00000000 0.0000000000
    ## 9     6.002880 0.00000000 0.021010080   0.000000   0.00000000 0.0000000000
    ## 10   29.280000 0.77280000 0.165120000   1.584000   0.24000000 0.0379200000
    ## 11 1201.560000 2.52960000 0.281520000  47.124000   0.20400000 0.5222400000
    ## 12   29.472000 0.14736000 0.007368000   0.736800   0.00000000 0.0000000000
    ## 13  146.400000 1.12800000 0.019200000   8.400000   0.00000000 0.0984000000
    ## 14  646.220000 9.32200000 0.112180000  30.652000   0.00000000 0.0679400000
    ## 15  544.960000 0.93600000 0.156000000  34.320000   0.00000000 0.4503200000
    ## 16  227.000000 0.12800000 0.017000000   6.580000   0.30000000 0.0686000000
    ## 17    2.240000 0.09520000 0.021840000   0.280000   4.14400000 0.0257600000
    ## 18  528.160500 2.64505500 0.026365500  11.821950   0.00000000 0.0229635000
    ## 19    6.750000 0.11750000 0.019000000   0.075000   3.75000000 0.0110000000
    ## 20   14.687500 0.28200000 0.086362500   0.176250   6.75625000 0.0417125000
    ## 21  175.432500 0.87857500 0.008757500   3.926750   0.00000000 0.0076275000
    ## 22  115.260000 0.38702500 0.004520000   2.090500   0.00000000 0.0040962500
    ## 23    1.000000 0.04250000 0.009750000   0.125000   1.85000000 0.0115000000
    ## 24    1.396875 0.06053125 0.030731250   0.000000  37.43625000 0.0265406250
    ## 25    2.025000 1.12500000 0.405000000  11.925000   0.31500000 0.3330000000
    ## 26   68.607000 0.05922000 0.010584000   1.814400   0.00000000 0.0318780000
    ## 27  264.894000 0.04998000 0.005586000   1.029000   0.00000000 0.0044100000
    ## 28   19.200000 0.04800000 0.024000000   2.880000   0.00000000 0.0240000000
    ## 29  450.000000 2.39000000 0.398000000   8.100000  18.60000000 0.0630000000
    ## 30    5.500000 0.08250000 0.013750000   0.055000   1.54000000 0.0225500000
    ## 31  764.925000 1.95300000 0.172515000  36.781500  35.15400000 0.2441250000
    ## 32  202.960000 3.28040000 0.212400000  12.508000  23.12800000 0.1416000000
    ## 33  581.910000 1.14915000 0.163815000  17.604000   0.00000000 0.3838650000
    ## 34    8.524800 0.05683200 0.028416000   0.000000   0.00000000 0.0000000000
    ## 35    2.296000 0.00246000 0.003854000   0.098400   0.00000000 0.0000000000
    ## 36  203.820000 0.16590000 0.030020000   0.316000   1.89600000 0.0118500000
    ## 37  454.000000 1.24000000 0.098000000   0.400000  11.00000000 0.1840000000
    ## 38   61.007232 0.00000000 0.000000000   0.000000   0.00953238 0.0006672666
    ## 39    3.800000 0.00100000 0.002900000   0.060000   0.00000000 0.0004000000
    ## 40  168.600000 0.59400000 0.236400000   6.300000   0.06000000 0.1026000000
    ## 41  216.000000 1.86300000 0.062100000   4.860000   1.62000000 0.1107000000
    ## 42   39.345000 0.33855000 0.022875000   3.385500   0.00000000 0.0420900000
    ## 43    0.360000 0.05040000 0.017280000   0.144000  21.16800000 0.0086400000
    ## 44    1.260000 0.06930000 0.011340000   0.252000   0.15750000 0.0000000000
    ## 45    0.031500 0.00031500 0.000220500   0.018900   0.00000000 0.0000000000
    ## 46  217.980000 0.49560000 0.067620000  12.096000   0.08400000 0.1978200000
    ## 47   65.722500 0.01552500 0.001966500   0.238050   0.00000000 0.0010350000
    ## 48  551.880000 0.65940000 0.072660000  13.272000   0.00000000 0.1411200000
    ## 49  209.860875 0.65541656 0.089143031   2.328244   0.00000000 0.0657011250
    ## 50  100.146375 0.70804125 0.006857156   5.708981   0.00000000 0.0033488437
    ## 51   95.681250 0.47840625 0.005103000   2.312297   0.00000000 0.0023920312
    ##            VB2         NIAC        VB6        FOLA      FA          FF
    ## 1  0.396760000  5.870760000 0.66920000 199.9200000 194.600   5.3200000
    ## 2  0.451400000  0.224480000 0.09272000  12.2000000   0.000  12.2000000
    ## 3  0.035040000  0.319200000 0.17616000   9.6000000   0.000   9.6000000
    ## 4  1.939080000  8.210580000 1.04412000 142.3800000   0.000 142.3800000
    ## 5  0.116438400  0.835968000 0.22690560  56.7264000   0.000  56.7264000
    ## 6  0.269952000  0.678432000 0.00355200   7.1040000   0.000   7.1040000
    ## 7  0.000000000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 8  0.001596000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 9  0.000000000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 10 0.102240000  0.129600000 0.01200000   3.8400000   0.000   3.8400000
    ## 11 0.542640000  6.324000000 0.19992000 126.4800000  73.440  53.0400000
    ## 12 0.000000000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 13 0.400800000  0.196800000 0.10800000  19.2000000   0.000  19.2000000
    ## 14 0.276500000  8.276040000 0.53878000  15.8000000   0.000  15.8000000
    ## 15 0.283920000  4.234880000 0.07904000  62.4000000  46.800  15.6000000
    ## 16 0.006000000  0.104600000 0.01260000   1.4000000   0.000   1.4000000
    ## 17 0.015120000  0.064960000 0.06720000  10.6400000   0.000  10.6400000
    ## 18 0.318937500  0.068040000 0.06293700  15.3090000   0.000  15.3090000
    ## 19 0.021500000  0.076250000 0.01825000  24.2500000   0.000  24.2500000
    ## 20 0.047587500  0.237350000 0.03877500  75.7875000   0.000  75.7875000
    ## 21 0.105937500  0.022600000 0.02090500   5.0850000   0.000   5.0850000
    ## 22 0.052968750  0.015961250 0.01243000   2.2600000   0.000   2.2600000
    ## 23 0.006750000  0.029000000 0.03000000   4.7500000   0.000   4.7500000
    ## 24 0.013037500  0.223500000 0.10430000   4.6562500   0.000   4.6562500
    ## 25 0.079875000  1.875375000 0.30262500  51.0750000   0.000  51.0750000
    ## 26 0.026523000  0.292698000 0.00522900   6.6150000   4.095   2.5200000
    ## 27 0.025578000  0.015876000 0.00882000   1.1760000   0.000   1.1760000
    ## 28 0.120000000  2.462400000 0.22080000  28.8000000   0.000  28.8000000
    ## 29 0.230000000  4.182000000 0.72300000  75.0000000   0.000  75.0000000
    ## 30 0.013750000  0.067650000 0.02310000  15.9500000   0.000  15.9500000
    ## 31 0.341775000 10.289055000 1.04811000  94.3950000  26.040  71.6100000
    ## 32 0.179360000  2.751760000 0.42008000  66.0800000   0.000  66.0800000
    ## 33 0.031785000  3.486570000 0.22005000 136.9200000 129.585   7.3350000
    ## 34 0.039782400  0.000000000 0.00000000  14.2080000   0.000  14.2080000
    ## 35 0.000000000  0.009020000 0.00336200   0.0820000   0.000   0.0820000
    ## 36 0.035550000  0.158000000 0.02291000  20.5400000   0.000  20.5400000
    ## 37 0.114000000  3.346000000 0.27600000  46.0000000   0.000  46.0000000
    ## 38 0.002478419  0.001525181 0.35746425   0.0953238   0.000   0.0953238
    ## 39 0.000300000  0.000700000 0.00030000   0.0000000   0.000   0.0000000
    ## 40 0.096600000  0.763800000 0.05760000  24.0000000  12.600  11.4000000
    ## 41 0.648000000  0.313200000 0.12960000  13.5000000   0.000  13.5000000
    ## 42 0.154635000  0.081435000 0.03294000   4.5750000   0.000   4.5750000
    ## 43 0.007920000  0.138960000 0.01692000   8.6400000   0.000   8.6400000
    ## 44 0.011970000  0.038115000 0.00756000   0.6300000   0.000   0.6300000
    ## 45 0.000598500  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 46 0.113400000  2.491860000 0.04494000  35.7000000   8.400  27.3000000
    ## 47 0.001966500  0.000000000 0.00082800   0.5175000   0.000   0.5175000
    ## 48 0.111720000  2.392740000 0.16548000   0.0000000   0.000   0.8400000
    ## 49 0.086910469  0.886646250 0.09041878   1.4352187   0.000   1.4352187
    ## 50 0.063309094  0.023122969 0.01339537   3.1893750   0.000   3.1893750
    ## 51 0.062192812  0.014830594 0.01259803   2.8704375   0.000   2.8704375
    ##           FDFE      VB12      VARA        RET         BCAR        ACAR
    ## 1  336.2800000 1.8956000 277.20000 277.200000    0.0000000    0.000000
    ## 2   12.2000000 1.2932000 134.20000 134.200000    9.7600000    0.000000
    ## 3    9.6000000 0.0000000   1.44000   0.000000   12.4800000   12.000000
    ## 4  142.3800000 4.2036000 759.36000 684.780000  779.7000000  162.720000
    ## 5   56.7264000 0.0000000   5.97120   0.000000   23.8848000   23.884800
    ## 6    7.1040000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 7    0.0000000 0.0000000   0.30000   0.000000    2.7000000    0.000000
    ## 8    0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 9    0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 10   3.8400000 0.2544000  26.88000  26.880000    0.0000000    0.000000
    ## 11 177.4800000 1.3872000 124.44000 110.160000  165.2400000    0.000000
    ## 12   0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 13  21.6000000 0.9360000 436.80000 429.600000   76.8000000    2.400000
    ## 14  15.8000000 3.9500000   0.00000   0.000000    0.0000000    0.000000
    ## 15  95.6800000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 16   1.4000000 0.0000000   0.80000   0.000000    5.8000000    0.000000
    ## 17  10.6400000 0.0000000   0.00000   0.000000    0.5600000    0.000000
    ## 18  15.3090000 0.7059150 225.38250 219.429000   72.2925000    0.000000
    ## 19  24.2500000 0.0000000  29.75000   0.000000  356.0000000    0.000000
    ## 20  75.7875000 0.0000000 162.73750   0.000000 1949.9125000    0.000000
    ## 21   5.0850000 0.2344750  74.86250  72.885000   24.0125000    0.000000
    ## 22   2.2600000 0.1469000  32.20500  30.933750   13.7012500    0.000000
    ## 23   4.7500000 0.0000000   0.00000   0.000000    0.2500000    0.000000
    ## 24   4.6562500 0.0000000   8.38125   0.000000   96.8500000    9.778125
    ## 25  51.0750000 0.0000000   0.67500   0.000000    6.7500000    0.000000
    ## 26   9.5130000 0.0088200   0.44100   0.441000    0.3780000    0.000000
    ## 27   1.1760000 0.0529200   4.11600   3.822000    3.8220000    0.000000
    ## 28  28.8000000 0.0960000   0.00000   0.000000    0.0000000    0.000000
    ## 29  75.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 30  15.9500000 0.0000000  13.75000   0.000000  164.4500000    2.200000
    ## 31 113.9250000 0.2604000 439.42500   6.510000 4361.7000000 1656.795000
    ## 32  66.0800000 0.8732000 311.52000   0.000000 3282.7600000  901.520000
    ## 33 229.8300000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 34  14.2080000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 35   0.0820000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 36  20.5400000 0.0000000  30.02000  15.800000   97.1700000  119.290000
    ## 37  46.0000000 0.0000000  26.00000   0.000000  132.0000000   46.000000
    ## 38   0.0953238 1.0294970  78.07019  73.208678   58.1475180    0.000000
    ## 39   0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 40  33.0000000 0.0480000  70.20000  68.400000   15.6000000    0.000000
    ## 41  13.5000000 1.0530000 318.60000 313.200000   51.3000000    0.000000
    ## 42   4.5750000 0.4117500  42.09000  41.175000    6.4050000    0.000000
    ## 43   8.6400000 0.0000000   0.36000   0.000000    2.5200000    0.000000
    ## 44   0.6300000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 45   0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 46  41.5800000 0.0000000   0.00000   0.000000    0.4200000    0.000000
    ## 47   0.5175000 0.0124200   1.65600   1.552500    0.6210000    0.000000
    ## 48   0.8400000 0.1512000   0.00000   0.000000    0.0000000    0.000000
    ## 49   1.4352187 0.2950172   8.93025   8.770781    0.4784062    0.000000
    ## 50   3.1893750 0.2248509  23.12297  22.644562    4.4651250    0.000000
    ## 51   2.8704375 0.1323591  31.57481  30.618000   12.4385625    0.000000
    ##           CRYP     LYCO          LZ       ATOC           VK        CHOLE
    ## 1    0.0000000    0.000   41.720000 0.18200000   0.50400000    0.0000000
    ## 2    0.0000000    0.000    0.000000 0.07320000   0.48800000   19.5200000
    ## 3    0.0000000    0.000   10.560000 0.04800000   0.24000000    0.0000000
    ## 4   27.1200000 4183.260 1715.340000 7.45800000  40.00200000 1274.6400000
    ## 5   80.6112000    0.000   80.611200 0.59712000   0.00000000    0.0000000
    ## 6    0.0000000    0.000    0.000000 0.03552000   0.35520000    0.0000000
    ## 7    0.0000000    0.000    0.000000 0.24300000   0.75000000    0.0000000
    ## 8    0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 9    0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 10   0.0000000    0.000    0.000000 0.17280000   1.92000000    6.7200000
    ## 11   0.0000000 3445.560   53.040000 1.75440000  12.64800000   55.0800000
    ## 12   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 13   2.4000000    0.000   81.600000 1.22400000   3.12000000  220.8000000
    ## 14   0.0000000    0.000    0.000000 0.69520000   3.16000000  129.5600000
    ## 15   0.0000000    0.000   67.600000 0.37440000   2.80800000    0.0000000
    ## 16   5.2000000    0.000    3.600000 0.07200000   0.36000000    0.0000000
    ## 17   0.0000000    0.000    2.240000 0.01120000   0.22400000    0.0000000
    ## 18   0.0000000    0.000    0.000000 0.24664500   2.38140000   89.3025000
    ## 19   0.0000000    0.000  888.750000 0.10750000  27.15000000    0.0000000
    ## 20   0.0000000    0.000 2469.850000 0.55225000 123.61000000    0.0000000
    ## 21   0.0000000    0.000    0.000000 0.08192500   0.79100000   29.6625000
    ## 22   1.2712500    0.000    3.813750 0.05650000   0.36725000   12.2887500
    ## 23   0.0000000    0.000    1.000000 0.00500000   0.10000000    0.0000000
    ## 24   3.2593750    0.000  158.778125 0.17228125   3.44562500    0.0000000
    ## 25   0.0000000    0.000    0.000000 7.91325000   0.00000000    0.0000000
    ## 26   0.0000000    0.000    2.835000 0.02520000   0.47880000    0.4410000
    ## 27   0.2940000    0.294    6.174000 0.65268000  36.80880000    7.6440000
    ## 28   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 29   0.0000000    0.000    0.000000 6.74000000  22.10000000    0.0000000
    ## 30   0.0000000    0.000  152.350000 0.09900000  13.25500000    0.0000000
    ## 31   0.0000000    0.000  911.400000 3.58050000 107.74050000  100.9050000
    ## 32   0.0000000  250.160 2461.480000 2.00600000 117.05600000   44.8400000
    ## 33   0.0000000    0.000    0.000000 0.92910000   7.57950000    0.0000000
    ## 34   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 35   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 36  18.1700000    0.000  346.020000 0.07900000  29.94100000    4.7400000
    ## 37 320.0000000    0.000 1802.000000 0.18000000   0.80000000    0.0000000
    ## 38   0.0000000    0.000    0.000000 2.01323866   9.65630094    0.0953238
    ## 39   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 40   0.6000000    0.000   25.200000 0.35400000   1.68000000   34.8000000
    ## 41   0.0000000    0.000    0.000000 0.81000000   0.81000000  118.8000000
    ## 42   0.0000000    0.000    0.000000 0.06405000   0.27450000    9.1500000
    ## 43   0.0000000    0.000    9.360000 0.10440000   0.79200000    0.0000000
    ## 44   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 45   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 46   0.0000000    0.000   18.480000 0.07980000   2.05800000    0.0000000
    ## 47   0.4140000    0.000    1.242000 0.33948000  16.87050000    4.3470000
    ## 48   0.0000000    0.000    0.000000 0.12180000   0.00000000   17.2200000
    ## 49   0.0000000    0.000    0.000000 0.04305656   0.03189375    4.1461875
    ## 50   0.1594687    0.000    0.637875 0.07654500   0.23920312   12.1196250
    ## 51   0.0000000    0.000    0.000000 0.04146187   0.39867188   14.1927187
    ##           SFAT        S040         S060         S080        S100
    ## 1   0.42000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 2   3.06708000 0.187880000 0.0976000000 0.0488000000 0.119560000
    ## 3   0.05376000 0.000000000 0.0000000000 0.0000000000 0.000480000
    ## 4  32.64570000 0.616980000 0.3186600000 0.1898400000 0.400020000
    ## 5   0.04179840 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 6   0.00710400 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 7   0.58110000 0.000000000 0.0000000000 0.0015000000 0.003900000
    ## 8   0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 9   0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 10  6.27840000 0.221760000 0.0801600000 0.0456000000 0.086880000
    ## 11  8.99028000 0.299880000 0.0571200000 0.0795600000 0.189720000
    ## 12  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 13 24.78960000 1.178400000 0.6960000000 0.4056000000 0.912000000
    ## 14  9.96506000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 15  1.55688000 0.000000000 0.0000000000 0.0031200000 0.000000000
    ## 16  0.04960000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 17  0.02352000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 18 17.93874600 0.889623000 0.4499145000 0.2372895000 0.510300000
    ## 19  0.02150000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 20  0.03113750 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 21  5.95849000 0.295495000 0.1494425000 0.0788175000 0.169500000
    ## 22  2.26098875 0.104242500 0.0532512500 0.0323462500 0.071896250
    ## 23  0.01050000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 24  0.02700625 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 25  1.00237500 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 26  0.33056100 0.005796000 0.0021420000 0.0011340000 0.002835000
    ## 27  2.04741600 0.001764000 0.0011760000 0.0114660000 0.010584000
    ## 28  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 29  4.01400000 0.000000000 0.0000000000 0.0000000000 0.001000000
    ## 30  0.00990000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 31  3.04342500 0.000000000 0.0000000000 0.0000000000 0.019530000
    ## 32  3.84444000 0.002360000 0.0023600000 0.0023600000 0.023600000
    ## 33  1.07091000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 34  0.00568320 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 35  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 36  1.28217000 0.076630000 0.0474000000 0.0284400000 0.060040000
    ## 37  0.39200000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 38  1.15208345 0.001334533 0.0005719428 0.0008579142 0.006863314
    ## 39  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 40  7.78380000 0.298800000 0.1860000000 0.1104000000 0.234600000
    ## 41 18.33300000 0.972000000 0.5670000000 0.3240000000 0.756000000
    ## 42  1.70647500 0.068625000 0.0686250000 0.0686250000 0.068625000
    ## 43  0.00540000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 44  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 45  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 46  0.33726000 0.003360000 0.0004200000 0.0021000000 0.014280000
    ## 47  1.21126050 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 48  0.46746000 0.000000000 0.0016800000 0.0000000000 0.000000000
    ## 49  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 50  2.00962519 0.070006781 0.0575682187 0.0363588750 0.089780906
    ## 51  3.04043119 0.156598313 0.0389103750 0.0487974375 0.089780906
    ##          S120      S140        S160      S180       MFAT        M161
    ## 1  0.00000000 0.0050400  0.36876000 0.0364000  0.6652800 0.003080000
    ## 2  0.13420000 0.4270000  1.36152000 0.5929200  1.3664000 0.065880000
    ## 3  0.00096000 0.0009600  0.04896000 0.0024000  0.0153600 0.004800000
    ## 4  0.35256000 2.3391000 19.48572000 8.0071800 35.7984000 1.823820000
    ## 5  0.00000000 0.0000000  0.04179840 0.0000000  0.0656832 0.008956800
    ## 6  0.00000000 0.0000000  0.00710400 0.0000000  0.0532800 0.000000000
    ## 7  0.01860000 0.0057000  0.26520000 0.2928000  2.2653000 0.000000000
    ## 8  0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 9  0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 10 0.09552000 0.2923200  2.62320000 2.6904000  2.4878400 0.070560000
    ## 11 0.21828000 0.9118800  4.75320000 2.2440000  7.7254800 0.397800000
    ## 12 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 13 1.02000000 3.6624000 10.00320000 4.5576000 10.7040000 0.864000000
    ## 14 0.01896000 0.7631400  5.61216000 2.9403800 11.8452600 0.966960000
    ## 15 0.00000000 0.0280800  0.85800000 0.6583200  3.2333600 0.005200000
    ## 16 0.00060000 0.0008000  0.02800000 0.0092000  0.5254000 0.001800000
    ## 17 0.00000000 0.0022400  0.01904000 0.0022400  0.0072800 0.000000000
    ## 18 0.46012050 2.8321650  8.33745150 3.4079535  7.9870455 0.853902000
    ## 19 0.00075000 0.0000000  0.01800000 0.0010000  0.0122500 0.000250000
    ## 20 0.00000000 0.0011750  0.02702500 0.0017625  0.0041125 0.000587500
    ## 21 0.15283250 0.9407250  2.76934750 1.1319775  2.6529575 0.283630000
    ## 22 0.06893000 0.3599050  1.04652125 0.4237500  1.0168587 0.095202500
    ## 23 0.00000000 0.0010000  0.00850000 0.0010000  0.0032500 0.000000000
    ## 24 0.00000000 0.0000000  0.02328125 0.0037250  0.0037250 0.000000000
    ## 25 0.00000000 0.0056250  0.49725000 0.3802500  4.1688000 0.004500000
    ## 26 0.00384300 0.0177660  0.16594200 0.1274490  0.5983740 0.002961000
    ## 27 0.00382200 0.0188160  1.34975400 0.5386080  2.6948040 0.016170000
    ## 28 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 29 0.00800000 0.0060000  2.83000000 1.0840000 15.9990000 0.043000000
    ## 30 0.00000000 0.0000000  0.00880000 0.0011000  0.0033000 0.000550000
    ## 31 0.00651000 0.0195300  2.12551500 0.7063350  7.6720350 0.192045000
    ## 32 0.02360000 0.2525200  2.40956000 1.0620000  5.7867200 0.323320000
    ## 33 0.00000000 0.0048900  0.77262000 0.2249400  2.9535600 0.017115000
    ## 34 0.00000000 0.0000000  0.00284160 0.0000000  0.0028416 0.000000000
    ## 35 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 36 0.06162000 0.1761700  0.56959000 0.2456900  0.5095500 0.022910000
    ## 37 0.00000000 0.0000000  0.36800000 0.0240000  0.7440000 0.000000000
    ## 38 0.01906476 0.0156331  0.60616404 0.4533600  1.8443249 0.005147485
    ## 39 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 40 0.23940000 0.6924000  3.44700000 2.4528000  4.1274000 0.105600000
    ## 41 0.83700000 3.0510000  8.26200000 3.5532000  8.0163000 0.556200000
    ## 42 0.07045500 0.2717550  0.75853500 0.3339750  0.7429800 0.000000000
    ## 43 0.00000000 0.0000000  0.00432000 0.0010800  0.0154800 0.000360000
    ## 44 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 45 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 46 0.00546000 0.0058800  0.19362000 0.1003800  0.2696400 0.009240000
    ## 47 0.00000000 0.0056925  0.81858150 0.3207465  1.7432505 0.009108000
    ## 48 0.00000000 0.0189000  0.30576000 0.1411200  0.7077000 0.044520000
    ## 49 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 50 0.10221947 0.3269109  0.91838053 0.3442930  0.8458222 0.052146281
    ## 51 0.06346856 0.5761606  1.23795591 0.5458615  1.3955110 0.147189656
    ##          M181       M201         M221        PFAT        P182       P183
    ## 1   0.6487600 0.01260000 0.0005600000  0.68096000  0.65968000 0.01904000
    ## 2   1.2395200 0.00488000 0.0000000000  0.17812000  0.15128000 0.01952000
    ## 3   0.0105600 0.00000000 0.0000000000  0.03504000  0.02208000 0.01296000
    ## 4  33.1881000 0.41358000 0.0067800000 19.62132000 16.59066000 1.74924000
    ## 5   0.0537408 0.00000000 0.0000000000  0.08956800  0.06866880 0.02089920
    ## 6   0.0000000 0.00000000 0.0000000000  0.00355200  0.00355200 0.00000000
    ## 7   2.2677000 0.00000000 0.0000000000  0.00810000  0.00660000 0.00000000
    ## 8   0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 9   0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 10  2.3697600 0.00000000 0.0000000000  0.44208000  0.41472000 0.02736000
    ## 11  7.1338800 0.08568000 0.0020400000  3.85560000  3.10284000 0.32028000
    ## 12  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 13  9.8352000 0.00480000 0.0000000000  1.63200000  1.04880000 0.53280000
    ## 14 10.0835600 0.09006000 0.0000000000  0.71890000  0.56248000 0.06952000
    ## 15  3.2281600 0.00000000 0.0000000000  1.15128000  1.09096000 0.06032000
    ## 16  0.1860000 0.06820000 0.2526000000  0.19080000  0.08860000 0.09160000
    ## 17  0.0072800 0.00000000 0.0000000000  0.00952000  0.00728000 0.00224000
    ## 18  6.7232025 0.00000000 0.0000000000  0.80117100  0.49073850 0.31043250
    ## 19  0.0115000 0.00000000 0.0000000000  0.07975000  0.03250000 0.04250000
    ## 20  0.0035250 0.00000000 0.0000000000  0.07402500  0.04582500 0.02820000
    ## 21  2.2331625 0.00000000 0.0000000000  0.26611500  0.16300250 0.10311250
    ## 22  0.8674162 0.00720375 0.0000000000  0.11624875  0.07924125 0.03262875
    ## 23  0.0032500 0.00000000 0.0000000000  0.00425000  0.00325000 0.00100000
    ## 24  0.0037250 0.00000000 0.0000000000  0.02886875  0.02514375 0.00372500
    ## 25  4.1355000 0.01912500 0.0065250000  5.20582500  5.18625000 0.01350000
    ## 26  0.5954130 0.00000000 0.0000000000  0.14918400  0.14030100 0.00894600
    ## 27  2.6210100 0.03557400 0.0144060000  7.54992000  6.53356200 0.99960000
    ## 28  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 29 15.9120000 0.04400000 0.0000000000 15.99800000 15.82700000 0.17200000
    ## 30  0.0022000 0.00000000 0.0000000000  0.04070000  0.01155000 0.02860000
    ## 31  7.1740200 0.10090500 0.0000000000  7.69156500  6.49047000 0.96999000
    ## 32  5.4138400 0.04484000 0.0000000000  3.13172000  2.61252000 0.50268000
    ## 33  2.8973250 0.03667500 0.0000000000  3.11737500  2.69683500 0.41809500
    ## 34  0.0000000 0.00000000 0.0000000000  0.01136640  0.00284160 0.00852480
    ## 35  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 36  0.4842700 0.00237000 0.0000000000  0.22199000  0.12087000 0.09875000
    ## 37  0.7440000 0.00000000 0.0000000000  1.19800000  1.16600000 0.03600000
    ## 38  1.8174436 0.01849282 0.0000000000  2.52388825  2.26260572 0.25880412
    ## 39  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 40  4.0008000 0.02040000 0.0000000000  4.00320000  3.28080000 0.70980000
    ## 41  7.4601000 0.00000000 0.0000000000  1.22040000  0.74250000 0.47250000
    ## 42  0.7429800 0.00000000 0.0000000000  0.17842500  0.10980000 0.06862500
    ## 43  0.0151200 0.00000000 0.0000000000  0.05580000  0.03240000 0.02340000
    ## 44  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 45  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 46  0.2524200 0.00714000 0.0000000000  0.67578000  0.61026000 0.06342000
    ## 47  1.7030925 0.02463300 0.0022770000  4.62541500  4.05161100 0.56469600
    ## 48  0.6531000 0.01008000 0.0000000000  0.14700000  0.13440000 0.00672000
    ## 49  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 50  0.7477490 0.00637875 0.0003189375  0.14240559  0.11848528 0.01020600
    ## 51  1.1749657 0.00000000 0.0000000000  0.14336241  0.10158159 0.04162134
    ##         P184        P204         P205        P225       P226       VITD
    ## 1  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.95200000
    ## 2  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 2.92800000
    ## 3  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 4  0.0000000 0.657660000 0.0000000000 0.040680000 0.17628000 8.81400000
    ## 5  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 6  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 7  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 8  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 9  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 10 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 11 0.0591600 0.044880000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 12 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 13 0.0024000 0.033600000 0.0024000000 0.000000000 0.00960000 0.72000000
    ## 14 0.0000000 0.063200000 0.0047400000 0.025280000 0.00158000 0.31600000
    ## 15 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 16 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 17 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 18 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.51030000
    ## 19 0.0000000 0.000500000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 20 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 21 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.16950000
    ## 22 0.0002825 0.001130000 0.0004237500 0.000565000 0.00014125 0.33900000
    ## 23 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 24 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 25 0.0031500 0.000000000 0.0031500000 0.000000000 0.00000000 0.00000000
    ## 26 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 27 0.0000000 0.008820000 0.0000000000 0.000000000 0.00117600 0.02940000
    ## 28 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 29 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 30 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 31 0.0000000 0.074865000 0.0032550000 0.009765000 0.00651000 0.00000000
    ## 32 0.0000000 0.009440000 0.0000000000 0.007080000 0.00000000 0.00000000
    ## 33 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 34 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 35 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 36 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 37 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 38 0.0000000 0.000000000 0.0000000000 0.000476619 0.00000000 0.15251808
    ## 39 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 40 0.0000000 0.007800000 0.0000000000 0.000000000 0.00240000 0.24000000
    ## 41 0.0000000 0.000000000 0.0081000000 0.000000000 0.00000000 0.54000000
    ## 42 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 1.18950000
    ## 43 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 44 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 45 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 46 0.0000000 0.001260000 0.0008400000 0.000000000 0.00000000 0.00000000
    ## 47 0.0000000 0.005175000 0.0000000000 0.000000000 0.00051750 0.02070000
    ## 48 0.0000000 0.005460000 0.0000000000 0.000000000 0.00000000 0.29400000
    ## 49 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.01594687
    ## 50 0.0000000 0.005581406 0.0009568125 0.001594687 0.00000000 0.04784062
    ## 51 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.09568125
    ##          CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE   V_TOTAL
    ## 1    7.3360000        0  1.8956 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 2   40.0160000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 3    4.7040000        0  0.0000 0.32160   0.0000  0.3216 0.00000 0.0000000
    ## 4  871.2300000        0  0.0000 0.00000   0.0000  0.0000 0.00000 1.0848000
    ## 5   18.5107200        0  0.0000 1.19424   0.0000  0.0000 1.19424 0.0000000
    ## 6    9.2352000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 7    0.0000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 8    0.0000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 9    0.0000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 10  10.4160000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 11  44.2680000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.3876000
    ## 12   2.2104000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 13  62.4000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 14 119.9220000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 15  19.4480000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 16   4.4800000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 17   3.4160000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.3528000
    ## 18  14.0332500        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 19   3.8250000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.6250000
    ## 20   7.7550000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.5875000
    ## 21   4.6612500        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 22   3.1075000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 23   1.5250000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.1575000
    ## 24   2.5609375        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.3864687
    ## 25  12.3975000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 26   0.9198000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 27   9.6432000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 28  48.4800000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 29  12.1000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 1.7500000
    ## 30   3.6850000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.5005000
    ## 31  78.1200000        0  0.0000 0.00000   0.0000  0.0000 0.00000 1.0090500
    ## 32  70.8000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.8968000
    ## 33   4.8900000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 34   1.1366400        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 35   0.1886000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 36  11.6920000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.5846000
    ## 37  57.8000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 1.2200000
    ## 38   0.9723028        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 39   0.0000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 40  18.5400000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 41  70.2000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 42  13.0845000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 43   2.0520000        0  0.0000 0.24840   0.2484  0.0000 0.00000 0.0000000
    ## 44   0.6930000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 45   0.0000000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 46   7.8540000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 47   3.5397000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 48  26.2080000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 49   6.1236000        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 50   2.4558187        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 51   2.4558187        0  0.0000 0.00000   0.0000  0.0000 0.00000 0.0000000
    ##    V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL
    ## 1  0.00000       0.00000         0.0000       0.00000           0.000
    ## 2  0.00000       0.00000         0.0000       0.00000           0.000
    ## 3  0.00000       0.00000         0.0000       0.00000           0.000
    ## 4  0.00000       1.08480         1.0848       0.00000           0.000
    ## 5  0.00000       0.00000         0.0000       0.00000           0.000
    ## 6  0.00000       0.00000         0.0000       0.00000           0.000
    ## 7  0.00000       0.00000         0.0000       0.00000           0.000
    ## 8  0.00000       0.00000         0.0000       0.00000           0.000
    ## 9  0.00000       0.00000         0.0000       0.00000           0.000
    ## 10 0.00000       0.00000         0.0000       0.00000           0.000
    ## 11 0.00000       0.16320         0.1632       0.00000           0.000
    ## 12 0.00000       0.00000         0.0000       0.00000           0.000
    ## 13 0.00000       0.00000         0.0000       0.00000           0.000
    ## 14 0.00000       0.00000         0.0000       0.00000           0.000
    ## 15 0.00000       0.00000         0.0000       0.00000           0.000
    ## 16 0.00000       0.00000         0.0000       0.00000           0.000
    ## 17 0.00000       0.00000         0.0000       0.00000           0.000
    ## 18 0.00000       0.00000         0.0000       0.00000           0.000
    ## 19 0.62500       0.00000         0.0000       0.00000           0.000
    ## 20 0.58750       0.00000         0.0000       0.00000           0.000
    ## 21 0.00000       0.00000         0.0000       0.00000           0.000
    ## 22 0.00000       0.00000         0.0000       0.00000           0.000
    ## 23 0.00000       0.00000         0.0000       0.00000           0.000
    ## 24 0.00000       0.00000         0.0000       0.00000           0.000
    ## 25 0.00000       0.00000         0.0000       0.00000           0.000
    ## 26 0.00000       0.00000         0.0000       0.00000           0.000
    ## 27 0.00000       0.00000         0.0000       0.00000           0.000
    ## 28 0.00000       0.00000         0.0000       0.00000           0.000
    ## 29 0.00000       0.00000         0.0000       0.00000           1.750
    ## 30 0.00000       0.00000         0.0000       0.00000           0.000
    ## 31 0.29295       0.29295         0.0000       0.29295           0.000
    ## 32 0.14160       0.21240         0.0472       0.16520           0.236
    ## 33 0.00000       0.00000         0.0000       0.00000           0.000
    ## 34 0.00000       0.00000         0.0000       0.00000           0.000
    ## 35 0.00000       0.00000         0.0000       0.00000           0.000
    ## 36 0.00000       0.00000         0.0000       0.00000           0.000
    ## 37 0.00000       0.00000         0.0000       0.00000           1.220
    ## 38 0.00000       0.00000         0.0000       0.00000           0.000
    ## 39 0.00000       0.00000         0.0000       0.00000           0.000
    ## 40 0.00000       0.00000         0.0000       0.00000           0.000
    ## 41 0.00000       0.00000         0.0000       0.00000           0.000
    ## 42 0.00000       0.00000         0.0000       0.00000           0.000
    ## 43 0.00000       0.00000         0.0000       0.00000           0.000
    ## 44 0.00000       0.00000         0.0000       0.00000           0.000
    ## 45 0.00000       0.00000         0.0000       0.00000           0.000
    ## 46 0.00000       0.00000         0.0000       0.00000           0.000
    ## 47 0.00000       0.00000         0.0000       0.00000           0.000
    ## 48 0.00000       0.00000         0.0000       0.00000           0.000
    ## 49 0.00000       0.00000         0.0000       0.00000           0.000
    ## 50 0.00000       0.00000         0.0000       0.00000           0.000
    ## 51 0.00000       0.00000         0.0000       0.00000           0.000
    ##    V_STARCHY_POTATO V_STARCHY_OTHER   V_OTHER V_LEGUMES G_TOTAL G_WHOLE
    ## 1             0.000            0.00 0.0000000    0.0000 0.91840  0.9184
    ## 2             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 3             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 4             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 5             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 6             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 7             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 8             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 9             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 10            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 11            0.000            0.00 0.2244000    0.0000 3.69240  0.0000
    ## 12            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 13            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 14            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 15            0.000            0.00 0.0000000    0.0000 3.67120  0.9776
    ## 16            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 17            0.000            0.00 0.3528000    0.0000 0.00000  0.0000
    ## 18            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 19            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 20            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 21            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 22            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 23            0.000            0.00 0.1575000    0.0000 0.00000  0.0000
    ## 24            0.000            0.00 0.3864687    0.0000 0.00000  0.0000
    ## 25            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 26            0.000            0.00 0.0000000    0.0000 0.24759  0.0000
    ## 27            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 28            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 29            1.750            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 30            0.000            0.00 0.5005000    0.0000 0.00000  0.0000
    ## 31            0.000            0.00 0.4231500    0.0000 0.55335  0.0000
    ## 32            0.236            0.00 0.3068000    0.0236 0.00000  0.0000
    ## 33            0.000            0.00 0.0000000    0.0000 2.88510  0.0000
    ## 34            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 35            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 36            0.000            0.00 0.5846000    0.0000 0.00000  0.0000
    ## 37            0.000            1.22 0.0000000    0.0000 0.00000  0.0000
    ## 38            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 39            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 40            0.000            0.00 0.0000000    0.0000 0.72000  0.0000
    ## 41            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 42            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 43            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 44            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 45            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 46            0.000            0.00 0.0000000    0.0000 1.49100  0.4158
    ## 47            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 48            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 49            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 50            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 51            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ##    G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT
    ## 1    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 2    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 3    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 4    0.00000 9.356400       3.3222  0.0000       3.3222        0    0.000
    ## 5    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 6    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 7    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 8    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 9    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 10   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 11   3.69240 0.632400       0.6324  0.0000       0.6324        0    0.000
    ## 12   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 13   0.00000 0.144000       0.0000  0.0000       0.0000        0    0.000
    ## 14   0.00000 5.087600       5.0876  5.0876       0.0000        0    0.000
    ## 15   2.69360 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 16   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 17   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 18   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 19   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 20   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 21   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 22   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 23   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 24   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 25   0.00000 1.586250       0.0000  0.0000       0.0000        0    0.000
    ## 26   0.24759 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 27   0.00000 0.014700       0.0000  0.0000       0.0000        0    0.000
    ## 28   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 29   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 30   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 31   0.55335 3.255000       3.2550  0.0000       0.0000        0    3.255
    ## 32   0.00000 1.156400       1.1564  1.1564       0.0000        0    0.000
    ## 33   2.88510 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 34   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 35   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 36   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 37   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 38   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 39   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 40   0.72000 0.600000       0.0000  0.0000       0.0000        0    0.000
    ## 41   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 42   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 43   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 44   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 45   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 46   1.07520 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 47   0.00000 0.015525       0.0000  0.0000       0.0000        0    0.000
    ## 48   0.00000 1.482600       1.4826  0.0000       1.4826        0    0.000
    ## 49   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 50   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 51   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ##    PF_SEAFD_HI PF_SEAFD_LOW  PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES   D_TOTAL
    ## 1            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 2            0            0 0.000000      0   0.00000      0.000 1.0004000
    ## 3            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 4            0            0 6.034200      0   0.00000      0.000 1.6272000
    ## 5            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 6            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 7            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 8            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 9            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 10           0            0 0.000000      0   0.00000      0.000 0.1536000
    ## 11           0            0 0.000000      0   0.00000      0.000 0.6528000
    ## 12           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 13           0            0 0.144000      0   0.00000      0.000 0.3360000
    ## 14           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 15           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 16           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 17           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 18           0            0 0.000000      0   0.00000      0.000 1.9986750
    ## 19           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 20           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 21           0            0 0.000000      0   0.00000      0.000 0.6638750
    ## 22           0            0 0.000000      0   0.00000      0.000 0.3813750
    ## 23           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 24           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 25           0            0 0.000000      0   1.58625      0.000 0.0000000
    ## 26           0            0 0.000000      0   0.00000      0.000 0.0132300
    ## 27           0            0 0.014700      0   0.00000      0.000 0.0000000
    ## 28           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 29           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 30           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 31           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 32           0            0 0.000000      0   0.00000      0.118 0.0236000
    ## 33           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 34           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 35           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 36           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 37           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 38           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 39           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 40           0            0 0.084000      0   0.51600      0.000 0.0000000
    ## 41           0            0 0.000000      0   0.00000      0.000 0.6210000
    ## 42           0            0 0.000000      0   0.00000      0.000 0.3751500
    ## 43           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 44           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 45           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 46           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 47           0            0 0.015525      0   0.00000      0.000 0.0000000
    ## 48           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 49           0            0 0.000000      0   0.00000      0.000 0.3747516
    ## 50           0            0 0.000000      0   0.00000      0.000 0.3747516
    ## 51           0            0 0.000000      0   0.00000      0.000 0.3747516
    ##     D_MILK D_YOGURT  D_CHEESE      OILS SOLID_FATS ADD_SUGARS A_DRINKS
    ## 1  0.00000   0.0000 0.0000000  0.000000   0.000000    0.19880    0.000
    ## 2  1.00040   0.0000 0.0000000  0.000000   3.342800    0.00000    0.000
    ## 3  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 4  0.40680   0.0000 1.2204000 20.475600  45.968400    0.00000    0.000
    ## 5  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 6  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 7  0.00000   0.0000 0.0000000  0.000000   2.991000    0.81300    0.000
    ## 8  0.00000   0.0000 0.0000000  0.000000   0.000000    1.99584    0.000
    ## 9  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 10 0.15360   0.0000 0.0000000  0.000000   8.203200    6.53760    0.000
    ## 11 0.00000   0.0000 0.6528000  1.040400  19.278000    0.24480    0.000
    ## 12 0.00000   0.0000 0.0000000  0.000000   0.000000   15.76752    0.000
    ## 13 0.33600   0.0000 0.0000000  0.000000  37.776000    9.81600    0.000
    ## 14 0.00000   0.0000 0.0000000  0.000000  12.371400    0.00000    0.000
    ## 15 0.00000   0.0000 0.0000000  5.449600   0.000000    0.35360    0.000
    ## 16 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 17 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 18 0.00000   0.0000 1.9986750  0.000000  25.183305    0.00000    0.000
    ## 19 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 20 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 21 0.00000   0.0000 0.6638750  0.000000   8.364825    0.00000    0.000
    ## 22 0.00000   0.0000 0.3813750  0.000000   3.055238    0.00000    0.000
    ## 23 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 24 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 25 0.00000   0.0000 0.0000000  7.404750   0.000000    0.00000    0.000
    ## 26 0.00000   0.0000 0.0088200  0.913500   0.054810    0.03024    0.000
    ## 27 0.00000   0.0000 0.0000000 12.950700   0.144060    0.18522    0.000
    ## 28 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    1.344
    ## 29 0.00000   0.0000 0.0000000 36.400000   0.000000    0.00000    0.000
    ## 30 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 31 0.00000   0.0000 0.0000000 15.396150   0.000000    0.00000    0.000
    ## 32 0.00000   0.0236 0.0000000  6.183200   4.342400    0.00000    0.000
    ## 33 0.00000   0.0000 0.0000000  6.797100   0.000000    0.00000    0.000
    ## 34 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 35 0.00000   0.0000 0.0000000  0.000000   0.000000    1.89420    0.000
    ## 36 0.00000   0.0000 0.0000000  0.000000   1.911800    0.00000    0.000
    ## 37 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 38 0.00000   0.0000 0.0000000  2.851135   2.851135    0.00000    0.000
    ## 39 0.00000   0.0000 0.0000000  0.000000   0.000000    1.49800    0.000
    ## 40 0.00000   0.0000 0.0000000  3.426000  11.796000    5.79000    0.000
    ## 41 0.62100   0.0000 0.0000000  0.000000  28.755000   11.25900    0.000
    ## 42 0.37515   0.0000 0.0000000  0.000000   2.415600    0.00000    0.000
    ## 43 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 44 0.00000   0.0000 0.0000000  0.000000   0.000000    6.15825    0.000
    ## 45 0.00000   0.0000 0.0000000  0.000000   0.000000    0.74844    0.000
    ## 46 0.00000   0.0000 0.0000000  1.201200   0.000000    0.53760    0.000
    ## 47 0.00000   0.0000 0.0000000  7.555500   0.044505    0.00000    0.000
    ## 48 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 49 0.00000   0.0000 0.3747516  0.000000   0.000000    0.00000    0.000
    ## 50 0.00000   0.0000 0.3747516  0.000000   2.691832    0.00000    0.000
    ## 51 0.00000   0.0000 0.3747516  0.000000   4.265789    0.00000    0.000
    ##    FoodComp
    ## 1         1
    ## 2         1
    ## 3         1
    ## 4         1
    ## 5         1
    ## 6         1
    ## 7         1
    ## 8         1
    ## 9         1
    ## 10        1
    ## 11        1
    ## 12        1
    ## 13        1
    ## 14        1
    ## 15        1
    ## 16        1
    ## 17        1
    ## 18        1
    ## 19        1
    ## 20        1
    ## 21        1
    ## 22        1
    ## 23        1
    ## 24        1
    ## 25        1
    ## 26        1
    ## 27        1
    ## 28        1
    ## 29        1
    ## 30        1
    ## 31        1
    ## 32        1
    ## 33        1
    ## 34        1
    ## 35        1
    ## 36        1
    ## 37        1
    ## 38        1
    ## 39        1
    ## 40        1
    ## 41        1
    ## 42        1
    ## 43        1
    ## 44        1
    ## 45        1
    ## 46        1
    ## 47        1
    ## 48        1
    ## 49        1
    ## 50        1
    ## 51        1
    ##                                                                                                             Food_Description
    ## 1                                                                                                                   Cheerios
    ## 2                                                                                                 Milk, cow's, fluid, 2% fat
    ## 3                                                                                                                Banana, raw
    ## 4                                         Egg omelet or scrambled egg, with cheese, meat, and tomatoes, fat added in cooking
    ## 5                                                                               Orange juice, canned, bottled or in a carton
    ## 6                                                                                          Coffee, made from ground, regular
    ## 7                                                                                                   Cream substitute, liquid
    ## 8                                                                                           Sugar, white, granulated or lump
    ## 9                                                                                                Water, bottled, unsweetened
    ## 10                                                     M&M's Milk Chocolate Candies (formerly M&M's Plain Chocolate Candies)
    ## 11                                                                             Pizza with meat and vegetables, regular crust
    ## 12                                                                                                     Soft drink, cola-type
    ## 13                                                                             Ice cream, rich, flavors other than chocolate
    ## 14                                                                Ground beef, less than 80% lean, cooked (formerly regular)
    ## 15                                                                                          Roll, whole wheat, NS as to 100%
    ## 16                                                                                                                   Mustard
    ## 17                                                                                                       Onions, mature, raw
    ## 18                                                                                                           Cheese, Cheddar
    ## 19                                                                                                     Lettuce, arugula, raw
    ## 20                                                                        Endive, chicory, escarole, or romaine lettuce, raw
    ## 21                                                                                                           Cheese, Cheddar
    ## 22                                                                                                               Cheese, NFS
    ## 23                                                                                                       Onions, mature, raw
    ## 24                                                                                                 Pepper, sweet, green, raw
    ## 25                                                                          Sunflower seeds, hulled, unroasted, without salt
    ## 26                                                                                                                  Croutons
    ## 27                                                                                                           Creamy dressing
    ## 28                                                                                                                      Beer
    ## 29                                                                                           White potato chips, regular cut
    ## 30                                                                                                              Lettuce, raw
    ## 31 Chicken or turkey, rice, and vegetables (including carrots, broccoli, and/or dark-green leafy), soy-based sauce (mixture)
    ## 32                                                                                                                Beef curry
    ## 33                                                                  Rice, white, cooked, fat added in cooking, made with oil
    ## 34                                                                                                    Tea, leaf, unsweetened
    ## 35                                                                                                                Sugar, raw
    ## 36                                            Beans, string, green, cooked, from canned, fat added in cooking W/ BUTTER, NFS
    ## 37                                                                Corn, yellow, cooked, from fresh, fat not added in cooking
    ## 38                                                                                        Margarine-like spread, tub, salted
    ## 39                                                                                                                Hard candy
    ## 40                                                    Cookie, chocolate chip, made from home recipe or purchased at a bakery
    ## 41                                                                          Ice cream, regular, flavors other than chocolate
    ## 42                                                                                                 Milk, cow's, fluid, whole
    ## 43                                                                                                         Strawberries, raw
    ## 44                                                                                                                     Honey
    ## 45                                                                                                                Sugar, NFS
    ## 46                                                                                             Bread, wheat or cracked wheat
    ## 47                                                                                                       Mayonnaise, regular
    ## 48                                                                           Ham, sliced, prepackaged or deli, luncheon meat
    ## 49                                                                                      Cheese, American, nonfat or fat free
    ## 50                                                                                              Cheese, Cheddar, reduced fat
    ## 51                                                                                                          Cheese, Monterey

    items[,c(21:24)] #get columns 21:24. notice the 'c', which acts to 'concatenate' multiple items together

    ##    FoodCode ModCode  HowMany SubCode
    ## 1  57123000       0  1.00000       0
    ## 2  11112110       0  1.00000       0
    ## 3  63107010       0  8.00000       0
    ## 4  32131000       0  6.00000       0
    ## 5  61210220       0  9.60000       0
    ## 6  92101000       0 12.00000       0
    ## 7  12210200       0 12.00000       0
    ## 8  91101010       0  2.00000       0
    ## 9  94100100       0 10.14000       0
    ## 10 91746100       0  1.00000       0
    ## 11 58106725       0  2.00000       0
    ## 12 92410310       0 24.00000       0
    ## 13 13110120       0  2.00000       0
    ## 14 21501000       0  2.00000       0
    ## 15 51320500       0  2.00000       0
    ## 16 75506010       0  4.00000       0
    ## 17 75117020       0  4.00000       0
    ## 18 14104100       0 85.05000       0
    ## 19 75113080       0  1.25000       0
    ## 20 72116000       0  1.25000       0
    ## 21 14104100       0  0.25000       0
    ## 22 14010000       0  0.12500       0
    ## 23 75117020       0  0.15625       0
    ## 24 75122100       0  0.31250       0
    ## 25 43102000       0  0.15625       0
    ## 26 51185000       0  0.15750       0
    ## 27 83112500       0  2.00000       0
    ## 28 93101000       0 16.00000       0
    ## 29 71201015       0  4.00000       0
    ## 30 75113000       0  1.00000       0
    ## 31 27345310       0  1.50000       0
    ## 32 27116100       0  1.00000       0
    ## 33 56205002       0  1.50000       0
    ## 34 92302000       0  9.60000       0
    ## 35 91104200       0  2.00000       0
    ## 36 75205033  200058  0.50000       0
    ## 37 75216111       0  2.00000       0
    ## 38 81103080       0  0.66660       0
    ## 39 91745020       0  5.00000 1000179
    ## 40 53206020       0  2.00000       0
    ## 41 13110100       0  2.25000       0
    ## 42 11111000       0  0.37500       0
    ## 43 63223020       0  3.00000       0
    ## 44 91302010       0  1.50000       0
    ## 45 91101000       0  0.75000       0
    ## 46 51301010       0  1.50000       0
    ## 47 83107000       0  0.75000       0
    ## 48 25230210       0  1.50000       0
    ## 49 14410130       0 15.94687       0
    ## 50 14104110       0 15.94687       0
    ## 51 14106200       0 15.94687       0

We can also extract a column using the column name:

    items['FoodCode'] #data frame

    ##    FoodCode
    ## 1  57123000
    ## 2  11112110
    ## 3  63107010
    ## 4  32131000
    ## 5  61210220
    ## 6  92101000
    ## 7  12210200
    ## 8  91101010
    ## 9  94100100
    ## 10 91746100
    ## 11 58106725
    ## 12 92410310
    ## 13 13110120
    ## 14 21501000
    ## 15 51320500
    ## 16 75506010
    ## 17 75117020
    ## 18 14104100
    ## 19 75113080
    ## 20 72116000
    ## 21 14104100
    ## 22 14010000
    ## 23 75117020
    ## 24 75122100
    ## 25 43102000
    ## 26 51185000
    ## 27 83112500
    ## 28 93101000
    ## 29 71201015
    ## 30 75113000
    ## 31 27345310
    ## 32 27116100
    ## 33 56205002
    ## 34 92302000
    ## 35 91104200
    ## 36 75205033
    ## 37 75216111
    ## 38 81103080
    ## 39 91745020
    ## 40 53206020
    ## 41 13110100
    ## 42 11111000
    ## 43 63223020
    ## 44 91302010
    ## 45 91101000
    ## 46 51301010
    ## 47 83107000
    ## 48 25230210
    ## 49 14410130
    ## 50 14104110
    ## 51 14106200

    items[['FoodCode']] #vector

    ##  [1] 57123000 11112110 63107010 32131000 61210220 92101000 12210200
    ##  [8] 91101010 94100100 91746100 58106725 92410310 13110120 21501000
    ## [15] 51320500 75506010 75117020 14104100 75113080 72116000 14104100
    ## [22] 14010000 75117020 75122100 43102000 51185000 83112500 93101000
    ## [29] 71201015 75113000 27345310 27116100 56205002 92302000 91104200
    ## [36] 75205033 75216111 81103080 91745020 53206020 13110100 11111000
    ## [43] 63223020 91302010 91101000 51301010 83107000 25230210 14410130
    ## [50] 14104110 14106200

    items[,'FoodCode'] #vector, notice the ,

    ##  [1] 57123000 11112110 63107010 32131000 61210220 92101000 12210200
    ##  [8] 91101010 94100100 91746100 58106725 92410310 13110120 21501000
    ## [15] 51320500 75506010 75117020 14104100 75113080 72116000 14104100
    ## [22] 14010000 75117020 75122100 43102000 51185000 83112500 93101000
    ## [29] 71201015 75113000 27345310 27116100 56205002 92302000 91104200
    ## [36] 75205033 75216111 81103080 91745020 53206020 13110100 11111000
    ## [43] 63223020 91302010 91101000 51301010 83107000 25230210 14410130
    ## [50] 14104110 14106200

    items$FoodCode #vector

    ##  [1] 57123000 11112110 63107010 32131000 61210220 92101000 12210200
    ##  [8] 91101010 94100100 91746100 58106725 92410310 13110120 21501000
    ## [15] 51320500 75506010 75117020 14104100 75113080 72116000 14104100
    ## [22] 14010000 75117020 75122100 43102000 51185000 83112500 93101000
    ## [29] 71201015 75113000 27345310 27116100 56205002 92302000 91104200
    ## [36] 75205033 75216111 81103080 91745020 53206020 13110100 11111000
    ## [43] 63223020 91302010 91101000 51301010 83107000 25230210 14410130
    ## [50] 14104110 14106200

    #the last three are equivalent

Extract rows
------------

    items[1,] #get the first row

    ##                            RecallRecId UserName
    ## 1 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                 UserID RecallNo RecallAttempt RecallStatus
    ## 1 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ##   IntakeStartDateTime IntakeEndDateTime ReportingDate Lang Occ_No
    ## 1     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ##           Occ_Time Occ_Name EatWith WatchTVuseComputer Location FoodNum
    ## 1 05/20/2018 11:00        1       4                  1        1       1
    ##   FoodType               FoodSrce CodeNum FoodCode ModCode HowMany SubCode
    ## 1        1 Other store (any type)       1 57123000       0       1       0
    ##   PortionCode FoodAmt   KCAL   PROT   TFAT    CARB   MOIS ALC CAFF THEO
    ## 1       10205      28 105.84 3.3852 1.8844 20.5044 1.4364   0    0    0
    ##     SUGR  FIBE   CALC   IRON  MAGN   PHOS   POTA   SODI   ZINC   COPP
    ## 1 1.2208 2.632 112.28 9.2876 35.84 134.68 179.48 139.16 4.6844 0.1078
    ##    SELE    VC     VB1     VB2    NIAC    VB6   FOLA    FA   FF   FDFE
    ## 1 6.972 6.048 0.37156 0.39676 5.87076 0.6692 199.92 194.6 5.32 336.28
    ##     VB12  VARA   RET BCAR ACAR CRYP LYCO    LZ  ATOC    VK CHOLE SFAT S040
    ## 1 1.8956 277.2 277.2    0    0    0    0 41.72 0.182 0.504     0 0.42    0
    ##   S060 S080 S100 S120    S140    S160   S180    MFAT    M161    M181
    ## 1    0    0    0    0 0.00504 0.36876 0.0364 0.66528 0.00308 0.64876
    ##     M201    M221    PFAT    P182    P183 P184 P204 P205 P225 P226  VITD
    ## 1 0.0126 0.00056 0.68096 0.65968 0.01904    0    0    0    0    0 0.952
    ##   CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE V_TOTAL V_DRKGR
    ## 1 7.336        0  1.8956       0        0       0       0       0       0
    ##   V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL
    ## 1             0              0             0               0
    ##   V_STARCHY_POTATO V_STARCHY_OTHER V_OTHER V_LEGUMES G_TOTAL G_WHOLE
    ## 1                0               0       0         0  0.9184  0.9184
    ##   G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT
    ## 1         0        0            0       0            0        0        0
    ##   PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES D_TOTAL
    ## 1           0            0       0      0         0          0       0
    ##   D_MILK D_YOGURT D_CHEESE OILS SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 1      0        0        0    0          0     0.1988        0        1
    ##   Food_Description
    ## 1         Cheerios

    items[c(1:5),] #get the first five rows

    ##                            RecallRecId UserName
    ## 1 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 2 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 3 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 4 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 5 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                 UserID RecallNo RecallAttempt RecallStatus
    ## 1 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 2 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 3 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 4 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ## 5 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ##   IntakeStartDateTime IntakeEndDateTime ReportingDate Lang Occ_No
    ## 1     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 3     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 4     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ## 5     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ##           Occ_Time Occ_Name EatWith WatchTVuseComputer Location FoodNum
    ## 1 05/20/2018 11:00        1       4                  1        1       1
    ## 2 05/20/2018 11:00        1       4                  1        1       2
    ## 3 05/20/2018 11:00        1       4                  1        1       3
    ## 4 05/20/2018 11:00        1       4                  1        1       4
    ## 5 05/20/2018 11:00        1       4                  1        1       5
    ##   FoodType               FoodSrce CodeNum FoodCode ModCode HowMany SubCode
    ## 1        1 Other store (any type)       1 57123000       0     1.0       0
    ## 2        2 Other store (any type)       2 11112110       0     1.0       0
    ## 3        2 Other store (any type)       3 63107010       0     8.0       0
    ## 4        1 Other store (any type)       4 32131000       0     6.0       0
    ## 5        1 Other store (any type)       5 61210220       0     9.6       0
    ##   PortionCode FoodAmt      KCAL      PROT      TFAT     CARB     MOIS ALC
    ## 1       10205   28.00  105.8400  3.385200  1.884400 20.50440   1.4364   0
    ## 2       10205  244.00  122.0000  8.052000  4.831200 11.71200 217.6724   0
    ## 3       61935   48.00   42.7200  0.523200  0.158400 10.96320  35.9568   0
    ## 4       61009  678.00 1240.7400 79.326000 93.835200 17.62800 473.7864   0
    ## 5       30000  298.56  146.2944  2.030208  0.358272 34.45382 260.4040   0
    ##   CAFF THEO     SUGR    FIBE     CALC     IRON     MAGN      PHOS
    ## 1    0    0  1.22080 2.63200 112.2800 9.287600  35.8400  134.6800
    ## 2    0    0 12.34640 0.00000 292.8000 0.048800  26.8400  224.4800
    ## 3    0    0  5.87040 1.24800   2.4000 0.124800  12.9600   10.5600
    ## 4    0    0 11.39040 2.03400 691.5600 7.390200 101.7000 1213.6200
    ## 5    0    0 24.81034 0.89568  32.8416 0.388128  32.8416   50.7552
    ##        POTA      SODI     ZINC      COPP      SELE       VC       VB1
    ## 1  179.4800  139.1600 4.684400 0.1078000   6.97200   6.0480 0.3715600
    ## 2  341.6000  114.6800 1.171200 0.0146400   6.10000   0.4880 0.0951600
    ## 3  171.8400    0.4800 0.072000 0.0374400   0.48000   4.1760 0.0148800
    ## 4 1450.9200 2922.1800 9.017400 0.4407000 130.17600  23.7300 0.7458000
    ## 5  531.4368    5.9712 0.208992 0.1253952   0.29856 100.3162 0.1373376
    ##         VB2     NIAC       VB6     FOLA    FA       FF     FDFE   VB12
    ## 1 0.3967600 5.870760 0.6692000 199.9200 194.6   5.3200 336.2800 1.8956
    ## 2 0.4514000 0.224480 0.0927200  12.2000   0.0  12.2000  12.2000 1.2932
    ## 3 0.0350400 0.319200 0.1761600   9.6000   0.0   9.6000   9.6000 0.0000
    ## 4 1.9390800 8.210580 1.0441200 142.3800   0.0 142.3800 142.3800 4.2036
    ## 5 0.1164384 0.835968 0.2269056  56.7264   0.0  56.7264  56.7264 0.0000
    ##       VARA    RET     BCAR     ACAR    CRYP    LYCO        LZ    ATOC
    ## 1 277.2000 277.20   0.0000   0.0000  0.0000    0.00   41.7200 0.18200
    ## 2 134.2000 134.20   9.7600   0.0000  0.0000    0.00    0.0000 0.07320
    ## 3   1.4400   0.00  12.4800  12.0000  0.0000    0.00   10.5600 0.04800
    ## 4 759.3600 684.78 779.7000 162.7200 27.1200 4183.26 1715.3400 7.45800
    ## 5   5.9712   0.00  23.8848  23.8848 80.6112    0.00   80.6112 0.59712
    ##       VK   CHOLE       SFAT    S040    S060    S080    S100    S120
    ## 1  0.504    0.00  0.4200000 0.00000 0.00000 0.00000 0.00000 0.00000
    ## 2  0.488   19.52  3.0670800 0.18788 0.09760 0.04880 0.11956 0.13420
    ## 3  0.240    0.00  0.0537600 0.00000 0.00000 0.00000 0.00048 0.00096
    ## 4 40.002 1274.64 32.6457000 0.61698 0.31866 0.18984 0.40002 0.35256
    ## 5  0.000    0.00  0.0417984 0.00000 0.00000 0.00000 0.00000 0.00000
    ##      S140       S160    S180       MFAT      M161       M181    M201
    ## 1 0.00504  0.3687600 0.03640  0.6652800 0.0030800  0.6487600 0.01260
    ## 2 0.42700  1.3615200 0.59292  1.3664000 0.0658800  1.2395200 0.00488
    ## 3 0.00096  0.0489600 0.00240  0.0153600 0.0048000  0.0105600 0.00000
    ## 4 2.33910 19.4857200 8.00718 35.7984000 1.8238200 33.1881000 0.41358
    ## 5 0.00000  0.0417984 0.00000  0.0656832 0.0089568  0.0537408 0.00000
    ##      M221      PFAT       P182      P183 P184    P204 P205    P225    P226
    ## 1 0.00056  0.680960  0.6596800 0.0190400    0 0.00000    0 0.00000 0.00000
    ## 2 0.00000  0.178120  0.1512800 0.0195200    0 0.00000    0 0.00000 0.00000
    ## 3 0.00000  0.035040  0.0220800 0.0129600    0 0.00000    0 0.00000 0.00000
    ## 4 0.00678 19.621320 16.5906600 1.7492400    0 0.65766    0 0.04068 0.17628
    ## 5 0.00000  0.089568  0.0686688 0.0208992    0 0.00000    0 0.00000 0.00000
    ##    VITD     CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE
    ## 1 0.952   7.33600        0  1.8956 0.00000        0  0.0000 0.00000
    ## 2 2.928  40.01600        0  0.0000 0.00000        0  0.0000 0.00000
    ## 3 0.000   4.70400        0  0.0000 0.32160        0  0.3216 0.00000
    ## 4 8.814 871.23000        0  0.0000 0.00000        0  0.0000 0.00000
    ## 5 0.000  18.51072        0  0.0000 1.19424        0  0.0000 1.19424
    ##   V_TOTAL V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER
    ## 1  0.0000       0        0.0000         0.0000             0
    ## 2  0.0000       0        0.0000         0.0000             0
    ## 3  0.0000       0        0.0000         0.0000             0
    ## 4  1.0848       0        1.0848         1.0848             0
    ## 5  0.0000       0        0.0000         0.0000             0
    ##   V_STARCHY_TOTAL V_STARCHY_POTATO V_STARCHY_OTHER V_OTHER V_LEGUMES
    ## 1               0                0               0       0         0
    ## 2               0                0               0       0         0
    ## 3               0                0               0       0         0
    ## 4               0                0               0       0         0
    ## 5               0                0               0       0         0
    ##   G_TOTAL G_WHOLE G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT
    ## 1  0.9184  0.9184         0   0.0000       0.0000       0       0.0000
    ## 2  0.0000  0.0000         0   0.0000       0.0000       0       0.0000
    ## 3  0.0000  0.0000         0   0.0000       0.0000       0       0.0000
    ## 4  0.0000  0.0000         0   9.3564       3.3222       0       3.3222
    ## 5  0.0000  0.0000         0   0.0000       0.0000       0       0.0000
    ##   PF_ORGAN PF_POULT PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS
    ## 1        0        0           0            0  0.0000      0         0
    ## 2        0        0           0            0  0.0000      0         0
    ## 3        0        0           0            0  0.0000      0         0
    ## 4        0        0           0            0  6.0342      0         0
    ## 5        0        0           0            0  0.0000      0         0
    ##   PF_LEGUMES D_TOTAL D_MILK D_YOGURT D_CHEESE    OILS SOLID_FATS
    ## 1          0  0.0000 0.0000        0   0.0000  0.0000     0.0000
    ## 2          0  1.0004 1.0004        0   0.0000  0.0000     3.3428
    ## 3          0  0.0000 0.0000        0   0.0000  0.0000     0.0000
    ## 4          0  1.6272 0.4068        0   1.2204 20.4756    45.9684
    ## 5          0  0.0000 0.0000        0   0.0000  0.0000     0.0000
    ##   ADD_SUGARS A_DRINKS FoodComp
    ## 1     0.1988        0        1
    ## 2     0.0000        0        1
    ## 3     0.0000        0        1
    ## 4     0.0000        0        1
    ## 5     0.0000        0        1
    ##                                                                     Food_Description
    ## 1                                                                           Cheerios
    ## 2                                                         Milk, cow's, fluid, 2% fat
    ## 3                                                                        Banana, raw
    ## 4 Egg omelet or scrambled egg, with cheese, meat, and tomatoes, fat added in cooking
    ## 5                                       Orange juice, canned, bottled or in a carton

    items[-1,] #get everything EXCEPT the first row

    ##                             RecallRecId UserName
    ## 2  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 3  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 4  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 5  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 6  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 7  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 8  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 9  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 10 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 11 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 12 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 13 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 14 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 15 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 16 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 17 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 18 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 19 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 20 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 21 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 22 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 23 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 24 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 25 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 26 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 27 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 28 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 29 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 30 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 31 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 32 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 33 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 34 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 35 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 36 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 37 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 38 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 39 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 40 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 41 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 42 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 43 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 44 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 45 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 46 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 47 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 49 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 50 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 51 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 2  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 3  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 4  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 5  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 6  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 7  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 8  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 9  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 10 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 11 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 12 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 13 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 14 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 15 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 16 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 17 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 18 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 19 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 20 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 21 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 22 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 23 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 24 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 25 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 26 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 27 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 28 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 29 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 30 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 31 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 32 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 33 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 34 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 35 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 36 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 37 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 38 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 39 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 40 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 41 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 42 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 43 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 44 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 45 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 46 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 47 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 49 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 50 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 51 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 2             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 3             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 4             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 5             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 6             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 7             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 8             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 9             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 10            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 11            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 12            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 13            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 14            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 15            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 16            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 17            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 18            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 19            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 20            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 21            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 22            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 23            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 24            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 25            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 26            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 27            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 28            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 29            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 30            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 31            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 32            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 33            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 34            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 35            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 36            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 37            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 38            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 39            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 40            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 41            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 42            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 43            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 44            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 45            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 46            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 47            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 49            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 50            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 51            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No         Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 2       1 05/20/2018 11:00        1       4                  1        1
    ## 3       1 05/20/2018 11:00        1       4                  1        1
    ## 4       1 05/20/2018 11:00        1       4                  1        1
    ## 5       1 05/20/2018 11:00        1       4                  1        1
    ## 6       1 05/20/2018 11:00        1       4                  1        1
    ## 7       1 05/20/2018 11:00        1       4                  1        1
    ## 8       1 05/20/2018 11:00        1       4                  1        1
    ## 9       2 05/20/2018 14:00        6       1                  4        6
    ## 10      2 05/20/2018 14:00        6       1                  4        6
    ## 11      3 05/20/2018 17:00        3       2                  3        3
    ## 12      3 05/20/2018 17:00        3       2                  3        3
    ## 13      3 05/20/2018 17:00        3       2                  3        3
    ## 14      3 05/20/2018 17:00        3       2                  3        3
    ## 15      3 05/20/2018 17:00        3       2                  3        3
    ## 16      3 05/20/2018 17:00        3       2                  3        3
    ## 17      3 05/20/2018 17:00        3       2                  3        3
    ## 18      3 05/20/2018 17:00        3       2                  3        3
    ## 19      3 05/20/2018 17:00        3       2                  3        3
    ## 20      3 05/20/2018 17:00        3       2                  3        3
    ## 21      3 05/20/2018 17:00        3       2                  3        3
    ## 22      3 05/20/2018 17:00        3       2                  3        3
    ## 23      3 05/20/2018 17:00        3       2                  3        3
    ## 24      3 05/20/2018 17:00        3       2                  3        3
    ## 25      3 05/20/2018 17:00        3       2                  3        3
    ## 26      3 05/20/2018 17:00        3       2                  3        3
    ## 27      3 05/20/2018 17:00        3       2                  3        3
    ## 28      4 05/20/2018 19:30        6       1                  2        7
    ## 29      4 05/20/2018 19:30        6       1                  2        7
    ## 30      5 05/20/2018 22:00        5       1                  6        1
    ## 31      5 05/20/2018 22:00        5       1                  6        1
    ## 32      5 05/20/2018 22:00        5       1                  6        1
    ## 33      5 05/20/2018 22:00        5       1                  6        1
    ## 34      5 05/20/2018 22:00        5       1                  6        1
    ## 35      5 05/20/2018 22:00        5       1                  6        1
    ## 36      5 05/20/2018 22:00        5       1                  6        1
    ## 37      5 05/20/2018 22:00        5       1                  6        1
    ## 38      5 05/20/2018 22:00        5       1                  6        1
    ## 39      6  05/21/2018 0:00        6       1                  4       98
    ## 40      6  05/21/2018 0:00        6       1                  4       98
    ## 41      7  05/21/2018 2:00        7       1                  4        1
    ## 42      7  05/21/2018 2:00        7       1                  4        1
    ## 43      7  05/21/2018 2:00        7       1                  4        1
    ## 44      7  05/21/2018 2:00        7       1                  4        1
    ## 45      7  05/21/2018 2:00        7       1                  4        1
    ## 46      8  05/21/2018 3:00        6       3                  5        1
    ## 47      8  05/21/2018 3:00        6       3                  5        1
    ## 48      8  05/21/2018 3:00        6       3                  5        1
    ## 49      8  05/21/2018 3:00        6       3                  5        1
    ## 50      8  05/21/2018 3:00        6       3                  5        1
    ## 51      8  05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType                           FoodSrce CodeNum FoodCode
    ## 2        2        2             Other store (any type)       2 11112110
    ## 3        3        2             Other store (any type)       3 63107010
    ## 4        4        1             Other store (any type)       4 32131000
    ## 5        5        1             Other store (any type)       5 61210220
    ## 6        6        1             Other store (any type)       6 92101000
    ## 7        7        2             Other store (any type)       7 12210200
    ## 8        8        2             Other store (any type)       8 91101010
    ## 9        9        1                    Other cafeteria       9 94100100
    ## 10      10        1                    Other cafeteria      10 91746100
    ## 11      11        1                                         11 58106725
    ## 12      12        1                                         12 92410310
    ## 13      13        1                                         13 13110120
    ## 14      14        1                                         14 21501000
    ## 15      14        1                                         15 51320500
    ## 16      14        1                                         16 75506010
    ## 17      14        1                                         17 75117020
    ## 18      14        1                                         18 14104100
    ## 19      15        1                                         19 75113080
    ## 20      15        1                                         20 72116000
    ## 21      15        1                                         21 14104100
    ## 22      15        1                                         22 14010000
    ## 23      15        1                                         23 75117020
    ## 24      15        1                                         24 75122100
    ## 25      15        1                                         25 43102000
    ## 26      15        1                                         26 51185000
    ## 27      15        1                                         27 83112500
    ## 28      16        1             Other store (any type)      28 93101000
    ## 29      17        1                              Other      29 71201015
    ## 30      18        1    Other restaurant, bar or tavern      30 75113000
    ## 31      19        1    Other restaurant, bar or tavern      31 27345310
    ## 32      20        1    Other restaurant, bar or tavern      32 27116100
    ## 33      20        1    Other restaurant, bar or tavern      33 56205002
    ## 34      21        1    Other restaurant, bar or tavern      34 92302000
    ## 35      22        2    Other restaurant, bar or tavern      35 91104200
    ## 36      23        1    Other restaurant, bar or tavern      36 75205033
    ## 37      24        1    Other restaurant, bar or tavern      37 75216111
    ## 38      25        2    Other restaurant, bar or tavern      38 81103080
    ## 39      26        1                        Other: Gift      39 91745020
    ## 40      27        1                        Other: Gift      40 53206020
    ## 41      28        1 Fast food or drive-thru restaurant      41 13110100
    ## 42      28        1 Fast food or drive-thru restaurant      42 11111000
    ## 43      28        1 Fast food or drive-thru restaurant      43 63223020
    ## 44      28        1 Fast food or drive-thru restaurant      44 91302010
    ## 45      28        1 Fast food or drive-thru restaurant      45 91101000
    ## 46      29        1             Other store (any type)      46 51301010
    ## 47      29        1             Other store (any type)      47 83107000
    ## 48      29        1             Other store (any type)      48 25230210
    ## 49      29        1             Other store (any type)      49 14410130
    ## 50      29        1             Other store (any type)      50 14104110
    ## 51      29        1             Other store (any type)      51 14106200
    ##    ModCode  HowMany SubCode PortionCode   FoodAmt       KCAL        PROT
    ## 2        0  1.00000       0       10205 244.00000  122.00000  8.05200000
    ## 3        0  8.00000       0       61935  48.00000   42.72000  0.52320000
    ## 4        0  6.00000       0       61009 678.00000 1240.74000 79.32600000
    ## 5        0  9.60000       0       30000 298.56000  146.29440  2.03020800
    ## 6        0 12.00000       0       30000 355.20000    3.55200  0.42624000
    ## 7        0 12.00000       0       63480  30.00000   40.80000  0.30000000
    ## 8        0  2.00000       0       22000   8.40000   32.50800  0.00000000
    ## 9        0 10.14000       0       30000 300.14400    0.00000  0.00000000
    ## 10       0  1.00000       0       61538  48.00000  236.16000  2.07840000
    ## 11       0  2.00000       0       64369 204.00000  497.76000 22.48080000
    ## 12       0 24.00000       0       30000 736.80000  272.61600  0.51576000
    ## 13       0  2.00000       0       61396 240.00000  597.60000  8.40000000
    ## 14       0  2.00000       0       64195 158.00000  388.68000 36.75080000
    ## 15       0  2.00000       0       60847 104.00000  283.92000  8.94400000
    ## 16       0  4.00000       0       22000  20.00000   13.40000  0.87400000
    ## 17       0  4.00000       0       61401  56.00000   22.40000  0.61600000
    ## 18       0 85.05000       0          98  85.05000  342.75150 21.17745000
    ## 19       0  1.25000       0       10205  25.00000    6.25000  0.64500000
    ## 20       0  1.25000       0       10346  58.75000   11.16250  0.81662500
    ## 21       0  0.25000       0       10010  28.25000  113.84750  7.03425000
    ## 22       0  0.12500       0       10205  14.12500   47.74250  3.20920000
    ## 23       0  0.15625       0       10010  25.00000   10.00000  0.27500000
    ## 24       0  0.31250       0       10010  46.56250    9.31250  0.40043750
    ## 25       0  0.15625       0       10111  22.50000  131.40000  4.67550000
    ## 26       0  0.15750       0       10205   6.30000   29.29500  0.68040000
    ## 27       0  2.00000       0       21000  29.40000  123.77400  0.38808000
    ## 28       0 16.00000       0       30000 480.00000  206.40000  2.20800000
    ## 29       0  4.00000       0       10247 100.00000  542.00000  6.56000000
    ## 30       0  1.00000       0       10160  55.00000    7.70000  0.49500000
    ## 31       0  1.50000       0       10205 325.50000  416.64000 32.90805000
    ## 32       0  1.00000       0       10205 236.00000  247.80000 14.91520000
    ## 33       0  1.50000       0       10043 244.50000  366.75000  6.35700000
    ## 34       0  9.60000       0       30000 284.16000    2.84160  0.00000000
    ## 35       0  2.00000       0       22000   8.20000   31.16000  0.00984000
    ## 36  200058  0.50000       0       10029  79.00000   36.34000  0.98750000
    ## 37       0  2.00000       0       61345 200.00000  190.00000  6.78000000
    ## 38       0  0.66660       0       21000   9.53238   50.80759  0.01620505
    ## 39       0  5.00000 1000179       61667  10.00000   39.40000  0.00000000
    ## 40       0  2.00000       0       61238  60.00000  294.00000  3.48000000
    ## 41       0  2.25000       0       61396 270.00000  558.90000  9.45000000
    ## 42       0  0.37500       0       10205  91.50000   55.81500  2.88225000
    ## 43       0  3.00000       0       61241  36.00000   11.52000  0.24120000
    ## 44       0  1.50000       0       21000  31.50000   95.76000  0.09450000
    ## 45       0  0.75000       0       22000   3.15000   12.19050  0.00000000
    ## 46       0  1.50000       0       64355  42.00000  113.40000  4.35540000
    ## 47       0  0.75000       0       21000  10.35000   70.38000  0.09936000
    ## 48       0  1.50000       0       62008  42.00000   55.02000  7.11060000
    ## 49       0 15.94687       0          98  15.94687   20.09306  3.35681719
    ## 50       0 15.94687       0          98  15.94687   49.27584  4.36147031
    ## 51       0 15.94687       0          98  15.94687   59.48184  3.90379500
    ##           TFAT        CARB       MOIS   ALC    CAFF    THEO        SUGR
    ## 2   4.83120000 11.71200000 217.672400  0.00   0.000  0.0000 12.34640000
    ## 3   0.15840000 10.96320000  35.956800  0.00   0.000  0.0000  5.87040000
    ## 4  93.83520000 17.62800000 473.786400  0.00   0.000  0.0000 11.39040000
    ## 5   0.35827200 34.45382400 260.404032  0.00   0.000  0.0000 24.81033600
    ## 6   0.07104000  0.00000000 353.033280  0.00 142.080  0.0000  0.00000000
    ## 7   2.99100000  3.41400000  23.181000  0.00   0.000  0.0000  3.41400000
    ## 8   0.00000000  8.39832000   0.001680  0.00   0.000  0.0000  8.38320000
    ## 9   0.00000000  0.00000000 300.083971  0.00   0.000  0.0000  0.00000000
    ## 10 10.14240000 34.17120000   0.816000  0.00   6.720 68.6400 30.56640000
    ## 11 22.23600000 51.77520000 102.816000  0.00   0.000  0.0000  7.60920000
    ## 12  0.14736000 70.43808000 665.404080  0.00  58.944  0.0000 66.09096000
    ## 13 38.88000000 53.49600000 137.280000  0.00   0.000  0.0000 49.56000000
    ## 14 25.75400000  0.00000000  91.956000  0.00   0.000  0.0000  0.00000000
    ## 15  6.55200000 47.84000000  38.480000  0.00   0.000  0.0000  1.69520000
    ## 16  0.80200000  1.06600000  16.530000  0.00   0.000  0.0000  0.17200000
    ## 17  0.05600000  5.23040000  49.901600  0.00   0.000  0.0000  2.37440000
    ## 18 28.18557000  1.08864000  31.255875  0.00   0.000  0.0000  0.44226000
    ## 19  0.16500000  0.91250000  22.927500  0.00   0.000  0.0000  0.51250000
    ## 20  0.15862500  2.22075000  54.913625  0.00   0.000  0.0000  0.41712500
    ## 21  9.36205000  0.36160000  10.381875  0.00   0.000  0.0000  0.14690000
    ## 22  3.62730000  0.53957500   6.097762  0.00   0.000  0.0000  0.35171250
    ## 23  0.02500000  2.33500000  22.277500  0.00   0.000  0.0000  1.06000000
    ## 24  0.07915625  2.16050000  43.717531  0.00   0.000  0.0000  1.11750000
    ## 25 11.57850000  4.50000000   1.064250  0.00   0.000  0.0000  0.58950000
    ## 26  1.15290000  4.00050000   0.226800  0.00   0.000  0.0000  0.27783000
    ## 27 13.09476000  1.68756000  13.479900  0.00   0.000  0.0000  1.37886000
    ## 28  0.00000000 17.04000000 441.408000 18.72   0.000  0.0000  0.00000000
    ## 29 36.40000000 50.81000000   2.280000  0.00   0.000  0.0000  0.37000000
    ## 30  0.07700000  1.63350000  52.602000  0.00   0.000  0.0000  1.08350000
    ## 31 20.14845000 26.20275000 242.399850  0.00   0.000  0.0000  4.75230000
    ## 32 14.06560000 16.26040000 188.894400  0.00   0.000  0.0000  3.46920000
    ## 33  7.45725000 66.55290000 161.663400  0.00   0.000  0.0000  0.12225000
    ## 34  0.00000000  0.85248000 283.307520  0.00  56.832  5.6832  0.00000000
    ## 35  0.00000000  8.04338000   0.109880  0.00   0.000  0.0000  7.95564000
    ## 36  2.20410000  3.25480000  71.732000  0.00   0.000  0.0000  1.00330000
    ## 37  2.98000000 41.72000000 145.960000  0.00   0.000  0.0000  9.02000000
    ## 38  5.70131648  0.08197847   3.582268  0.00   0.000  0.0000  0.00000000
    ## 39  0.02000000  9.80000000   0.130000  0.00   0.000  0.0000  6.29000000
    ## 40 16.90800000 35.58600000   3.084000  0.00   8.400 66.6000 24.63600000
    ## 41 29.70000000 63.72000000 164.700000  0.00   0.000  0.0000 57.29400000
    ## 42  2.97375000  4.39200000  80.638950  0.00   0.000  0.0000  4.62075000
    ## 43  0.10800000  2.76480000  32.742000  0.00   0.000  0.0000  1.76040000
    ## 44  0.00000000 25.95600000   5.386500  0.00   0.000  0.0000 25.86780000
    ## 45  0.00000000  3.14937000   0.000630  0.00   0.000  0.0000  3.14370000
    ## 46  1.44480000 20.77320000  14.502600  0.00   0.000  0.0000  2.55360000
    ## 47  7.74697500  0.05899500   2.240775  0.00   0.000  0.0000  0.05899500
    ## 48  1.47000000  0.40740000  31.512600  0.00   0.000  0.0000  0.00000000
    ## 49  0.00000000  1.67920594  10.440419  0.00   0.000  0.0000  0.83880562
    ## 50  3.25475719  0.64744312   7.062871  0.00   0.000  0.0000  0.04146187
    ## 51  4.82871375  0.10843875   6.539813  0.00   0.000  0.0000  0.07973437
    ##         FIBE      CALC       IRON        MAGN        PHOS        POTA
    ## 2  0.0000000 292.80000 0.04880000  26.8400000  224.480000  341.600000
    ## 3  1.2480000   2.40000 0.12480000  12.9600000   10.560000  171.840000
    ## 4  2.0340000 691.56000 7.39020000 101.7000000 1213.620000 1450.920000
    ## 5  0.8956800  32.84160 0.38812800  32.8416000   50.755200  531.436800
    ## 6  0.0000000   7.10400 0.03552000  10.6560000   10.656000  174.048000
    ## 7  0.0000000   2.70000 0.00900000   0.0000000   19.200000   57.300000
    ## 8  0.0000000   0.08400 0.00420000   0.0000000    0.000000    0.168000
    ## 9  0.0000000  30.01440 0.00000000   6.0028800    0.000000    0.000000
    ## 10 1.3440000  50.40000 0.53280000  21.1200000   70.080000  125.280000
    ## 11 4.4880000 244.80000 3.79440000  46.9200000  373.320000  375.360000
    ## 12 0.0000000  14.73600 0.81048000   0.0000000   73.680000   14.736000
    ## 13 0.0000000 280.80000 0.81600000  26.4000000  252.000000  376.800000
    ## 14 0.0000000  50.56000 3.91840000  31.6000000  311.260000  504.020000
    ## 15 3.9520000 183.04000 3.69200000  37.4400000  108.160000  119.600000
    ## 16 0.6600000  11.60000 0.30200000   9.8000000   21.200000   27.600000
    ## 17 0.9520000  12.88000 0.11760000   5.6000000   16.240000   81.760000
    ## 18 0.0000000 613.21050 0.57834000  23.8140000  435.456000   83.349000
    ## 19 0.4000000  40.00000 0.36500000  11.7500000   13.000000   92.250000
    ## 20 1.8212500  36.42500 0.52875000  11.7500000   20.562500  192.112500
    ## 21 0.0000000 203.68250 0.19210000   7.9100000  144.640000   27.685000
    ## 22 0.0000000 134.18750 0.09181250   4.0962500   85.173750   20.763750
    ## 23 0.4250000   5.75000 0.05250000   2.5000000    7.250000   36.500000
    ## 24 0.7915625   4.65625 0.15831250   4.6562500    9.312500   81.484375
    ## 25 1.9350000  17.55000 1.18125000  73.1250000  148.500000  145.125000
    ## 26 0.3150000   6.04800 0.17766000   2.6460000    8.820000   11.403000
    ## 27 0.0000000   8.23200 0.08820000   1.4700000   53.802000   18.816000
    ## 28 0.0000000  19.20000 0.09600000  28.8000000   67.200000  129.600000
    ## 29 4.4000000  24.00000 1.61000000  70.0000000  155.000000 1642.000000
    ## 30 0.6600000   9.90000 0.22550000   3.8500000   11.000000   77.550000
    ## 31 3.9060000  71.61000 1.95300000  58.5900000  318.990000  732.375000
    ## 32 4.0120000  77.88000 2.59600000  49.5600000  148.680000  531.000000
    ## 33 0.9780000  24.45000 2.83620000  29.3400000  102.690000   83.130000
    ## 34 0.0000000   0.00000 0.05683200   8.5248000    2.841600  105.139200
    ## 35 0.0000000   6.80600 0.05822000   0.7380000    0.328000   10.906000
    ## 36 1.8960000  30.02000 0.67150000  10.2700000   16.590000   82.160000
    ## 37 4.8000000   6.00000 0.90000000  52.0000000  154.000000  434.000000
    ## 38 0.0000000   2.00180 0.00000000   0.1906476    1.525181    2.859714
    ## 39 0.0000000   0.30000 0.03000000   0.3000000    0.300000    0.500000
    ## 40 1.6200000  25.20000 1.31400000  31.2000000   66.600000  114.600000
    ## 41 1.8900000 345.60000 0.24300000  37.8000000  283.500000  537.300000
    ## 42 0.0000000 103.39500 0.02745000   9.1500000   76.860000  120.780000
    ## 43 0.7200000   5.76000 0.14760000   4.6800000    8.640000   55.080000
    ## 44 0.0630000   1.89000 0.13230000   0.6300000    1.260000   16.380000
    ## 45 0.0000000   0.03150 0.00157500   0.0000000    0.000000    0.063000
    ## 46 1.7640000  57.96000 1.47840000  19.3200000   64.260000   76.440000
    ## 47 0.0000000   0.82800 0.02173500   0.1035000    2.173500    2.070000
    ## 48 0.0000000   2.10000 0.24360000   7.5600000  109.620000  194.040000
    ## 49 0.0000000 125.82084 0.00000000  18.3389062   50.392125   62.671219
    ## 50 0.0000000 121.35572 0.01913625   4.3056563   82.923750   10.046531
    ## 51 0.0000000 118.96369 0.11481750   4.3056563   70.804125   12.916969
    ##           SODI       ZINC        COPP       SELE           VC          VB1
    ## 2   114.680000 1.17120000 0.014640000   6.100000   0.48800000 0.0951600000
    ## 3     0.480000 0.07200000 0.037440000   0.480000   4.17600000 0.0148800000
    ## 4  2922.180000 9.01740000 0.440700000 130.176000  23.73000000 0.7458000000
    ## 5     5.971200 0.20899200 0.125395200   0.298560 100.31616000 0.1373376000
    ## 6     7.104000 0.07104000 0.007104000   0.000000   0.00000000 0.0497280000
    ## 7    20.100000 0.00600000 0.000000000   0.330000   0.00000000 0.0000000000
    ## 8     0.084000 0.00084000 0.000588000   0.050400   0.00000000 0.0000000000
    ## 9     6.002880 0.00000000 0.021010080   0.000000   0.00000000 0.0000000000
    ## 10   29.280000 0.77280000 0.165120000   1.584000   0.24000000 0.0379200000
    ## 11 1201.560000 2.52960000 0.281520000  47.124000   0.20400000 0.5222400000
    ## 12   29.472000 0.14736000 0.007368000   0.736800   0.00000000 0.0000000000
    ## 13  146.400000 1.12800000 0.019200000   8.400000   0.00000000 0.0984000000
    ## 14  646.220000 9.32200000 0.112180000  30.652000   0.00000000 0.0679400000
    ## 15  544.960000 0.93600000 0.156000000  34.320000   0.00000000 0.4503200000
    ## 16  227.000000 0.12800000 0.017000000   6.580000   0.30000000 0.0686000000
    ## 17    2.240000 0.09520000 0.021840000   0.280000   4.14400000 0.0257600000
    ## 18  528.160500 2.64505500 0.026365500  11.821950   0.00000000 0.0229635000
    ## 19    6.750000 0.11750000 0.019000000   0.075000   3.75000000 0.0110000000
    ## 20   14.687500 0.28200000 0.086362500   0.176250   6.75625000 0.0417125000
    ## 21  175.432500 0.87857500 0.008757500   3.926750   0.00000000 0.0076275000
    ## 22  115.260000 0.38702500 0.004520000   2.090500   0.00000000 0.0040962500
    ## 23    1.000000 0.04250000 0.009750000   0.125000   1.85000000 0.0115000000
    ## 24    1.396875 0.06053125 0.030731250   0.000000  37.43625000 0.0265406250
    ## 25    2.025000 1.12500000 0.405000000  11.925000   0.31500000 0.3330000000
    ## 26   68.607000 0.05922000 0.010584000   1.814400   0.00000000 0.0318780000
    ## 27  264.894000 0.04998000 0.005586000   1.029000   0.00000000 0.0044100000
    ## 28   19.200000 0.04800000 0.024000000   2.880000   0.00000000 0.0240000000
    ## 29  450.000000 2.39000000 0.398000000   8.100000  18.60000000 0.0630000000
    ## 30    5.500000 0.08250000 0.013750000   0.055000   1.54000000 0.0225500000
    ## 31  764.925000 1.95300000 0.172515000  36.781500  35.15400000 0.2441250000
    ## 32  202.960000 3.28040000 0.212400000  12.508000  23.12800000 0.1416000000
    ## 33  581.910000 1.14915000 0.163815000  17.604000   0.00000000 0.3838650000
    ## 34    8.524800 0.05683200 0.028416000   0.000000   0.00000000 0.0000000000
    ## 35    2.296000 0.00246000 0.003854000   0.098400   0.00000000 0.0000000000
    ## 36  203.820000 0.16590000 0.030020000   0.316000   1.89600000 0.0118500000
    ## 37  454.000000 1.24000000 0.098000000   0.400000  11.00000000 0.1840000000
    ## 38   61.007232 0.00000000 0.000000000   0.000000   0.00953238 0.0006672666
    ## 39    3.800000 0.00100000 0.002900000   0.060000   0.00000000 0.0004000000
    ## 40  168.600000 0.59400000 0.236400000   6.300000   0.06000000 0.1026000000
    ## 41  216.000000 1.86300000 0.062100000   4.860000   1.62000000 0.1107000000
    ## 42   39.345000 0.33855000 0.022875000   3.385500   0.00000000 0.0420900000
    ## 43    0.360000 0.05040000 0.017280000   0.144000  21.16800000 0.0086400000
    ## 44    1.260000 0.06930000 0.011340000   0.252000   0.15750000 0.0000000000
    ## 45    0.031500 0.00031500 0.000220500   0.018900   0.00000000 0.0000000000
    ## 46  217.980000 0.49560000 0.067620000  12.096000   0.08400000 0.1978200000
    ## 47   65.722500 0.01552500 0.001966500   0.238050   0.00000000 0.0010350000
    ## 48  551.880000 0.65940000 0.072660000  13.272000   0.00000000 0.1411200000
    ## 49  209.860875 0.65541656 0.089143031   2.328244   0.00000000 0.0657011250
    ## 50  100.146375 0.70804125 0.006857156   5.708981   0.00000000 0.0033488437
    ## 51   95.681250 0.47840625 0.005103000   2.312297   0.00000000 0.0023920312
    ##            VB2         NIAC        VB6        FOLA      FA          FF
    ## 2  0.451400000  0.224480000 0.09272000  12.2000000   0.000  12.2000000
    ## 3  0.035040000  0.319200000 0.17616000   9.6000000   0.000   9.6000000
    ## 4  1.939080000  8.210580000 1.04412000 142.3800000   0.000 142.3800000
    ## 5  0.116438400  0.835968000 0.22690560  56.7264000   0.000  56.7264000
    ## 6  0.269952000  0.678432000 0.00355200   7.1040000   0.000   7.1040000
    ## 7  0.000000000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 8  0.001596000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 9  0.000000000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 10 0.102240000  0.129600000 0.01200000   3.8400000   0.000   3.8400000
    ## 11 0.542640000  6.324000000 0.19992000 126.4800000  73.440  53.0400000
    ## 12 0.000000000  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 13 0.400800000  0.196800000 0.10800000  19.2000000   0.000  19.2000000
    ## 14 0.276500000  8.276040000 0.53878000  15.8000000   0.000  15.8000000
    ## 15 0.283920000  4.234880000 0.07904000  62.4000000  46.800  15.6000000
    ## 16 0.006000000  0.104600000 0.01260000   1.4000000   0.000   1.4000000
    ## 17 0.015120000  0.064960000 0.06720000  10.6400000   0.000  10.6400000
    ## 18 0.318937500  0.068040000 0.06293700  15.3090000   0.000  15.3090000
    ## 19 0.021500000  0.076250000 0.01825000  24.2500000   0.000  24.2500000
    ## 20 0.047587500  0.237350000 0.03877500  75.7875000   0.000  75.7875000
    ## 21 0.105937500  0.022600000 0.02090500   5.0850000   0.000   5.0850000
    ## 22 0.052968750  0.015961250 0.01243000   2.2600000   0.000   2.2600000
    ## 23 0.006750000  0.029000000 0.03000000   4.7500000   0.000   4.7500000
    ## 24 0.013037500  0.223500000 0.10430000   4.6562500   0.000   4.6562500
    ## 25 0.079875000  1.875375000 0.30262500  51.0750000   0.000  51.0750000
    ## 26 0.026523000  0.292698000 0.00522900   6.6150000   4.095   2.5200000
    ## 27 0.025578000  0.015876000 0.00882000   1.1760000   0.000   1.1760000
    ## 28 0.120000000  2.462400000 0.22080000  28.8000000   0.000  28.8000000
    ## 29 0.230000000  4.182000000 0.72300000  75.0000000   0.000  75.0000000
    ## 30 0.013750000  0.067650000 0.02310000  15.9500000   0.000  15.9500000
    ## 31 0.341775000 10.289055000 1.04811000  94.3950000  26.040  71.6100000
    ## 32 0.179360000  2.751760000 0.42008000  66.0800000   0.000  66.0800000
    ## 33 0.031785000  3.486570000 0.22005000 136.9200000 129.585   7.3350000
    ## 34 0.039782400  0.000000000 0.00000000  14.2080000   0.000  14.2080000
    ## 35 0.000000000  0.009020000 0.00336200   0.0820000   0.000   0.0820000
    ## 36 0.035550000  0.158000000 0.02291000  20.5400000   0.000  20.5400000
    ## 37 0.114000000  3.346000000 0.27600000  46.0000000   0.000  46.0000000
    ## 38 0.002478419  0.001525181 0.35746425   0.0953238   0.000   0.0953238
    ## 39 0.000300000  0.000700000 0.00030000   0.0000000   0.000   0.0000000
    ## 40 0.096600000  0.763800000 0.05760000  24.0000000  12.600  11.4000000
    ## 41 0.648000000  0.313200000 0.12960000  13.5000000   0.000  13.5000000
    ## 42 0.154635000  0.081435000 0.03294000   4.5750000   0.000   4.5750000
    ## 43 0.007920000  0.138960000 0.01692000   8.6400000   0.000   8.6400000
    ## 44 0.011970000  0.038115000 0.00756000   0.6300000   0.000   0.6300000
    ## 45 0.000598500  0.000000000 0.00000000   0.0000000   0.000   0.0000000
    ## 46 0.113400000  2.491860000 0.04494000  35.7000000   8.400  27.3000000
    ## 47 0.001966500  0.000000000 0.00082800   0.5175000   0.000   0.5175000
    ## 48 0.111720000  2.392740000 0.16548000   0.0000000   0.000   0.8400000
    ## 49 0.086910469  0.886646250 0.09041878   1.4352187   0.000   1.4352187
    ## 50 0.063309094  0.023122969 0.01339537   3.1893750   0.000   3.1893750
    ## 51 0.062192812  0.014830594 0.01259803   2.8704375   0.000   2.8704375
    ##           FDFE      VB12      VARA        RET         BCAR        ACAR
    ## 2   12.2000000 1.2932000 134.20000 134.200000    9.7600000    0.000000
    ## 3    9.6000000 0.0000000   1.44000   0.000000   12.4800000   12.000000
    ## 4  142.3800000 4.2036000 759.36000 684.780000  779.7000000  162.720000
    ## 5   56.7264000 0.0000000   5.97120   0.000000   23.8848000   23.884800
    ## 6    7.1040000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 7    0.0000000 0.0000000   0.30000   0.000000    2.7000000    0.000000
    ## 8    0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 9    0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 10   3.8400000 0.2544000  26.88000  26.880000    0.0000000    0.000000
    ## 11 177.4800000 1.3872000 124.44000 110.160000  165.2400000    0.000000
    ## 12   0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 13  21.6000000 0.9360000 436.80000 429.600000   76.8000000    2.400000
    ## 14  15.8000000 3.9500000   0.00000   0.000000    0.0000000    0.000000
    ## 15  95.6800000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 16   1.4000000 0.0000000   0.80000   0.000000    5.8000000    0.000000
    ## 17  10.6400000 0.0000000   0.00000   0.000000    0.5600000    0.000000
    ## 18  15.3090000 0.7059150 225.38250 219.429000   72.2925000    0.000000
    ## 19  24.2500000 0.0000000  29.75000   0.000000  356.0000000    0.000000
    ## 20  75.7875000 0.0000000 162.73750   0.000000 1949.9125000    0.000000
    ## 21   5.0850000 0.2344750  74.86250  72.885000   24.0125000    0.000000
    ## 22   2.2600000 0.1469000  32.20500  30.933750   13.7012500    0.000000
    ## 23   4.7500000 0.0000000   0.00000   0.000000    0.2500000    0.000000
    ## 24   4.6562500 0.0000000   8.38125   0.000000   96.8500000    9.778125
    ## 25  51.0750000 0.0000000   0.67500   0.000000    6.7500000    0.000000
    ## 26   9.5130000 0.0088200   0.44100   0.441000    0.3780000    0.000000
    ## 27   1.1760000 0.0529200   4.11600   3.822000    3.8220000    0.000000
    ## 28  28.8000000 0.0960000   0.00000   0.000000    0.0000000    0.000000
    ## 29  75.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 30  15.9500000 0.0000000  13.75000   0.000000  164.4500000    2.200000
    ## 31 113.9250000 0.2604000 439.42500   6.510000 4361.7000000 1656.795000
    ## 32  66.0800000 0.8732000 311.52000   0.000000 3282.7600000  901.520000
    ## 33 229.8300000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 34  14.2080000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 35   0.0820000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 36  20.5400000 0.0000000  30.02000  15.800000   97.1700000  119.290000
    ## 37  46.0000000 0.0000000  26.00000   0.000000  132.0000000   46.000000
    ## 38   0.0953238 1.0294970  78.07019  73.208678   58.1475180    0.000000
    ## 39   0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 40  33.0000000 0.0480000  70.20000  68.400000   15.6000000    0.000000
    ## 41  13.5000000 1.0530000 318.60000 313.200000   51.3000000    0.000000
    ## 42   4.5750000 0.4117500  42.09000  41.175000    6.4050000    0.000000
    ## 43   8.6400000 0.0000000   0.36000   0.000000    2.5200000    0.000000
    ## 44   0.6300000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 45   0.0000000 0.0000000   0.00000   0.000000    0.0000000    0.000000
    ## 46  41.5800000 0.0000000   0.00000   0.000000    0.4200000    0.000000
    ## 47   0.5175000 0.0124200   1.65600   1.552500    0.6210000    0.000000
    ## 48   0.8400000 0.1512000   0.00000   0.000000    0.0000000    0.000000
    ## 49   1.4352187 0.2950172   8.93025   8.770781    0.4784062    0.000000
    ## 50   3.1893750 0.2248509  23.12297  22.644562    4.4651250    0.000000
    ## 51   2.8704375 0.1323591  31.57481  30.618000   12.4385625    0.000000
    ##           CRYP     LYCO          LZ       ATOC           VK        CHOLE
    ## 2    0.0000000    0.000    0.000000 0.07320000   0.48800000   19.5200000
    ## 3    0.0000000    0.000   10.560000 0.04800000   0.24000000    0.0000000
    ## 4   27.1200000 4183.260 1715.340000 7.45800000  40.00200000 1274.6400000
    ## 5   80.6112000    0.000   80.611200 0.59712000   0.00000000    0.0000000
    ## 6    0.0000000    0.000    0.000000 0.03552000   0.35520000    0.0000000
    ## 7    0.0000000    0.000    0.000000 0.24300000   0.75000000    0.0000000
    ## 8    0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 9    0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 10   0.0000000    0.000    0.000000 0.17280000   1.92000000    6.7200000
    ## 11   0.0000000 3445.560   53.040000 1.75440000  12.64800000   55.0800000
    ## 12   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 13   2.4000000    0.000   81.600000 1.22400000   3.12000000  220.8000000
    ## 14   0.0000000    0.000    0.000000 0.69520000   3.16000000  129.5600000
    ## 15   0.0000000    0.000   67.600000 0.37440000   2.80800000    0.0000000
    ## 16   5.2000000    0.000    3.600000 0.07200000   0.36000000    0.0000000
    ## 17   0.0000000    0.000    2.240000 0.01120000   0.22400000    0.0000000
    ## 18   0.0000000    0.000    0.000000 0.24664500   2.38140000   89.3025000
    ## 19   0.0000000    0.000  888.750000 0.10750000  27.15000000    0.0000000
    ## 20   0.0000000    0.000 2469.850000 0.55225000 123.61000000    0.0000000
    ## 21   0.0000000    0.000    0.000000 0.08192500   0.79100000   29.6625000
    ## 22   1.2712500    0.000    3.813750 0.05650000   0.36725000   12.2887500
    ## 23   0.0000000    0.000    1.000000 0.00500000   0.10000000    0.0000000
    ## 24   3.2593750    0.000  158.778125 0.17228125   3.44562500    0.0000000
    ## 25   0.0000000    0.000    0.000000 7.91325000   0.00000000    0.0000000
    ## 26   0.0000000    0.000    2.835000 0.02520000   0.47880000    0.4410000
    ## 27   0.2940000    0.294    6.174000 0.65268000  36.80880000    7.6440000
    ## 28   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 29   0.0000000    0.000    0.000000 6.74000000  22.10000000    0.0000000
    ## 30   0.0000000    0.000  152.350000 0.09900000  13.25500000    0.0000000
    ## 31   0.0000000    0.000  911.400000 3.58050000 107.74050000  100.9050000
    ## 32   0.0000000  250.160 2461.480000 2.00600000 117.05600000   44.8400000
    ## 33   0.0000000    0.000    0.000000 0.92910000   7.57950000    0.0000000
    ## 34   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 35   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 36  18.1700000    0.000  346.020000 0.07900000  29.94100000    4.7400000
    ## 37 320.0000000    0.000 1802.000000 0.18000000   0.80000000    0.0000000
    ## 38   0.0000000    0.000    0.000000 2.01323866   9.65630094    0.0953238
    ## 39   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 40   0.6000000    0.000   25.200000 0.35400000   1.68000000   34.8000000
    ## 41   0.0000000    0.000    0.000000 0.81000000   0.81000000  118.8000000
    ## 42   0.0000000    0.000    0.000000 0.06405000   0.27450000    9.1500000
    ## 43   0.0000000    0.000    9.360000 0.10440000   0.79200000    0.0000000
    ## 44   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 45   0.0000000    0.000    0.000000 0.00000000   0.00000000    0.0000000
    ## 46   0.0000000    0.000   18.480000 0.07980000   2.05800000    0.0000000
    ## 47   0.4140000    0.000    1.242000 0.33948000  16.87050000    4.3470000
    ## 48   0.0000000    0.000    0.000000 0.12180000   0.00000000   17.2200000
    ## 49   0.0000000    0.000    0.000000 0.04305656   0.03189375    4.1461875
    ## 50   0.1594687    0.000    0.637875 0.07654500   0.23920312   12.1196250
    ## 51   0.0000000    0.000    0.000000 0.04146187   0.39867188   14.1927187
    ##           SFAT        S040         S060         S080        S100
    ## 2   3.06708000 0.187880000 0.0976000000 0.0488000000 0.119560000
    ## 3   0.05376000 0.000000000 0.0000000000 0.0000000000 0.000480000
    ## 4  32.64570000 0.616980000 0.3186600000 0.1898400000 0.400020000
    ## 5   0.04179840 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 6   0.00710400 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 7   0.58110000 0.000000000 0.0000000000 0.0015000000 0.003900000
    ## 8   0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 9   0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 10  6.27840000 0.221760000 0.0801600000 0.0456000000 0.086880000
    ## 11  8.99028000 0.299880000 0.0571200000 0.0795600000 0.189720000
    ## 12  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 13 24.78960000 1.178400000 0.6960000000 0.4056000000 0.912000000
    ## 14  9.96506000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 15  1.55688000 0.000000000 0.0000000000 0.0031200000 0.000000000
    ## 16  0.04960000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 17  0.02352000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 18 17.93874600 0.889623000 0.4499145000 0.2372895000 0.510300000
    ## 19  0.02150000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 20  0.03113750 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 21  5.95849000 0.295495000 0.1494425000 0.0788175000 0.169500000
    ## 22  2.26098875 0.104242500 0.0532512500 0.0323462500 0.071896250
    ## 23  0.01050000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 24  0.02700625 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 25  1.00237500 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 26  0.33056100 0.005796000 0.0021420000 0.0011340000 0.002835000
    ## 27  2.04741600 0.001764000 0.0011760000 0.0114660000 0.010584000
    ## 28  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 29  4.01400000 0.000000000 0.0000000000 0.0000000000 0.001000000
    ## 30  0.00990000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 31  3.04342500 0.000000000 0.0000000000 0.0000000000 0.019530000
    ## 32  3.84444000 0.002360000 0.0023600000 0.0023600000 0.023600000
    ## 33  1.07091000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 34  0.00568320 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 35  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 36  1.28217000 0.076630000 0.0474000000 0.0284400000 0.060040000
    ## 37  0.39200000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 38  1.15208345 0.001334533 0.0005719428 0.0008579142 0.006863314
    ## 39  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 40  7.78380000 0.298800000 0.1860000000 0.1104000000 0.234600000
    ## 41 18.33300000 0.972000000 0.5670000000 0.3240000000 0.756000000
    ## 42  1.70647500 0.068625000 0.0686250000 0.0686250000 0.068625000
    ## 43  0.00540000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 44  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 45  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 46  0.33726000 0.003360000 0.0004200000 0.0021000000 0.014280000
    ## 47  1.21126050 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 48  0.46746000 0.000000000 0.0016800000 0.0000000000 0.000000000
    ## 49  0.00000000 0.000000000 0.0000000000 0.0000000000 0.000000000
    ## 50  2.00962519 0.070006781 0.0575682187 0.0363588750 0.089780906
    ## 51  3.04043119 0.156598313 0.0389103750 0.0487974375 0.089780906
    ##          S120      S140        S160      S180       MFAT        M161
    ## 2  0.13420000 0.4270000  1.36152000 0.5929200  1.3664000 0.065880000
    ## 3  0.00096000 0.0009600  0.04896000 0.0024000  0.0153600 0.004800000
    ## 4  0.35256000 2.3391000 19.48572000 8.0071800 35.7984000 1.823820000
    ## 5  0.00000000 0.0000000  0.04179840 0.0000000  0.0656832 0.008956800
    ## 6  0.00000000 0.0000000  0.00710400 0.0000000  0.0532800 0.000000000
    ## 7  0.01860000 0.0057000  0.26520000 0.2928000  2.2653000 0.000000000
    ## 8  0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 9  0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 10 0.09552000 0.2923200  2.62320000 2.6904000  2.4878400 0.070560000
    ## 11 0.21828000 0.9118800  4.75320000 2.2440000  7.7254800 0.397800000
    ## 12 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 13 1.02000000 3.6624000 10.00320000 4.5576000 10.7040000 0.864000000
    ## 14 0.01896000 0.7631400  5.61216000 2.9403800 11.8452600 0.966960000
    ## 15 0.00000000 0.0280800  0.85800000 0.6583200  3.2333600 0.005200000
    ## 16 0.00060000 0.0008000  0.02800000 0.0092000  0.5254000 0.001800000
    ## 17 0.00000000 0.0022400  0.01904000 0.0022400  0.0072800 0.000000000
    ## 18 0.46012050 2.8321650  8.33745150 3.4079535  7.9870455 0.853902000
    ## 19 0.00075000 0.0000000  0.01800000 0.0010000  0.0122500 0.000250000
    ## 20 0.00000000 0.0011750  0.02702500 0.0017625  0.0041125 0.000587500
    ## 21 0.15283250 0.9407250  2.76934750 1.1319775  2.6529575 0.283630000
    ## 22 0.06893000 0.3599050  1.04652125 0.4237500  1.0168587 0.095202500
    ## 23 0.00000000 0.0010000  0.00850000 0.0010000  0.0032500 0.000000000
    ## 24 0.00000000 0.0000000  0.02328125 0.0037250  0.0037250 0.000000000
    ## 25 0.00000000 0.0056250  0.49725000 0.3802500  4.1688000 0.004500000
    ## 26 0.00384300 0.0177660  0.16594200 0.1274490  0.5983740 0.002961000
    ## 27 0.00382200 0.0188160  1.34975400 0.5386080  2.6948040 0.016170000
    ## 28 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 29 0.00800000 0.0060000  2.83000000 1.0840000 15.9990000 0.043000000
    ## 30 0.00000000 0.0000000  0.00880000 0.0011000  0.0033000 0.000550000
    ## 31 0.00651000 0.0195300  2.12551500 0.7063350  7.6720350 0.192045000
    ## 32 0.02360000 0.2525200  2.40956000 1.0620000  5.7867200 0.323320000
    ## 33 0.00000000 0.0048900  0.77262000 0.2249400  2.9535600 0.017115000
    ## 34 0.00000000 0.0000000  0.00284160 0.0000000  0.0028416 0.000000000
    ## 35 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 36 0.06162000 0.1761700  0.56959000 0.2456900  0.5095500 0.022910000
    ## 37 0.00000000 0.0000000  0.36800000 0.0240000  0.7440000 0.000000000
    ## 38 0.01906476 0.0156331  0.60616404 0.4533600  1.8443249 0.005147485
    ## 39 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 40 0.23940000 0.6924000  3.44700000 2.4528000  4.1274000 0.105600000
    ## 41 0.83700000 3.0510000  8.26200000 3.5532000  8.0163000 0.556200000
    ## 42 0.07045500 0.2717550  0.75853500 0.3339750  0.7429800 0.000000000
    ## 43 0.00000000 0.0000000  0.00432000 0.0010800  0.0154800 0.000360000
    ## 44 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 45 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 46 0.00546000 0.0058800  0.19362000 0.1003800  0.2696400 0.009240000
    ## 47 0.00000000 0.0056925  0.81858150 0.3207465  1.7432505 0.009108000
    ## 48 0.00000000 0.0189000  0.30576000 0.1411200  0.7077000 0.044520000
    ## 49 0.00000000 0.0000000  0.00000000 0.0000000  0.0000000 0.000000000
    ## 50 0.10221947 0.3269109  0.91838053 0.3442930  0.8458222 0.052146281
    ## 51 0.06346856 0.5761606  1.23795591 0.5458615  1.3955110 0.147189656
    ##          M181       M201         M221        PFAT        P182       P183
    ## 2   1.2395200 0.00488000 0.0000000000  0.17812000  0.15128000 0.01952000
    ## 3   0.0105600 0.00000000 0.0000000000  0.03504000  0.02208000 0.01296000
    ## 4  33.1881000 0.41358000 0.0067800000 19.62132000 16.59066000 1.74924000
    ## 5   0.0537408 0.00000000 0.0000000000  0.08956800  0.06866880 0.02089920
    ## 6   0.0000000 0.00000000 0.0000000000  0.00355200  0.00355200 0.00000000
    ## 7   2.2677000 0.00000000 0.0000000000  0.00810000  0.00660000 0.00000000
    ## 8   0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 9   0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 10  2.3697600 0.00000000 0.0000000000  0.44208000  0.41472000 0.02736000
    ## 11  7.1338800 0.08568000 0.0020400000  3.85560000  3.10284000 0.32028000
    ## 12  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 13  9.8352000 0.00480000 0.0000000000  1.63200000  1.04880000 0.53280000
    ## 14 10.0835600 0.09006000 0.0000000000  0.71890000  0.56248000 0.06952000
    ## 15  3.2281600 0.00000000 0.0000000000  1.15128000  1.09096000 0.06032000
    ## 16  0.1860000 0.06820000 0.2526000000  0.19080000  0.08860000 0.09160000
    ## 17  0.0072800 0.00000000 0.0000000000  0.00952000  0.00728000 0.00224000
    ## 18  6.7232025 0.00000000 0.0000000000  0.80117100  0.49073850 0.31043250
    ## 19  0.0115000 0.00000000 0.0000000000  0.07975000  0.03250000 0.04250000
    ## 20  0.0035250 0.00000000 0.0000000000  0.07402500  0.04582500 0.02820000
    ## 21  2.2331625 0.00000000 0.0000000000  0.26611500  0.16300250 0.10311250
    ## 22  0.8674162 0.00720375 0.0000000000  0.11624875  0.07924125 0.03262875
    ## 23  0.0032500 0.00000000 0.0000000000  0.00425000  0.00325000 0.00100000
    ## 24  0.0037250 0.00000000 0.0000000000  0.02886875  0.02514375 0.00372500
    ## 25  4.1355000 0.01912500 0.0065250000  5.20582500  5.18625000 0.01350000
    ## 26  0.5954130 0.00000000 0.0000000000  0.14918400  0.14030100 0.00894600
    ## 27  2.6210100 0.03557400 0.0144060000  7.54992000  6.53356200 0.99960000
    ## 28  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 29 15.9120000 0.04400000 0.0000000000 15.99800000 15.82700000 0.17200000
    ## 30  0.0022000 0.00000000 0.0000000000  0.04070000  0.01155000 0.02860000
    ## 31  7.1740200 0.10090500 0.0000000000  7.69156500  6.49047000 0.96999000
    ## 32  5.4138400 0.04484000 0.0000000000  3.13172000  2.61252000 0.50268000
    ## 33  2.8973250 0.03667500 0.0000000000  3.11737500  2.69683500 0.41809500
    ## 34  0.0000000 0.00000000 0.0000000000  0.01136640  0.00284160 0.00852480
    ## 35  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 36  0.4842700 0.00237000 0.0000000000  0.22199000  0.12087000 0.09875000
    ## 37  0.7440000 0.00000000 0.0000000000  1.19800000  1.16600000 0.03600000
    ## 38  1.8174436 0.01849282 0.0000000000  2.52388825  2.26260572 0.25880412
    ## 39  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 40  4.0008000 0.02040000 0.0000000000  4.00320000  3.28080000 0.70980000
    ## 41  7.4601000 0.00000000 0.0000000000  1.22040000  0.74250000 0.47250000
    ## 42  0.7429800 0.00000000 0.0000000000  0.17842500  0.10980000 0.06862500
    ## 43  0.0151200 0.00000000 0.0000000000  0.05580000  0.03240000 0.02340000
    ## 44  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 45  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 46  0.2524200 0.00714000 0.0000000000  0.67578000  0.61026000 0.06342000
    ## 47  1.7030925 0.02463300 0.0022770000  4.62541500  4.05161100 0.56469600
    ## 48  0.6531000 0.01008000 0.0000000000  0.14700000  0.13440000 0.00672000
    ## 49  0.0000000 0.00000000 0.0000000000  0.00000000  0.00000000 0.00000000
    ## 50  0.7477490 0.00637875 0.0003189375  0.14240559  0.11848528 0.01020600
    ## 51  1.1749657 0.00000000 0.0000000000  0.14336241  0.10158159 0.04162134
    ##         P184        P204         P205        P225       P226       VITD
    ## 2  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 2.92800000
    ## 3  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 4  0.0000000 0.657660000 0.0000000000 0.040680000 0.17628000 8.81400000
    ## 5  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 6  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 7  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 8  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 9  0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 10 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 11 0.0591600 0.044880000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 12 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 13 0.0024000 0.033600000 0.0024000000 0.000000000 0.00960000 0.72000000
    ## 14 0.0000000 0.063200000 0.0047400000 0.025280000 0.00158000 0.31600000
    ## 15 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 16 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 17 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 18 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.51030000
    ## 19 0.0000000 0.000500000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 20 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 21 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.16950000
    ## 22 0.0002825 0.001130000 0.0004237500 0.000565000 0.00014125 0.33900000
    ## 23 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 24 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 25 0.0031500 0.000000000 0.0031500000 0.000000000 0.00000000 0.00000000
    ## 26 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 27 0.0000000 0.008820000 0.0000000000 0.000000000 0.00117600 0.02940000
    ## 28 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 29 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 30 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 31 0.0000000 0.074865000 0.0032550000 0.009765000 0.00651000 0.00000000
    ## 32 0.0000000 0.009440000 0.0000000000 0.007080000 0.00000000 0.00000000
    ## 33 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 34 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 35 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 36 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 37 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 38 0.0000000 0.000000000 0.0000000000 0.000476619 0.00000000 0.15251808
    ## 39 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 40 0.0000000 0.007800000 0.0000000000 0.000000000 0.00240000 0.24000000
    ## 41 0.0000000 0.000000000 0.0081000000 0.000000000 0.00000000 0.54000000
    ## 42 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 1.18950000
    ## 43 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 44 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 45 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.00000000
    ## 46 0.0000000 0.001260000 0.0008400000 0.000000000 0.00000000 0.00000000
    ## 47 0.0000000 0.005175000 0.0000000000 0.000000000 0.00051750 0.02070000
    ## 48 0.0000000 0.005460000 0.0000000000 0.000000000 0.00000000 0.29400000
    ## 49 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.01594687
    ## 50 0.0000000 0.005581406 0.0009568125 0.001594687 0.00000000 0.04784062
    ## 51 0.0000000 0.000000000 0.0000000000 0.000000000 0.00000000 0.09568125
    ##          CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE   V_TOTAL
    ## 2   40.0160000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 3    4.7040000        0       0 0.32160   0.0000  0.3216 0.00000 0.0000000
    ## 4  871.2300000        0       0 0.00000   0.0000  0.0000 0.00000 1.0848000
    ## 5   18.5107200        0       0 1.19424   0.0000  0.0000 1.19424 0.0000000
    ## 6    9.2352000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 7    0.0000000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 8    0.0000000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 9    0.0000000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 10  10.4160000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 11  44.2680000        0       0 0.00000   0.0000  0.0000 0.00000 0.3876000
    ## 12   2.2104000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 13  62.4000000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 14 119.9220000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 15  19.4480000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 16   4.4800000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 17   3.4160000        0       0 0.00000   0.0000  0.0000 0.00000 0.3528000
    ## 18  14.0332500        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 19   3.8250000        0       0 0.00000   0.0000  0.0000 0.00000 0.6250000
    ## 20   7.7550000        0       0 0.00000   0.0000  0.0000 0.00000 0.5875000
    ## 21   4.6612500        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 22   3.1075000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 23   1.5250000        0       0 0.00000   0.0000  0.0000 0.00000 0.1575000
    ## 24   2.5609375        0       0 0.00000   0.0000  0.0000 0.00000 0.3864687
    ## 25  12.3975000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 26   0.9198000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 27   9.6432000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 28  48.4800000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 29  12.1000000        0       0 0.00000   0.0000  0.0000 0.00000 1.7500000
    ## 30   3.6850000        0       0 0.00000   0.0000  0.0000 0.00000 0.5005000
    ## 31  78.1200000        0       0 0.00000   0.0000  0.0000 0.00000 1.0090500
    ## 32  70.8000000        0       0 0.00000   0.0000  0.0000 0.00000 0.8968000
    ## 33   4.8900000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 34   1.1366400        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 35   0.1886000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 36  11.6920000        0       0 0.00000   0.0000  0.0000 0.00000 0.5846000
    ## 37  57.8000000        0       0 0.00000   0.0000  0.0000 0.00000 1.2200000
    ## 38   0.9723028        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 39   0.0000000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 40  18.5400000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 41  70.2000000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 42  13.0845000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 43   2.0520000        0       0 0.24840   0.2484  0.0000 0.00000 0.0000000
    ## 44   0.6930000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 45   0.0000000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 46   7.8540000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 47   3.5397000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 48  26.2080000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 49   6.1236000        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 50   2.4558187        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ## 51   2.4558187        0       0 0.00000   0.0000  0.0000 0.00000 0.0000000
    ##    V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL
    ## 2  0.00000       0.00000         0.0000       0.00000           0.000
    ## 3  0.00000       0.00000         0.0000       0.00000           0.000
    ## 4  0.00000       1.08480         1.0848       0.00000           0.000
    ## 5  0.00000       0.00000         0.0000       0.00000           0.000
    ## 6  0.00000       0.00000         0.0000       0.00000           0.000
    ## 7  0.00000       0.00000         0.0000       0.00000           0.000
    ## 8  0.00000       0.00000         0.0000       0.00000           0.000
    ## 9  0.00000       0.00000         0.0000       0.00000           0.000
    ## 10 0.00000       0.00000         0.0000       0.00000           0.000
    ## 11 0.00000       0.16320         0.1632       0.00000           0.000
    ## 12 0.00000       0.00000         0.0000       0.00000           0.000
    ## 13 0.00000       0.00000         0.0000       0.00000           0.000
    ## 14 0.00000       0.00000         0.0000       0.00000           0.000
    ## 15 0.00000       0.00000         0.0000       0.00000           0.000
    ## 16 0.00000       0.00000         0.0000       0.00000           0.000
    ## 17 0.00000       0.00000         0.0000       0.00000           0.000
    ## 18 0.00000       0.00000         0.0000       0.00000           0.000
    ## 19 0.62500       0.00000         0.0000       0.00000           0.000
    ## 20 0.58750       0.00000         0.0000       0.00000           0.000
    ## 21 0.00000       0.00000         0.0000       0.00000           0.000
    ## 22 0.00000       0.00000         0.0000       0.00000           0.000
    ## 23 0.00000       0.00000         0.0000       0.00000           0.000
    ## 24 0.00000       0.00000         0.0000       0.00000           0.000
    ## 25 0.00000       0.00000         0.0000       0.00000           0.000
    ## 26 0.00000       0.00000         0.0000       0.00000           0.000
    ## 27 0.00000       0.00000         0.0000       0.00000           0.000
    ## 28 0.00000       0.00000         0.0000       0.00000           0.000
    ## 29 0.00000       0.00000         0.0000       0.00000           1.750
    ## 30 0.00000       0.00000         0.0000       0.00000           0.000
    ## 31 0.29295       0.29295         0.0000       0.29295           0.000
    ## 32 0.14160       0.21240         0.0472       0.16520           0.236
    ## 33 0.00000       0.00000         0.0000       0.00000           0.000
    ## 34 0.00000       0.00000         0.0000       0.00000           0.000
    ## 35 0.00000       0.00000         0.0000       0.00000           0.000
    ## 36 0.00000       0.00000         0.0000       0.00000           0.000
    ## 37 0.00000       0.00000         0.0000       0.00000           1.220
    ## 38 0.00000       0.00000         0.0000       0.00000           0.000
    ## 39 0.00000       0.00000         0.0000       0.00000           0.000
    ## 40 0.00000       0.00000         0.0000       0.00000           0.000
    ## 41 0.00000       0.00000         0.0000       0.00000           0.000
    ## 42 0.00000       0.00000         0.0000       0.00000           0.000
    ## 43 0.00000       0.00000         0.0000       0.00000           0.000
    ## 44 0.00000       0.00000         0.0000       0.00000           0.000
    ## 45 0.00000       0.00000         0.0000       0.00000           0.000
    ## 46 0.00000       0.00000         0.0000       0.00000           0.000
    ## 47 0.00000       0.00000         0.0000       0.00000           0.000
    ## 48 0.00000       0.00000         0.0000       0.00000           0.000
    ## 49 0.00000       0.00000         0.0000       0.00000           0.000
    ## 50 0.00000       0.00000         0.0000       0.00000           0.000
    ## 51 0.00000       0.00000         0.0000       0.00000           0.000
    ##    V_STARCHY_POTATO V_STARCHY_OTHER   V_OTHER V_LEGUMES G_TOTAL G_WHOLE
    ## 2             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 3             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 4             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 5             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 6             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 7             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 8             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 9             0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 10            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 11            0.000            0.00 0.2244000    0.0000 3.69240  0.0000
    ## 12            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 13            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 14            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 15            0.000            0.00 0.0000000    0.0000 3.67120  0.9776
    ## 16            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 17            0.000            0.00 0.3528000    0.0000 0.00000  0.0000
    ## 18            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 19            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 20            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 21            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 22            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 23            0.000            0.00 0.1575000    0.0000 0.00000  0.0000
    ## 24            0.000            0.00 0.3864687    0.0000 0.00000  0.0000
    ## 25            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 26            0.000            0.00 0.0000000    0.0000 0.24759  0.0000
    ## 27            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 28            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 29            1.750            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 30            0.000            0.00 0.5005000    0.0000 0.00000  0.0000
    ## 31            0.000            0.00 0.4231500    0.0000 0.55335  0.0000
    ## 32            0.236            0.00 0.3068000    0.0236 0.00000  0.0000
    ## 33            0.000            0.00 0.0000000    0.0000 2.88510  0.0000
    ## 34            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 35            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 36            0.000            0.00 0.5846000    0.0000 0.00000  0.0000
    ## 37            0.000            1.22 0.0000000    0.0000 0.00000  0.0000
    ## 38            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 39            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 40            0.000            0.00 0.0000000    0.0000 0.72000  0.0000
    ## 41            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 42            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 43            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 44            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 45            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 46            0.000            0.00 0.0000000    0.0000 1.49100  0.4158
    ## 47            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 48            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 49            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 50            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ## 51            0.000            0.00 0.0000000    0.0000 0.00000  0.0000
    ##    G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT
    ## 2    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 3    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 4    0.00000 9.356400       3.3222  0.0000       3.3222        0    0.000
    ## 5    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 6    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 7    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 8    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 9    0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 10   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 11   3.69240 0.632400       0.6324  0.0000       0.6324        0    0.000
    ## 12   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 13   0.00000 0.144000       0.0000  0.0000       0.0000        0    0.000
    ## 14   0.00000 5.087600       5.0876  5.0876       0.0000        0    0.000
    ## 15   2.69360 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 16   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 17   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 18   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 19   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 20   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 21   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 22   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 23   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 24   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 25   0.00000 1.586250       0.0000  0.0000       0.0000        0    0.000
    ## 26   0.24759 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 27   0.00000 0.014700       0.0000  0.0000       0.0000        0    0.000
    ## 28   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 29   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 30   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 31   0.55335 3.255000       3.2550  0.0000       0.0000        0    3.255
    ## 32   0.00000 1.156400       1.1564  1.1564       0.0000        0    0.000
    ## 33   2.88510 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 34   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 35   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 36   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 37   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 38   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 39   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 40   0.72000 0.600000       0.0000  0.0000       0.0000        0    0.000
    ## 41   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 42   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 43   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 44   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 45   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 46   1.07520 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 47   0.00000 0.015525       0.0000  0.0000       0.0000        0    0.000
    ## 48   0.00000 1.482600       1.4826  0.0000       1.4826        0    0.000
    ## 49   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 50   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ## 51   0.00000 0.000000       0.0000  0.0000       0.0000        0    0.000
    ##    PF_SEAFD_HI PF_SEAFD_LOW  PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES   D_TOTAL
    ## 2            0            0 0.000000      0   0.00000      0.000 1.0004000
    ## 3            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 4            0            0 6.034200      0   0.00000      0.000 1.6272000
    ## 5            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 6            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 7            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 8            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 9            0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 10           0            0 0.000000      0   0.00000      0.000 0.1536000
    ## 11           0            0 0.000000      0   0.00000      0.000 0.6528000
    ## 12           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 13           0            0 0.144000      0   0.00000      0.000 0.3360000
    ## 14           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 15           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 16           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 17           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 18           0            0 0.000000      0   0.00000      0.000 1.9986750
    ## 19           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 20           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 21           0            0 0.000000      0   0.00000      0.000 0.6638750
    ## 22           0            0 0.000000      0   0.00000      0.000 0.3813750
    ## 23           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 24           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 25           0            0 0.000000      0   1.58625      0.000 0.0000000
    ## 26           0            0 0.000000      0   0.00000      0.000 0.0132300
    ## 27           0            0 0.014700      0   0.00000      0.000 0.0000000
    ## 28           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 29           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 30           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 31           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 32           0            0 0.000000      0   0.00000      0.118 0.0236000
    ## 33           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 34           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 35           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 36           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 37           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 38           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 39           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 40           0            0 0.084000      0   0.51600      0.000 0.0000000
    ## 41           0            0 0.000000      0   0.00000      0.000 0.6210000
    ## 42           0            0 0.000000      0   0.00000      0.000 0.3751500
    ## 43           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 44           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 45           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 46           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 47           0            0 0.015525      0   0.00000      0.000 0.0000000
    ## 48           0            0 0.000000      0   0.00000      0.000 0.0000000
    ## 49           0            0 0.000000      0   0.00000      0.000 0.3747516
    ## 50           0            0 0.000000      0   0.00000      0.000 0.3747516
    ## 51           0            0 0.000000      0   0.00000      0.000 0.3747516
    ##     D_MILK D_YOGURT  D_CHEESE      OILS SOLID_FATS ADD_SUGARS A_DRINKS
    ## 2  1.00040   0.0000 0.0000000  0.000000   3.342800    0.00000    0.000
    ## 3  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 4  0.40680   0.0000 1.2204000 20.475600  45.968400    0.00000    0.000
    ## 5  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 6  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 7  0.00000   0.0000 0.0000000  0.000000   2.991000    0.81300    0.000
    ## 8  0.00000   0.0000 0.0000000  0.000000   0.000000    1.99584    0.000
    ## 9  0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 10 0.15360   0.0000 0.0000000  0.000000   8.203200    6.53760    0.000
    ## 11 0.00000   0.0000 0.6528000  1.040400  19.278000    0.24480    0.000
    ## 12 0.00000   0.0000 0.0000000  0.000000   0.000000   15.76752    0.000
    ## 13 0.33600   0.0000 0.0000000  0.000000  37.776000    9.81600    0.000
    ## 14 0.00000   0.0000 0.0000000  0.000000  12.371400    0.00000    0.000
    ## 15 0.00000   0.0000 0.0000000  5.449600   0.000000    0.35360    0.000
    ## 16 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 17 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 18 0.00000   0.0000 1.9986750  0.000000  25.183305    0.00000    0.000
    ## 19 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 20 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 21 0.00000   0.0000 0.6638750  0.000000   8.364825    0.00000    0.000
    ## 22 0.00000   0.0000 0.3813750  0.000000   3.055238    0.00000    0.000
    ## 23 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 24 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 25 0.00000   0.0000 0.0000000  7.404750   0.000000    0.00000    0.000
    ## 26 0.00000   0.0000 0.0088200  0.913500   0.054810    0.03024    0.000
    ## 27 0.00000   0.0000 0.0000000 12.950700   0.144060    0.18522    0.000
    ## 28 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    1.344
    ## 29 0.00000   0.0000 0.0000000 36.400000   0.000000    0.00000    0.000
    ## 30 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 31 0.00000   0.0000 0.0000000 15.396150   0.000000    0.00000    0.000
    ## 32 0.00000   0.0236 0.0000000  6.183200   4.342400    0.00000    0.000
    ## 33 0.00000   0.0000 0.0000000  6.797100   0.000000    0.00000    0.000
    ## 34 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 35 0.00000   0.0000 0.0000000  0.000000   0.000000    1.89420    0.000
    ## 36 0.00000   0.0000 0.0000000  0.000000   1.911800    0.00000    0.000
    ## 37 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 38 0.00000   0.0000 0.0000000  2.851135   2.851135    0.00000    0.000
    ## 39 0.00000   0.0000 0.0000000  0.000000   0.000000    1.49800    0.000
    ## 40 0.00000   0.0000 0.0000000  3.426000  11.796000    5.79000    0.000
    ## 41 0.62100   0.0000 0.0000000  0.000000  28.755000   11.25900    0.000
    ## 42 0.37515   0.0000 0.0000000  0.000000   2.415600    0.00000    0.000
    ## 43 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 44 0.00000   0.0000 0.0000000  0.000000   0.000000    6.15825    0.000
    ## 45 0.00000   0.0000 0.0000000  0.000000   0.000000    0.74844    0.000
    ## 46 0.00000   0.0000 0.0000000  1.201200   0.000000    0.53760    0.000
    ## 47 0.00000   0.0000 0.0000000  7.555500   0.044505    0.00000    0.000
    ## 48 0.00000   0.0000 0.0000000  0.000000   0.000000    0.00000    0.000
    ## 49 0.00000   0.0000 0.3747516  0.000000   0.000000    0.00000    0.000
    ## 50 0.00000   0.0000 0.3747516  0.000000   2.691832    0.00000    0.000
    ## 51 0.00000   0.0000 0.3747516  0.000000   4.265789    0.00000    0.000
    ##    FoodComp
    ## 2         1
    ## 3         1
    ## 4         1
    ## 5         1
    ## 6         1
    ## 7         1
    ## 8         1
    ## 9         1
    ## 10        1
    ## 11        1
    ## 12        1
    ## 13        1
    ## 14        1
    ## 15        1
    ## 16        1
    ## 17        1
    ## 18        1
    ## 19        1
    ## 20        1
    ## 21        1
    ## 22        1
    ## 23        1
    ## 24        1
    ## 25        1
    ## 26        1
    ## 27        1
    ## 28        1
    ## 29        1
    ## 30        1
    ## 31        1
    ## 32        1
    ## 33        1
    ## 34        1
    ## 35        1
    ## 36        1
    ## 37        1
    ## 38        1
    ## 39        1
    ## 40        1
    ## 41        1
    ## 42        1
    ## 43        1
    ## 44        1
    ## 45        1
    ## 46        1
    ## 47        1
    ## 48        1
    ## 49        1
    ## 50        1
    ## 51        1
    ##                                                                                                             Food_Description
    ## 2                                                                                                 Milk, cow's, fluid, 2% fat
    ## 3                                                                                                                Banana, raw
    ## 4                                         Egg omelet or scrambled egg, with cheese, meat, and tomatoes, fat added in cooking
    ## 5                                                                               Orange juice, canned, bottled or in a carton
    ## 6                                                                                          Coffee, made from ground, regular
    ## 7                                                                                                   Cream substitute, liquid
    ## 8                                                                                           Sugar, white, granulated or lump
    ## 9                                                                                                Water, bottled, unsweetened
    ## 10                                                     M&M's Milk Chocolate Candies (formerly M&M's Plain Chocolate Candies)
    ## 11                                                                             Pizza with meat and vegetables, regular crust
    ## 12                                                                                                     Soft drink, cola-type
    ## 13                                                                             Ice cream, rich, flavors other than chocolate
    ## 14                                                                Ground beef, less than 80% lean, cooked (formerly regular)
    ## 15                                                                                          Roll, whole wheat, NS as to 100%
    ## 16                                                                                                                   Mustard
    ## 17                                                                                                       Onions, mature, raw
    ## 18                                                                                                           Cheese, Cheddar
    ## 19                                                                                                     Lettuce, arugula, raw
    ## 20                                                                        Endive, chicory, escarole, or romaine lettuce, raw
    ## 21                                                                                                           Cheese, Cheddar
    ## 22                                                                                                               Cheese, NFS
    ## 23                                                                                                       Onions, mature, raw
    ## 24                                                                                                 Pepper, sweet, green, raw
    ## 25                                                                          Sunflower seeds, hulled, unroasted, without salt
    ## 26                                                                                                                  Croutons
    ## 27                                                                                                           Creamy dressing
    ## 28                                                                                                                      Beer
    ## 29                                                                                           White potato chips, regular cut
    ## 30                                                                                                              Lettuce, raw
    ## 31 Chicken or turkey, rice, and vegetables (including carrots, broccoli, and/or dark-green leafy), soy-based sauce (mixture)
    ## 32                                                                                                                Beef curry
    ## 33                                                                  Rice, white, cooked, fat added in cooking, made with oil
    ## 34                                                                                                    Tea, leaf, unsweetened
    ## 35                                                                                                                Sugar, raw
    ## 36                                            Beans, string, green, cooked, from canned, fat added in cooking W/ BUTTER, NFS
    ## 37                                                                Corn, yellow, cooked, from fresh, fat not added in cooking
    ## 38                                                                                        Margarine-like spread, tub, salted
    ## 39                                                                                                                Hard candy
    ## 40                                                    Cookie, chocolate chip, made from home recipe or purchased at a bakery
    ## 41                                                                          Ice cream, regular, flavors other than chocolate
    ## 42                                                                                                 Milk, cow's, fluid, whole
    ## 43                                                                                                         Strawberries, raw
    ## 44                                                                                                                     Honey
    ## 45                                                                                                                Sugar, NFS
    ## 46                                                                                             Bread, wheat or cracked wheat
    ## 47                                                                                                       Mayonnaise, regular
    ## 48                                                                           Ham, sliced, prepackaged or deli, luncheon meat
    ## 49                                                                                      Cheese, American, nonfat or fat free
    ## 50                                                                                              Cheese, Cheddar, reduced fat
    ## 51                                                                                                          Cheese, Monterey

`items` rownames are just 1-n. We can still summon a specific row using
the rowname instead of location (it just so happens in this case that
the rowname is the same as the row number)

    items['1',] #get the first row

    ##                            RecallRecId UserName
    ## 1 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                 UserID RecallNo RecallAttempt RecallStatus
    ## 1 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0            2
    ##   IntakeStartDateTime IntakeEndDateTime ReportingDate Lang Occ_No
    ## 1     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1      1
    ##           Occ_Time Occ_Name EatWith WatchTVuseComputer Location FoodNum
    ## 1 05/20/2018 11:00        1       4                  1        1       1
    ##   FoodType               FoodSrce CodeNum FoodCode ModCode HowMany SubCode
    ## 1        1 Other store (any type)       1 57123000       0       1       0
    ##   PortionCode FoodAmt   KCAL   PROT   TFAT    CARB   MOIS ALC CAFF THEO
    ## 1       10205      28 105.84 3.3852 1.8844 20.5044 1.4364   0    0    0
    ##     SUGR  FIBE   CALC   IRON  MAGN   PHOS   POTA   SODI   ZINC   COPP
    ## 1 1.2208 2.632 112.28 9.2876 35.84 134.68 179.48 139.16 4.6844 0.1078
    ##    SELE    VC     VB1     VB2    NIAC    VB6   FOLA    FA   FF   FDFE
    ## 1 6.972 6.048 0.37156 0.39676 5.87076 0.6692 199.92 194.6 5.32 336.28
    ##     VB12  VARA   RET BCAR ACAR CRYP LYCO    LZ  ATOC    VK CHOLE SFAT S040
    ## 1 1.8956 277.2 277.2    0    0    0    0 41.72 0.182 0.504     0 0.42    0
    ##   S060 S080 S100 S120    S140    S160   S180    MFAT    M161    M181
    ## 1    0    0    0    0 0.00504 0.36876 0.0364 0.66528 0.00308 0.64876
    ##     M201    M221    PFAT    P182    P183 P184 P204 P205 P225 P226  VITD
    ## 1 0.0126 0.00056 0.68096 0.65968 0.01904    0    0    0    0    0 0.952
    ##   CHOLN VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE V_TOTAL V_DRKGR
    ## 1 7.336        0  1.8956       0        0       0       0       0       0
    ##   V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL
    ## 1             0              0             0               0
    ##   V_STARCHY_POTATO V_STARCHY_OTHER V_OTHER V_LEGUMES G_TOTAL G_WHOLE
    ## 1                0               0       0         0  0.9184  0.9184
    ##   G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT
    ## 1         0        0            0       0            0        0        0
    ##   PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES D_TOTAL
    ## 1           0            0       0      0         0          0       0
    ##   D_MILK D_YOGURT D_CHEESE OILS SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 1      0        0        0    0          0     0.1988        0        1
    ##   Food_Description
    ## 1         Cheerios

Extracting specific data points
-------------------------------

We can combine the indexing of rows and columns to get specific data
points:

    items[1,1] #the first row and first column (vector)

    ## [1] f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## Levels: f52ae861-cd5b-4ec2-9af1-eec184537f78

    items[1:3, 21] #the first three elements of the 21st column (vector)

    ## [1] 57123000 11112110 63107010

**DIY:**  
***1) extract the column named “Food\_Description” and assign to a
dataframe called “fd”***

    fd<- items["Food_Description"]

***2) What is the class of ‘fd’? ***

    class(fd)

    ## [1] "data.frame"

***3) Show me the first 5 rows of ‘fd’***

    head(fd, n = 5)

    ##                                                                     Food_Description
    ## 1                                                                           Cheerios
    ## 2                                                         Milk, cow's, fluid, 2% fat
    ## 3                                                                        Banana, raw
    ## 4 Egg omelet or scrambled egg, with cheese, meat, and tomatoes, fat added in cooking
    ## 5                                       Orange juice, canned, bottled or in a carton

**DIY:** ***extract columns 95, 119, and 1 (in that order) from
‘items’***

    items[,c(95, 119, 1)]

    ##    F_JUICE PF_NUTSDS                          RecallRecId
    ## 1  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 2  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 3  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 4  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 5  1.19424   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 6  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 7  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 8  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 9  0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 10 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 11 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 12 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 13 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 14 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 15 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 16 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 17 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 18 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 19 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 20 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 21 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 22 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 23 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 24 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 25 0.00000   1.58625 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 26 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 27 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 28 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 29 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 30 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 31 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 32 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 33 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 34 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 35 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 36 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 37 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 38 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 39 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 40 0.00000   0.51600 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 41 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 42 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 43 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 44 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 45 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 46 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 47 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 48 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 49 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 50 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78
    ## 51 0.00000   0.00000 f52ae861-cd5b-4ec2-9af1-eec184537f78

**DIY:** ***For ‘items’, how would you get rows 6 through 10 and all
columns EXCEPT the last one?***

    items[6:10, -130]

    ##                             RecallRecId UserName
    ## 6  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 7  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 8  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 9  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 10 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 6  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 7  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 8  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 9  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 10 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 6             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 7             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 8             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 9             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 10            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No         Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 6       1 05/20/2018 11:00        1       4                  1        1
    ## 7       1 05/20/2018 11:00        1       4                  1        1
    ## 8       1 05/20/2018 11:00        1       4                  1        1
    ## 9       2 05/20/2018 14:00        6       1                  4        6
    ## 10      2 05/20/2018 14:00        6       1                  4        6
    ##    FoodNum FoodType               FoodSrce CodeNum FoodCode ModCode
    ## 6        6        1 Other store (any type)       6 92101000       0
    ## 7        7        2 Other store (any type)       7 12210200       0
    ## 8        8        2 Other store (any type)       8 91101010       0
    ## 9        9        1        Other cafeteria       9 94100100       0
    ## 10      10        1        Other cafeteria      10 91746100       0
    ##    HowMany SubCode PortionCode FoodAmt    KCAL    PROT     TFAT     CARB
    ## 6    12.00       0       30000 355.200   3.552 0.42624  0.07104  0.00000
    ## 7    12.00       0       63480  30.000  40.800 0.30000  2.99100  3.41400
    ## 8     2.00       0       22000   8.400  32.508 0.00000  0.00000  8.39832
    ## 9    10.14       0       30000 300.144   0.000 0.00000  0.00000  0.00000
    ## 10    1.00       0       61538  48.000 236.160 2.07840 10.14240 34.17120
    ##         MOIS ALC   CAFF  THEO    SUGR  FIBE    CALC    IRON     MAGN
    ## 6  353.03328   0 142.08  0.00  0.0000 0.000  7.1040 0.03552 10.65600
    ## 7   23.18100   0   0.00  0.00  3.4140 0.000  2.7000 0.00900  0.00000
    ## 8    0.00168   0   0.00  0.00  8.3832 0.000  0.0840 0.00420  0.00000
    ## 9  300.08397   0   0.00  0.00  0.0000 0.000 30.0144 0.00000  6.00288
    ## 10   0.81600   0   6.72 68.64 30.5664 1.344 50.4000 0.53280 21.12000
    ##      PHOS    POTA     SODI    ZINC       COPP   SELE   VC      VB1
    ## 6  10.656 174.048  7.10400 0.07104 0.00710400 0.0000 0.00 0.049728
    ## 7  19.200  57.300 20.10000 0.00600 0.00000000 0.3300 0.00 0.000000
    ## 8   0.000   0.168  0.08400 0.00084 0.00058800 0.0504 0.00 0.000000
    ## 9   0.000   0.000  6.00288 0.00000 0.02101008 0.0000 0.00 0.000000
    ## 10 70.080 125.280 29.28000 0.77280 0.16512000 1.5840 0.24 0.037920
    ##         VB2     NIAC      VB6  FOLA FA    FF  FDFE   VB12  VARA   RET BCAR
    ## 6  0.269952 0.678432 0.003552 7.104  0 7.104 7.104 0.0000  0.00  0.00  0.0
    ## 7  0.000000 0.000000 0.000000 0.000  0 0.000 0.000 0.0000  0.30  0.00  2.7
    ## 8  0.001596 0.000000 0.000000 0.000  0 0.000 0.000 0.0000  0.00  0.00  0.0
    ## 9  0.000000 0.000000 0.000000 0.000  0 0.000 0.000 0.0000  0.00  0.00  0.0
    ## 10 0.102240 0.129600 0.012000 3.840  0 3.840 3.840 0.2544 26.88 26.88  0.0
    ##    ACAR CRYP LYCO LZ    ATOC     VK CHOLE     SFAT    S040    S060   S080
    ## 6     0    0    0  0 0.03552 0.3552  0.00 0.007104 0.00000 0.00000 0.0000
    ## 7     0    0    0  0 0.24300 0.7500  0.00 0.581100 0.00000 0.00000 0.0015
    ## 8     0    0    0  0 0.00000 0.0000  0.00 0.000000 0.00000 0.00000 0.0000
    ## 9     0    0    0  0 0.00000 0.0000  0.00 0.000000 0.00000 0.00000 0.0000
    ## 10    0    0    0  0 0.17280 1.9200  6.72 6.278400 0.22176 0.08016 0.0456
    ##       S100    S120    S140     S160   S180    MFAT    M161    M181 M201
    ## 6  0.00000 0.00000 0.00000 0.007104 0.0000 0.05328 0.00000 0.00000    0
    ## 7  0.00390 0.01860 0.00570 0.265200 0.2928 2.26530 0.00000 2.26770    0
    ## 8  0.00000 0.00000 0.00000 0.000000 0.0000 0.00000 0.00000 0.00000    0
    ## 9  0.00000 0.00000 0.00000 0.000000 0.0000 0.00000 0.00000 0.00000    0
    ## 10 0.08688 0.09552 0.29232 2.623200 2.6904 2.48784 0.07056 2.36976    0
    ##    M221     PFAT     P182    P183 P184 P204 P205 P225 P226 VITD   CHOLN
    ## 6     0 0.003552 0.003552 0.00000    0    0    0    0    0    0  9.2352
    ## 7     0 0.008100 0.006600 0.00000    0    0    0    0    0    0  0.0000
    ## 8     0 0.000000 0.000000 0.00000    0    0    0    0    0    0  0.0000
    ## 9     0 0.000000 0.000000 0.00000    0    0    0    0    0    0  0.0000
    ## 10    0 0.442080 0.414720 0.02736    0    0    0    0    0    0 10.4160
    ##    VITE_ADD B12_ADD F_TOTAL F_CITMLB F_OTHER F_JUICE V_TOTAL V_DRKGR
    ## 6         0       0       0        0       0       0       0       0
    ## 7         0       0       0        0       0       0       0       0
    ## 8         0       0       0        0       0       0       0       0
    ## 9         0       0       0        0       0       0       0       0
    ## 10        0       0       0        0       0       0       0       0
    ##    V_REDOR_TOTAL V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL
    ## 6              0              0             0               0
    ## 7              0              0             0               0
    ## 8              0              0             0               0
    ## 9              0              0             0               0
    ## 10             0              0             0               0
    ##    V_STARCHY_POTATO V_STARCHY_OTHER V_OTHER V_LEGUMES G_TOTAL G_WHOLE
    ## 6                 0               0       0         0       0       0
    ## 7                 0               0       0         0       0       0
    ## 8                 0               0       0         0       0       0
    ## 9                 0               0       0         0       0       0
    ## 10                0               0       0         0       0       0
    ##    G_REFINED PF_TOTAL PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT
    ## 6          0        0            0       0            0        0        0
    ## 7          0        0            0       0            0        0        0
    ## 8          0        0            0       0            0        0        0
    ## 9          0        0            0       0            0        0        0
    ## 10         0        0            0       0            0        0        0
    ##    PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES D_TOTAL
    ## 6            0            0       0      0         0          0  0.0000
    ## 7            0            0       0      0         0          0  0.0000
    ## 8            0            0       0      0         0          0  0.0000
    ## 9            0            0       0      0         0          0  0.0000
    ## 10           0            0       0      0         0          0  0.1536
    ##    D_MILK D_YOGURT D_CHEESE OILS SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 6  0.0000        0        0    0     0.0000    0.00000        0        1
    ## 7  0.0000        0        0    0     2.9910    0.81300        0        1
    ## 8  0.0000        0        0    0     0.0000    1.99584        0        1
    ## 9  0.0000        0        0    0     0.0000    0.00000        0        1
    ## 10 0.1536        0        0    0     8.2032    6.53760        0        1

Column Summary Statistics
-------------------------

We can also use the `summary()` function on just one column

    summary(items$TFAT)

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##  0.00000  0.07808  2.20410  8.50229  9.75222 93.83520

**DIY:** ***can you get the summary for columns 121 to 124 from
‘items’?***

    summary(items[,121:124])

    ##     D_TOTAL           D_MILK           D_YOGURT            D_CHEESE     
    ##  Min.   :0.0000   Min.   :0.00000   Min.   :0.0000000   Min.   :0.0000  
    ##  1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.0000000   1st Qu.:0.0000  
    ##  Median :0.0000   Median :0.00000   Median :0.0000000   Median :0.0000  
    ##  Mean   :0.1759   Mean   :0.05672   Mean   :0.0004627   Mean   :0.1186  
    ##  3rd Qu.:0.0886   3rd Qu.:0.00000   3rd Qu.:0.0000000   3rd Qu.:0.0000  
    ##  Max.   :1.9987   Max.   :1.00040   Max.   :0.0236000   Max.   :1.9987

Conditiomal Subsetting
======================

We can return just part of the data that meet certain conditions

Conditions can be defined using the following:

-   `==` means ‘equal to’
-   `!=` means ‘not equal to’
-   `>` means ‘greather than’
-   `>=` means ‘greater than or equal to’
-   `<` means ‘less than’
-   `<=` means ‘less than or equal to’

Joiners

-   `|` means ‘or’
-   `&` means ‘and’

e.g. Return all the foods (rows) in items where the value for “OILS” is
0

    items$OILS == 0 #returns a logical vector

    ##  [1]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE
    ## [12]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [23]  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE
    ## [34]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE
    ## [45]  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE

    items[items$OILS==0,] #returns all rows in the dataframe where the vector is TRUE. Notice the comma-- it returns all the columns

    ##                             RecallRecId UserName
    ## 1  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 2  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 3  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 5  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 6  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 7  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 8  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 9  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 10 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 12 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 13 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 14 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 16 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 17 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 18 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 19 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 20 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 21 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 22 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 23 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 24 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 28 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 30 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 34 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 35 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 36 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 37 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 39 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 41 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 42 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 43 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 44 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 45 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 49 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 50 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 51 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 1  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 2  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 3  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 5  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 6  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 7  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 8  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 9  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 10 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 12 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 13 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 14 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 16 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 17 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 18 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 19 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 20 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 21 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 22 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 23 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 24 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 28 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 30 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 34 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 35 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 36 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 37 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 39 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 41 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 42 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 43 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 44 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 45 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 49 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 50 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 51 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 1             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 2             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 3             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 5             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 6             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 7             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 8             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 9             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 10            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 12            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 13            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 14            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 16            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 17            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 18            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 19            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 20            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 21            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 22            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 23            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 24            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 28            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 30            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 34            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 35            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 36            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 37            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 39            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 41            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 42            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 43            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 44            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 45            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 49            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 50            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 51            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No         Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 1       1 05/20/2018 11:00        1       4                  1        1
    ## 2       1 05/20/2018 11:00        1       4                  1        1
    ## 3       1 05/20/2018 11:00        1       4                  1        1
    ## 5       1 05/20/2018 11:00        1       4                  1        1
    ## 6       1 05/20/2018 11:00        1       4                  1        1
    ## 7       1 05/20/2018 11:00        1       4                  1        1
    ## 8       1 05/20/2018 11:00        1       4                  1        1
    ## 9       2 05/20/2018 14:00        6       1                  4        6
    ## 10      2 05/20/2018 14:00        6       1                  4        6
    ## 12      3 05/20/2018 17:00        3       2                  3        3
    ## 13      3 05/20/2018 17:00        3       2                  3        3
    ## 14      3 05/20/2018 17:00        3       2                  3        3
    ## 16      3 05/20/2018 17:00        3       2                  3        3
    ## 17      3 05/20/2018 17:00        3       2                  3        3
    ## 18      3 05/20/2018 17:00        3       2                  3        3
    ## 19      3 05/20/2018 17:00        3       2                  3        3
    ## 20      3 05/20/2018 17:00        3       2                  3        3
    ## 21      3 05/20/2018 17:00        3       2                  3        3
    ## 22      3 05/20/2018 17:00        3       2                  3        3
    ## 23      3 05/20/2018 17:00        3       2                  3        3
    ## 24      3 05/20/2018 17:00        3       2                  3        3
    ## 28      4 05/20/2018 19:30        6       1                  2        7
    ## 30      5 05/20/2018 22:00        5       1                  6        1
    ## 34      5 05/20/2018 22:00        5       1                  6        1
    ## 35      5 05/20/2018 22:00        5       1                  6        1
    ## 36      5 05/20/2018 22:00        5       1                  6        1
    ## 37      5 05/20/2018 22:00        5       1                  6        1
    ## 39      6  05/21/2018 0:00        6       1                  4       98
    ## 41      7  05/21/2018 2:00        7       1                  4        1
    ## 42      7  05/21/2018 2:00        7       1                  4        1
    ## 43      7  05/21/2018 2:00        7       1                  4        1
    ## 44      7  05/21/2018 2:00        7       1                  4        1
    ## 45      7  05/21/2018 2:00        7       1                  4        1
    ## 48      8  05/21/2018 3:00        6       3                  5        1
    ## 49      8  05/21/2018 3:00        6       3                  5        1
    ## 50      8  05/21/2018 3:00        6       3                  5        1
    ## 51      8  05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType                           FoodSrce CodeNum FoodCode
    ## 1        1        1             Other store (any type)       1 57123000
    ## 2        2        2             Other store (any type)       2 11112110
    ## 3        3        2             Other store (any type)       3 63107010
    ## 5        5        1             Other store (any type)       5 61210220
    ## 6        6        1             Other store (any type)       6 92101000
    ## 7        7        2             Other store (any type)       7 12210200
    ## 8        8        2             Other store (any type)       8 91101010
    ## 9        9        1                    Other cafeteria       9 94100100
    ## 10      10        1                    Other cafeteria      10 91746100
    ## 12      12        1                                         12 92410310
    ## 13      13        1                                         13 13110120
    ## 14      14        1                                         14 21501000
    ## 16      14        1                                         16 75506010
    ## 17      14        1                                         17 75117020
    ## 18      14        1                                         18 14104100
    ## 19      15        1                                         19 75113080
    ## 20      15        1                                         20 72116000
    ## 21      15        1                                         21 14104100
    ## 22      15        1                                         22 14010000
    ## 23      15        1                                         23 75117020
    ## 24      15        1                                         24 75122100
    ## 28      16        1             Other store (any type)      28 93101000
    ## 30      18        1    Other restaurant, bar or tavern      30 75113000
    ## 34      21        1    Other restaurant, bar or tavern      34 92302000
    ## 35      22        2    Other restaurant, bar or tavern      35 91104200
    ## 36      23        1    Other restaurant, bar or tavern      36 75205033
    ## 37      24        1    Other restaurant, bar or tavern      37 75216111
    ## 39      26        1                        Other: Gift      39 91745020
    ## 41      28        1 Fast food or drive-thru restaurant      41 13110100
    ## 42      28        1 Fast food or drive-thru restaurant      42 11111000
    ## 43      28        1 Fast food or drive-thru restaurant      43 63223020
    ## 44      28        1 Fast food or drive-thru restaurant      44 91302010
    ## 45      28        1 Fast food or drive-thru restaurant      45 91101000
    ## 48      29        1             Other store (any type)      48 25230210
    ## 49      29        1             Other store (any type)      49 14410130
    ## 50      29        1             Other store (any type)      50 14104110
    ## 51      29        1             Other store (any type)      51 14106200
    ##    ModCode  HowMany SubCode PortionCode   FoodAmt      KCAL       PROT
    ## 1        0  1.00000       0       10205  28.00000 105.84000  3.3852000
    ## 2        0  1.00000       0       10205 244.00000 122.00000  8.0520000
    ## 3        0  8.00000       0       61935  48.00000  42.72000  0.5232000
    ## 5        0  9.60000       0       30000 298.56000 146.29440  2.0302080
    ## 6        0 12.00000       0       30000 355.20000   3.55200  0.4262400
    ## 7        0 12.00000       0       63480  30.00000  40.80000  0.3000000
    ## 8        0  2.00000       0       22000   8.40000  32.50800  0.0000000
    ## 9        0 10.14000       0       30000 300.14400   0.00000  0.0000000
    ## 10       0  1.00000       0       61538  48.00000 236.16000  2.0784000
    ## 12       0 24.00000       0       30000 736.80000 272.61600  0.5157600
    ## 13       0  2.00000       0       61396 240.00000 597.60000  8.4000000
    ## 14       0  2.00000       0       64195 158.00000 388.68000 36.7508000
    ## 16       0  4.00000       0       22000  20.00000  13.40000  0.8740000
    ## 17       0  4.00000       0       61401  56.00000  22.40000  0.6160000
    ## 18       0 85.05000       0          98  85.05000 342.75150 21.1774500
    ## 19       0  1.25000       0       10205  25.00000   6.25000  0.6450000
    ## 20       0  1.25000       0       10346  58.75000  11.16250  0.8166250
    ## 21       0  0.25000       0       10010  28.25000 113.84750  7.0342500
    ## 22       0  0.12500       0       10205  14.12500  47.74250  3.2092000
    ## 23       0  0.15625       0       10010  25.00000  10.00000  0.2750000
    ## 24       0  0.31250       0       10010  46.56250   9.31250  0.4004375
    ## 28       0 16.00000       0       30000 480.00000 206.40000  2.2080000
    ## 30       0  1.00000       0       10160  55.00000   7.70000  0.4950000
    ## 34       0  9.60000       0       30000 284.16000   2.84160  0.0000000
    ## 35       0  2.00000       0       22000   8.20000  31.16000  0.0098400
    ## 36  200058  0.50000       0       10029  79.00000  36.34000  0.9875000
    ## 37       0  2.00000       0       61345 200.00000 190.00000  6.7800000
    ## 39       0  5.00000 1000179       61667  10.00000  39.40000  0.0000000
    ## 41       0  2.25000       0       61396 270.00000 558.90000  9.4500000
    ## 42       0  0.37500       0       10205  91.50000  55.81500  2.8822500
    ## 43       0  3.00000       0       61241  36.00000  11.52000  0.2412000
    ## 44       0  1.50000       0       21000  31.50000  95.76000  0.0945000
    ## 45       0  0.75000       0       22000   3.15000  12.19050  0.0000000
    ## 48       0  1.50000       0       62008  42.00000  55.02000  7.1106000
    ## 49       0 15.94687       0          98  15.94687  20.09306  3.3568172
    ## 50       0 15.94687       0          98  15.94687  49.27584  4.3614703
    ## 51       0 15.94687       0          98  15.94687  59.48184  3.9037950
    ##           TFAT       CARB       MOIS   ALC    CAFF    THEO        SUGR
    ## 1   1.88440000 20.5044000   1.436400  0.00   0.000  0.0000  1.22080000
    ## 2   4.83120000 11.7120000 217.672400  0.00   0.000  0.0000 12.34640000
    ## 3   0.15840000 10.9632000  35.956800  0.00   0.000  0.0000  5.87040000
    ## 5   0.35827200 34.4538240 260.404032  0.00   0.000  0.0000 24.81033600
    ## 6   0.07104000  0.0000000 353.033280  0.00 142.080  0.0000  0.00000000
    ## 7   2.99100000  3.4140000  23.181000  0.00   0.000  0.0000  3.41400000
    ## 8   0.00000000  8.3983200   0.001680  0.00   0.000  0.0000  8.38320000
    ## 9   0.00000000  0.0000000 300.083971  0.00   0.000  0.0000  0.00000000
    ## 10 10.14240000 34.1712000   0.816000  0.00   6.720 68.6400 30.56640000
    ## 12  0.14736000 70.4380800 665.404080  0.00  58.944  0.0000 66.09096000
    ## 13 38.88000000 53.4960000 137.280000  0.00   0.000  0.0000 49.56000000
    ## 14 25.75400000  0.0000000  91.956000  0.00   0.000  0.0000  0.00000000
    ## 16  0.80200000  1.0660000  16.530000  0.00   0.000  0.0000  0.17200000
    ## 17  0.05600000  5.2304000  49.901600  0.00   0.000  0.0000  2.37440000
    ## 18 28.18557000  1.0886400  31.255875  0.00   0.000  0.0000  0.44226000
    ## 19  0.16500000  0.9125000  22.927500  0.00   0.000  0.0000  0.51250000
    ## 20  0.15862500  2.2207500  54.913625  0.00   0.000  0.0000  0.41712500
    ## 21  9.36205000  0.3616000  10.381875  0.00   0.000  0.0000  0.14690000
    ## 22  3.62730000  0.5395750   6.097762  0.00   0.000  0.0000  0.35171250
    ## 23  0.02500000  2.3350000  22.277500  0.00   0.000  0.0000  1.06000000
    ## 24  0.07915625  2.1605000  43.717531  0.00   0.000  0.0000  1.11750000
    ## 28  0.00000000 17.0400000 441.408000 18.72   0.000  0.0000  0.00000000
    ## 30  0.07700000  1.6335000  52.602000  0.00   0.000  0.0000  1.08350000
    ## 34  0.00000000  0.8524800 283.307520  0.00  56.832  5.6832  0.00000000
    ## 35  0.00000000  8.0433800   0.109880  0.00   0.000  0.0000  7.95564000
    ## 36  2.20410000  3.2548000  71.732000  0.00   0.000  0.0000  1.00330000
    ## 37  2.98000000 41.7200000 145.960000  0.00   0.000  0.0000  9.02000000
    ## 39  0.02000000  9.8000000   0.130000  0.00   0.000  0.0000  6.29000000
    ## 41 29.70000000 63.7200000 164.700000  0.00   0.000  0.0000 57.29400000
    ## 42  2.97375000  4.3920000  80.638950  0.00   0.000  0.0000  4.62075000
    ## 43  0.10800000  2.7648000  32.742000  0.00   0.000  0.0000  1.76040000
    ## 44  0.00000000 25.9560000   5.386500  0.00   0.000  0.0000 25.86780000
    ## 45  0.00000000  3.1493700   0.000630  0.00   0.000  0.0000  3.14370000
    ## 48  1.47000000  0.4074000  31.512600  0.00   0.000  0.0000  0.00000000
    ## 49  0.00000000  1.6792059  10.440419  0.00   0.000  0.0000  0.83880562
    ## 50  3.25475719  0.6474431   7.062871  0.00   0.000  0.0000  0.04146187
    ## 51  4.82871375  0.1084387   6.539813  0.00   0.000  0.0000  0.07973437
    ##         FIBE      CALC       IRON      MAGN      PHOS      POTA       SODI
    ## 1  2.6320000 112.28000 9.28760000 35.840000 134.68000 179.48000 139.160000
    ## 2  0.0000000 292.80000 0.04880000 26.840000 224.48000 341.60000 114.680000
    ## 3  1.2480000   2.40000 0.12480000 12.960000  10.56000 171.84000   0.480000
    ## 5  0.8956800  32.84160 0.38812800 32.841600  50.75520 531.43680   5.971200
    ## 6  0.0000000   7.10400 0.03552000 10.656000  10.65600 174.04800   7.104000
    ## 7  0.0000000   2.70000 0.00900000  0.000000  19.20000  57.30000  20.100000
    ## 8  0.0000000   0.08400 0.00420000  0.000000   0.00000   0.16800   0.084000
    ## 9  0.0000000  30.01440 0.00000000  6.002880   0.00000   0.00000   6.002880
    ## 10 1.3440000  50.40000 0.53280000 21.120000  70.08000 125.28000  29.280000
    ## 12 0.0000000  14.73600 0.81048000  0.000000  73.68000  14.73600  29.472000
    ## 13 0.0000000 280.80000 0.81600000 26.400000 252.00000 376.80000 146.400000
    ## 14 0.0000000  50.56000 3.91840000 31.600000 311.26000 504.02000 646.220000
    ## 16 0.6600000  11.60000 0.30200000  9.800000  21.20000  27.60000 227.000000
    ## 17 0.9520000  12.88000 0.11760000  5.600000  16.24000  81.76000   2.240000
    ## 18 0.0000000 613.21050 0.57834000 23.814000 435.45600  83.34900 528.160500
    ## 19 0.4000000  40.00000 0.36500000 11.750000  13.00000  92.25000   6.750000
    ## 20 1.8212500  36.42500 0.52875000 11.750000  20.56250 192.11250  14.687500
    ## 21 0.0000000 203.68250 0.19210000  7.910000 144.64000  27.68500 175.432500
    ## 22 0.0000000 134.18750 0.09181250  4.096250  85.17375  20.76375 115.260000
    ## 23 0.4250000   5.75000 0.05250000  2.500000   7.25000  36.50000   1.000000
    ## 24 0.7915625   4.65625 0.15831250  4.656250   9.31250  81.48438   1.396875
    ## 28 0.0000000  19.20000 0.09600000 28.800000  67.20000 129.60000  19.200000
    ## 30 0.6600000   9.90000 0.22550000  3.850000  11.00000  77.55000   5.500000
    ## 34 0.0000000   0.00000 0.05683200  8.524800   2.84160 105.13920   8.524800
    ## 35 0.0000000   6.80600 0.05822000  0.738000   0.32800  10.90600   2.296000
    ## 36 1.8960000  30.02000 0.67150000 10.270000  16.59000  82.16000 203.820000
    ## 37 4.8000000   6.00000 0.90000000 52.000000 154.00000 434.00000 454.000000
    ## 39 0.0000000   0.30000 0.03000000  0.300000   0.30000   0.50000   3.800000
    ## 41 1.8900000 345.60000 0.24300000 37.800000 283.50000 537.30000 216.000000
    ## 42 0.0000000 103.39500 0.02745000  9.150000  76.86000 120.78000  39.345000
    ## 43 0.7200000   5.76000 0.14760000  4.680000   8.64000  55.08000   0.360000
    ## 44 0.0630000   1.89000 0.13230000  0.630000   1.26000  16.38000   1.260000
    ## 45 0.0000000   0.03150 0.00157500  0.000000   0.00000   0.06300   0.031500
    ## 48 0.0000000   2.10000 0.24360000  7.560000 109.62000 194.04000 551.880000
    ## 49 0.0000000 125.82084 0.00000000 18.338906  50.39213  62.67122 209.860875
    ## 50 0.0000000 121.35572 0.01913625  4.305656  82.92375  10.04653 100.146375
    ## 51 0.0000000 118.96369 0.11481750  4.305656  70.80412  12.91697  95.681250
    ##          ZINC        COPP      SELE        VC         VB1        VB2
    ## 1  4.68440000 0.107800000  6.972000   6.04800 0.371560000 0.39676000
    ## 2  1.17120000 0.014640000  6.100000   0.48800 0.095160000 0.45140000
    ## 3  0.07200000 0.037440000  0.480000   4.17600 0.014880000 0.03504000
    ## 5  0.20899200 0.125395200  0.298560 100.31616 0.137337600 0.11643840
    ## 6  0.07104000 0.007104000  0.000000   0.00000 0.049728000 0.26995200
    ## 7  0.00600000 0.000000000  0.330000   0.00000 0.000000000 0.00000000
    ## 8  0.00084000 0.000588000  0.050400   0.00000 0.000000000 0.00159600
    ## 9  0.00000000 0.021010080  0.000000   0.00000 0.000000000 0.00000000
    ## 10 0.77280000 0.165120000  1.584000   0.24000 0.037920000 0.10224000
    ## 12 0.14736000 0.007368000  0.736800   0.00000 0.000000000 0.00000000
    ## 13 1.12800000 0.019200000  8.400000   0.00000 0.098400000 0.40080000
    ## 14 9.32200000 0.112180000 30.652000   0.00000 0.067940000 0.27650000
    ## 16 0.12800000 0.017000000  6.580000   0.30000 0.068600000 0.00600000
    ## 17 0.09520000 0.021840000  0.280000   4.14400 0.025760000 0.01512000
    ## 18 2.64505500 0.026365500 11.821950   0.00000 0.022963500 0.31893750
    ## 19 0.11750000 0.019000000  0.075000   3.75000 0.011000000 0.02150000
    ## 20 0.28200000 0.086362500  0.176250   6.75625 0.041712500 0.04758750
    ## 21 0.87857500 0.008757500  3.926750   0.00000 0.007627500 0.10593750
    ## 22 0.38702500 0.004520000  2.090500   0.00000 0.004096250 0.05296875
    ## 23 0.04250000 0.009750000  0.125000   1.85000 0.011500000 0.00675000
    ## 24 0.06053125 0.030731250  0.000000  37.43625 0.026540625 0.01303750
    ## 28 0.04800000 0.024000000  2.880000   0.00000 0.024000000 0.12000000
    ## 30 0.08250000 0.013750000  0.055000   1.54000 0.022550000 0.01375000
    ## 34 0.05683200 0.028416000  0.000000   0.00000 0.000000000 0.03978240
    ## 35 0.00246000 0.003854000  0.098400   0.00000 0.000000000 0.00000000
    ## 36 0.16590000 0.030020000  0.316000   1.89600 0.011850000 0.03555000
    ## 37 1.24000000 0.098000000  0.400000  11.00000 0.184000000 0.11400000
    ## 39 0.00100000 0.002900000  0.060000   0.00000 0.000400000 0.00030000
    ## 41 1.86300000 0.062100000  4.860000   1.62000 0.110700000 0.64800000
    ## 42 0.33855000 0.022875000  3.385500   0.00000 0.042090000 0.15463500
    ## 43 0.05040000 0.017280000  0.144000  21.16800 0.008640000 0.00792000
    ## 44 0.06930000 0.011340000  0.252000   0.15750 0.000000000 0.01197000
    ## 45 0.00031500 0.000220500  0.018900   0.00000 0.000000000 0.00059850
    ## 48 0.65940000 0.072660000 13.272000   0.00000 0.141120000 0.11172000
    ## 49 0.65541656 0.089143031  2.328244   0.00000 0.065701125 0.08691047
    ## 50 0.70804125 0.006857156  5.708981   0.00000 0.003348844 0.06330909
    ## 51 0.47840625 0.005103000  2.312297   0.00000 0.002392031 0.06219281
    ##          NIAC        VB6       FOLA    FA        FF       FDFE      VB12
    ## 1  5.87076000 0.66920000 199.920000 194.6  5.320000 336.280000 1.8956000
    ## 2  0.22448000 0.09272000  12.200000   0.0 12.200000  12.200000 1.2932000
    ## 3  0.31920000 0.17616000   9.600000   0.0  9.600000   9.600000 0.0000000
    ## 5  0.83596800 0.22690560  56.726400   0.0 56.726400  56.726400 0.0000000
    ## 6  0.67843200 0.00355200   7.104000   0.0  7.104000   7.104000 0.0000000
    ## 7  0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 8  0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 9  0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 10 0.12960000 0.01200000   3.840000   0.0  3.840000   3.840000 0.2544000
    ## 12 0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 13 0.19680000 0.10800000  19.200000   0.0 19.200000  21.600000 0.9360000
    ## 14 8.27604000 0.53878000  15.800000   0.0 15.800000  15.800000 3.9500000
    ## 16 0.10460000 0.01260000   1.400000   0.0  1.400000   1.400000 0.0000000
    ## 17 0.06496000 0.06720000  10.640000   0.0 10.640000  10.640000 0.0000000
    ## 18 0.06804000 0.06293700  15.309000   0.0 15.309000  15.309000 0.7059150
    ## 19 0.07625000 0.01825000  24.250000   0.0 24.250000  24.250000 0.0000000
    ## 20 0.23735000 0.03877500  75.787500   0.0 75.787500  75.787500 0.0000000
    ## 21 0.02260000 0.02090500   5.085000   0.0  5.085000   5.085000 0.2344750
    ## 22 0.01596125 0.01243000   2.260000   0.0  2.260000   2.260000 0.1469000
    ## 23 0.02900000 0.03000000   4.750000   0.0  4.750000   4.750000 0.0000000
    ## 24 0.22350000 0.10430000   4.656250   0.0  4.656250   4.656250 0.0000000
    ## 28 2.46240000 0.22080000  28.800000   0.0 28.800000  28.800000 0.0960000
    ## 30 0.06765000 0.02310000  15.950000   0.0 15.950000  15.950000 0.0000000
    ## 34 0.00000000 0.00000000  14.208000   0.0 14.208000  14.208000 0.0000000
    ## 35 0.00902000 0.00336200   0.082000   0.0  0.082000   0.082000 0.0000000
    ## 36 0.15800000 0.02291000  20.540000   0.0 20.540000  20.540000 0.0000000
    ## 37 3.34600000 0.27600000  46.000000   0.0 46.000000  46.000000 0.0000000
    ## 39 0.00070000 0.00030000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 41 0.31320000 0.12960000  13.500000   0.0 13.500000  13.500000 1.0530000
    ## 42 0.08143500 0.03294000   4.575000   0.0  4.575000   4.575000 0.4117500
    ## 43 0.13896000 0.01692000   8.640000   0.0  8.640000   8.640000 0.0000000
    ## 44 0.03811500 0.00756000   0.630000   0.0  0.630000   0.630000 0.0000000
    ## 45 0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 48 2.39274000 0.16548000   0.000000   0.0  0.840000   0.840000 0.1512000
    ## 49 0.88664625 0.09041878   1.435219   0.0  1.435219   1.435219 0.2950172
    ## 50 0.02312297 0.01339537   3.189375   0.0  3.189375   3.189375 0.2248509
    ## 51 0.01483059 0.01259803   2.870437   0.0  2.870437   2.870437 0.1323591
    ##         VARA        RET         BCAR       ACAR        CRYP LYCO
    ## 1  277.20000 277.200000    0.0000000   0.000000   0.0000000    0
    ## 2  134.20000 134.200000    9.7600000   0.000000   0.0000000    0
    ## 3    1.44000   0.000000   12.4800000  12.000000   0.0000000    0
    ## 5    5.97120   0.000000   23.8848000  23.884800  80.6112000    0
    ## 6    0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 7    0.30000   0.000000    2.7000000   0.000000   0.0000000    0
    ## 8    0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 9    0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 10  26.88000  26.880000    0.0000000   0.000000   0.0000000    0
    ## 12   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 13 436.80000 429.600000   76.8000000   2.400000   2.4000000    0
    ## 14   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 16   0.80000   0.000000    5.8000000   0.000000   5.2000000    0
    ## 17   0.00000   0.000000    0.5600000   0.000000   0.0000000    0
    ## 18 225.38250 219.429000   72.2925000   0.000000   0.0000000    0
    ## 19  29.75000   0.000000  356.0000000   0.000000   0.0000000    0
    ## 20 162.73750   0.000000 1949.9125000   0.000000   0.0000000    0
    ## 21  74.86250  72.885000   24.0125000   0.000000   0.0000000    0
    ## 22  32.20500  30.933750   13.7012500   0.000000   1.2712500    0
    ## 23   0.00000   0.000000    0.2500000   0.000000   0.0000000    0
    ## 24   8.38125   0.000000   96.8500000   9.778125   3.2593750    0
    ## 28   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 30  13.75000   0.000000  164.4500000   2.200000   0.0000000    0
    ## 34   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 35   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 36  30.02000  15.800000   97.1700000 119.290000  18.1700000    0
    ## 37  26.00000   0.000000  132.0000000  46.000000 320.0000000    0
    ## 39   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 41 318.60000 313.200000   51.3000000   0.000000   0.0000000    0
    ## 42  42.09000  41.175000    6.4050000   0.000000   0.0000000    0
    ## 43   0.36000   0.000000    2.5200000   0.000000   0.0000000    0
    ## 44   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 45   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 48   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 49   8.93025   8.770781    0.4784062   0.000000   0.0000000    0
    ## 50  23.12297  22.644562    4.4651250   0.000000   0.1594687    0
    ## 51  31.57481  30.618000   12.4385625   0.000000   0.0000000    0
    ##             LZ       ATOC           VK      CHOLE        SFAT       S040
    ## 1    41.720000 0.18200000   0.50400000   0.000000  0.42000000 0.00000000
    ## 2     0.000000 0.07320000   0.48800000  19.520000  3.06708000 0.18788000
    ## 3    10.560000 0.04800000   0.24000000   0.000000  0.05376000 0.00000000
    ## 5    80.611200 0.59712000   0.00000000   0.000000  0.04179840 0.00000000
    ## 6     0.000000 0.03552000   0.35520000   0.000000  0.00710400 0.00000000
    ## 7     0.000000 0.24300000   0.75000000   0.000000  0.58110000 0.00000000
    ## 8     0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 9     0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 10    0.000000 0.17280000   1.92000000   6.720000  6.27840000 0.22176000
    ## 12    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 13   81.600000 1.22400000   3.12000000 220.800000 24.78960000 1.17840000
    ## 14    0.000000 0.69520000   3.16000000 129.560000  9.96506000 0.00000000
    ## 16    3.600000 0.07200000   0.36000000   0.000000  0.04960000 0.00000000
    ## 17    2.240000 0.01120000   0.22400000   0.000000  0.02352000 0.00000000
    ## 18    0.000000 0.24664500   2.38140000  89.302500 17.93874600 0.88962300
    ## 19  888.750000 0.10750000  27.15000000   0.000000  0.02150000 0.00000000
    ## 20 2469.850000 0.55225000 123.61000000   0.000000  0.03113750 0.00000000
    ## 21    0.000000 0.08192500   0.79100000  29.662500  5.95849000 0.29549500
    ## 22    3.813750 0.05650000   0.36725000  12.288750  2.26098875 0.10424250
    ## 23    1.000000 0.00500000   0.10000000   0.000000  0.01050000 0.00000000
    ## 24  158.778125 0.17228125   3.44562500   0.000000  0.02700625 0.00000000
    ## 28    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 30  152.350000 0.09900000  13.25500000   0.000000  0.00990000 0.00000000
    ## 34    0.000000 0.00000000   0.00000000   0.000000  0.00568320 0.00000000
    ## 35    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 36  346.020000 0.07900000  29.94100000   4.740000  1.28217000 0.07663000
    ## 37 1802.000000 0.18000000   0.80000000   0.000000  0.39200000 0.00000000
    ## 39    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 41    0.000000 0.81000000   0.81000000 118.800000 18.33300000 0.97200000
    ## 42    0.000000 0.06405000   0.27450000   9.150000  1.70647500 0.06862500
    ## 43    9.360000 0.10440000   0.79200000   0.000000  0.00540000 0.00000000
    ## 44    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 45    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 48    0.000000 0.12180000   0.00000000  17.220000  0.46746000 0.00000000
    ## 49    0.000000 0.04305656   0.03189375   4.146187  0.00000000 0.00000000
    ## 50    0.637875 0.07654500   0.23920312  12.119625  2.00962519 0.07000678
    ## 51    0.000000 0.04146187   0.39867188  14.192719  3.04043119 0.15659831
    ##          S060       S080       S100       S120      S140        S160
    ## 1  0.00000000 0.00000000 0.00000000 0.00000000 0.0050400  0.36876000
    ## 2  0.09760000 0.04880000 0.11956000 0.13420000 0.4270000  1.36152000
    ## 3  0.00000000 0.00000000 0.00048000 0.00096000 0.0009600  0.04896000
    ## 5  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.04179840
    ## 6  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00710400
    ## 7  0.00000000 0.00150000 0.00390000 0.01860000 0.0057000  0.26520000
    ## 8  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 9  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 10 0.08016000 0.04560000 0.08688000 0.09552000 0.2923200  2.62320000
    ## 12 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 13 0.69600000 0.40560000 0.91200000 1.02000000 3.6624000 10.00320000
    ## 14 0.00000000 0.00000000 0.00000000 0.01896000 0.7631400  5.61216000
    ## 16 0.00000000 0.00000000 0.00000000 0.00060000 0.0008000  0.02800000
    ## 17 0.00000000 0.00000000 0.00000000 0.00000000 0.0022400  0.01904000
    ## 18 0.44991450 0.23728950 0.51030000 0.46012050 2.8321650  8.33745150
    ## 19 0.00000000 0.00000000 0.00000000 0.00075000 0.0000000  0.01800000
    ## 20 0.00000000 0.00000000 0.00000000 0.00000000 0.0011750  0.02702500
    ## 21 0.14944250 0.07881750 0.16950000 0.15283250 0.9407250  2.76934750
    ## 22 0.05325125 0.03234625 0.07189625 0.06893000 0.3599050  1.04652125
    ## 23 0.00000000 0.00000000 0.00000000 0.00000000 0.0010000  0.00850000
    ## 24 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.02328125
    ## 28 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 30 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00880000
    ## 34 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00284160
    ## 35 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 36 0.04740000 0.02844000 0.06004000 0.06162000 0.1761700  0.56959000
    ## 37 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.36800000
    ## 39 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 41 0.56700000 0.32400000 0.75600000 0.83700000 3.0510000  8.26200000
    ## 42 0.06862500 0.06862500 0.06862500 0.07045500 0.2717550  0.75853500
    ## 43 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00432000
    ## 44 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 45 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 48 0.00168000 0.00000000 0.00000000 0.00000000 0.0189000  0.30576000
    ## 49 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 50 0.05756822 0.03635887 0.08978091 0.10221947 0.3269109  0.91838053
    ## 51 0.03891037 0.04879744 0.08978091 0.06346856 0.5761606  1.23795591
    ##         S180       MFAT       M161       M181       M201         M221
    ## 1  0.0364000  0.6652800 0.00308000  0.6487600 0.01260000 0.0005600000
    ## 2  0.5929200  1.3664000 0.06588000  1.2395200 0.00488000 0.0000000000
    ## 3  0.0024000  0.0153600 0.00480000  0.0105600 0.00000000 0.0000000000
    ## 5  0.0000000  0.0656832 0.00895680  0.0537408 0.00000000 0.0000000000
    ## 6  0.0000000  0.0532800 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 7  0.2928000  2.2653000 0.00000000  2.2677000 0.00000000 0.0000000000
    ## 8  0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 9  0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 10 2.6904000  2.4878400 0.07056000  2.3697600 0.00000000 0.0000000000
    ## 12 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 13 4.5576000 10.7040000 0.86400000  9.8352000 0.00480000 0.0000000000
    ## 14 2.9403800 11.8452600 0.96696000 10.0835600 0.09006000 0.0000000000
    ## 16 0.0092000  0.5254000 0.00180000  0.1860000 0.06820000 0.2526000000
    ## 17 0.0022400  0.0072800 0.00000000  0.0072800 0.00000000 0.0000000000
    ## 18 3.4079535  7.9870455 0.85390200  6.7232025 0.00000000 0.0000000000
    ## 19 0.0010000  0.0122500 0.00025000  0.0115000 0.00000000 0.0000000000
    ## 20 0.0017625  0.0041125 0.00058750  0.0035250 0.00000000 0.0000000000
    ## 21 1.1319775  2.6529575 0.28363000  2.2331625 0.00000000 0.0000000000
    ## 22 0.4237500  1.0168587 0.09520250  0.8674162 0.00720375 0.0000000000
    ## 23 0.0010000  0.0032500 0.00000000  0.0032500 0.00000000 0.0000000000
    ## 24 0.0037250  0.0037250 0.00000000  0.0037250 0.00000000 0.0000000000
    ## 28 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 30 0.0011000  0.0033000 0.00055000  0.0022000 0.00000000 0.0000000000
    ## 34 0.0000000  0.0028416 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 35 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 36 0.2456900  0.5095500 0.02291000  0.4842700 0.00237000 0.0000000000
    ## 37 0.0240000  0.7440000 0.00000000  0.7440000 0.00000000 0.0000000000
    ## 39 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 41 3.5532000  8.0163000 0.55620000  7.4601000 0.00000000 0.0000000000
    ## 42 0.3339750  0.7429800 0.00000000  0.7429800 0.00000000 0.0000000000
    ## 43 0.0010800  0.0154800 0.00036000  0.0151200 0.00000000 0.0000000000
    ## 44 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 45 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 48 0.1411200  0.7077000 0.04452000  0.6531000 0.01008000 0.0000000000
    ## 49 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 50 0.3442930  0.8458222 0.05214628  0.7477490 0.00637875 0.0003189375
    ## 51 0.5458615  1.3955110 0.14718966  1.1749657 0.00000000 0.0000000000
    ##          PFAT       P182       P183      P184        P204         P205
    ## 1  0.68096000 0.65968000 0.01904000 0.0000000 0.000000000 0.0000000000
    ## 2  0.17812000 0.15128000 0.01952000 0.0000000 0.000000000 0.0000000000
    ## 3  0.03504000 0.02208000 0.01296000 0.0000000 0.000000000 0.0000000000
    ## 5  0.08956800 0.06866880 0.02089920 0.0000000 0.000000000 0.0000000000
    ## 6  0.00355200 0.00355200 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 7  0.00810000 0.00660000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 8  0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 9  0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 10 0.44208000 0.41472000 0.02736000 0.0000000 0.000000000 0.0000000000
    ## 12 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 13 1.63200000 1.04880000 0.53280000 0.0024000 0.033600000 0.0024000000
    ## 14 0.71890000 0.56248000 0.06952000 0.0000000 0.063200000 0.0047400000
    ## 16 0.19080000 0.08860000 0.09160000 0.0000000 0.000000000 0.0000000000
    ## 17 0.00952000 0.00728000 0.00224000 0.0000000 0.000000000 0.0000000000
    ## 18 0.80117100 0.49073850 0.31043250 0.0000000 0.000000000 0.0000000000
    ## 19 0.07975000 0.03250000 0.04250000 0.0000000 0.000500000 0.0000000000
    ## 20 0.07402500 0.04582500 0.02820000 0.0000000 0.000000000 0.0000000000
    ## 21 0.26611500 0.16300250 0.10311250 0.0000000 0.000000000 0.0000000000
    ## 22 0.11624875 0.07924125 0.03262875 0.0002825 0.001130000 0.0004237500
    ## 23 0.00425000 0.00325000 0.00100000 0.0000000 0.000000000 0.0000000000
    ## 24 0.02886875 0.02514375 0.00372500 0.0000000 0.000000000 0.0000000000
    ## 28 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 30 0.04070000 0.01155000 0.02860000 0.0000000 0.000000000 0.0000000000
    ## 34 0.01136640 0.00284160 0.00852480 0.0000000 0.000000000 0.0000000000
    ## 35 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 36 0.22199000 0.12087000 0.09875000 0.0000000 0.000000000 0.0000000000
    ## 37 1.19800000 1.16600000 0.03600000 0.0000000 0.000000000 0.0000000000
    ## 39 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 41 1.22040000 0.74250000 0.47250000 0.0000000 0.000000000 0.0081000000
    ## 42 0.17842500 0.10980000 0.06862500 0.0000000 0.000000000 0.0000000000
    ## 43 0.05580000 0.03240000 0.02340000 0.0000000 0.000000000 0.0000000000
    ## 44 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 45 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 48 0.14700000 0.13440000 0.00672000 0.0000000 0.005460000 0.0000000000
    ## 49 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 50 0.14240559 0.11848528 0.01020600 0.0000000 0.005581406 0.0009568125
    ## 51 0.14336241 0.10158159 0.04162134 0.0000000 0.000000000 0.0000000000
    ##           P225       P226       VITD      CHOLN VITE_ADD B12_ADD F_TOTAL
    ## 1  0.000000000 0.00000000 0.95200000   7.336000        0  1.8956 0.00000
    ## 2  0.000000000 0.00000000 2.92800000  40.016000        0  0.0000 0.00000
    ## 3  0.000000000 0.00000000 0.00000000   4.704000        0  0.0000 0.32160
    ## 5  0.000000000 0.00000000 0.00000000  18.510720        0  0.0000 1.19424
    ## 6  0.000000000 0.00000000 0.00000000   9.235200        0  0.0000 0.00000
    ## 7  0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 8  0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 9  0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 10 0.000000000 0.00000000 0.00000000  10.416000        0  0.0000 0.00000
    ## 12 0.000000000 0.00000000 0.00000000   2.210400        0  0.0000 0.00000
    ## 13 0.000000000 0.00960000 0.72000000  62.400000        0  0.0000 0.00000
    ## 14 0.025280000 0.00158000 0.31600000 119.922000        0  0.0000 0.00000
    ## 16 0.000000000 0.00000000 0.00000000   4.480000        0  0.0000 0.00000
    ## 17 0.000000000 0.00000000 0.00000000   3.416000        0  0.0000 0.00000
    ## 18 0.000000000 0.00000000 0.51030000  14.033250        0  0.0000 0.00000
    ## 19 0.000000000 0.00000000 0.00000000   3.825000        0  0.0000 0.00000
    ## 20 0.000000000 0.00000000 0.00000000   7.755000        0  0.0000 0.00000
    ## 21 0.000000000 0.00000000 0.16950000   4.661250        0  0.0000 0.00000
    ## 22 0.000565000 0.00014125 0.33900000   3.107500        0  0.0000 0.00000
    ## 23 0.000000000 0.00000000 0.00000000   1.525000        0  0.0000 0.00000
    ## 24 0.000000000 0.00000000 0.00000000   2.560938        0  0.0000 0.00000
    ## 28 0.000000000 0.00000000 0.00000000  48.480000        0  0.0000 0.00000
    ## 30 0.000000000 0.00000000 0.00000000   3.685000        0  0.0000 0.00000
    ## 34 0.000000000 0.00000000 0.00000000   1.136640        0  0.0000 0.00000
    ## 35 0.000000000 0.00000000 0.00000000   0.188600        0  0.0000 0.00000
    ## 36 0.000000000 0.00000000 0.00000000  11.692000        0  0.0000 0.00000
    ## 37 0.000000000 0.00000000 0.00000000  57.800000        0  0.0000 0.00000
    ## 39 0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 41 0.000000000 0.00000000 0.54000000  70.200000        0  0.0000 0.00000
    ## 42 0.000000000 0.00000000 1.18950000  13.084500        0  0.0000 0.00000
    ## 43 0.000000000 0.00000000 0.00000000   2.052000        0  0.0000 0.24840
    ## 44 0.000000000 0.00000000 0.00000000   0.693000        0  0.0000 0.00000
    ## 45 0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 48 0.000000000 0.00000000 0.29400000  26.208000        0  0.0000 0.00000
    ## 49 0.000000000 0.00000000 0.01594687   6.123600        0  0.0000 0.00000
    ## 50 0.001594687 0.00000000 0.04784062   2.455819        0  0.0000 0.00000
    ## 51 0.000000000 0.00000000 0.09568125   2.455819        0  0.0000 0.00000
    ##    F_CITMLB F_OTHER F_JUICE   V_TOTAL V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO
    ## 1    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 2    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 3    0.0000  0.3216 0.00000 0.0000000  0.0000             0              0
    ## 5    0.0000  0.0000 1.19424 0.0000000  0.0000             0              0
    ## 6    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 7    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 8    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 9    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 10   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 12   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 13   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 14   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 16   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 17   0.0000  0.0000 0.00000 0.3528000  0.0000             0              0
    ## 18   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 19   0.0000  0.0000 0.00000 0.6250000  0.6250             0              0
    ## 20   0.0000  0.0000 0.00000 0.5875000  0.5875             0              0
    ## 21   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 22   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 23   0.0000  0.0000 0.00000 0.1575000  0.0000             0              0
    ## 24   0.0000  0.0000 0.00000 0.3864687  0.0000             0              0
    ## 28   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 30   0.0000  0.0000 0.00000 0.5005000  0.0000             0              0
    ## 34   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 35   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 36   0.0000  0.0000 0.00000 0.5846000  0.0000             0              0
    ## 37   0.0000  0.0000 0.00000 1.2200000  0.0000             0              0
    ## 39   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 41   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 42   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 43   0.2484  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 44   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 45   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 48   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 49   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 50   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 51   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ##    V_REDOR_OTHER V_STARCHY_TOTAL V_STARCHY_POTATO V_STARCHY_OTHER
    ## 1              0            0.00                0            0.00
    ## 2              0            0.00                0            0.00
    ## 3              0            0.00                0            0.00
    ## 5              0            0.00                0            0.00
    ## 6              0            0.00                0            0.00
    ## 7              0            0.00                0            0.00
    ## 8              0            0.00                0            0.00
    ## 9              0            0.00                0            0.00
    ## 10             0            0.00                0            0.00
    ## 12             0            0.00                0            0.00
    ## 13             0            0.00                0            0.00
    ## 14             0            0.00                0            0.00
    ## 16             0            0.00                0            0.00
    ## 17             0            0.00                0            0.00
    ## 18             0            0.00                0            0.00
    ## 19             0            0.00                0            0.00
    ## 20             0            0.00                0            0.00
    ## 21             0            0.00                0            0.00
    ## 22             0            0.00                0            0.00
    ## 23             0            0.00                0            0.00
    ## 24             0            0.00                0            0.00
    ## 28             0            0.00                0            0.00
    ## 30             0            0.00                0            0.00
    ## 34             0            0.00                0            0.00
    ## 35             0            0.00                0            0.00
    ## 36             0            0.00                0            0.00
    ## 37             0            1.22                0            1.22
    ## 39             0            0.00                0            0.00
    ## 41             0            0.00                0            0.00
    ## 42             0            0.00                0            0.00
    ## 43             0            0.00                0            0.00
    ## 44             0            0.00                0            0.00
    ## 45             0            0.00                0            0.00
    ## 48             0            0.00                0            0.00
    ## 49             0            0.00                0            0.00
    ## 50             0            0.00                0            0.00
    ## 51             0            0.00                0            0.00
    ##      V_OTHER V_LEGUMES G_TOTAL G_WHOLE G_REFINED PF_TOTAL PF_MPS_TOTAL
    ## 1  0.0000000         0  0.9184  0.9184         0   0.0000       0.0000
    ## 2  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 3  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 5  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 6  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 7  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 8  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 9  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 10 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 12 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 13 0.0000000         0  0.0000  0.0000         0   0.1440       0.0000
    ## 14 0.0000000         0  0.0000  0.0000         0   5.0876       5.0876
    ## 16 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 17 0.3528000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 18 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 19 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 20 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 21 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 22 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 23 0.1575000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 24 0.3864687         0  0.0000  0.0000         0   0.0000       0.0000
    ## 28 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 30 0.5005000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 34 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 35 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 36 0.5846000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 37 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 39 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 41 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 42 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 43 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 44 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 45 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 48 0.0000000         0  0.0000  0.0000         0   1.4826       1.4826
    ## 49 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 50 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 51 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ##    PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS
    ## 1   0.0000       0.0000        0        0           0            0   0.000
    ## 2   0.0000       0.0000        0        0           0            0   0.000
    ## 3   0.0000       0.0000        0        0           0            0   0.000
    ## 5   0.0000       0.0000        0        0           0            0   0.000
    ## 6   0.0000       0.0000        0        0           0            0   0.000
    ## 7   0.0000       0.0000        0        0           0            0   0.000
    ## 8   0.0000       0.0000        0        0           0            0   0.000
    ## 9   0.0000       0.0000        0        0           0            0   0.000
    ## 10  0.0000       0.0000        0        0           0            0   0.000
    ## 12  0.0000       0.0000        0        0           0            0   0.000
    ## 13  0.0000       0.0000        0        0           0            0   0.144
    ## 14  5.0876       0.0000        0        0           0            0   0.000
    ## 16  0.0000       0.0000        0        0           0            0   0.000
    ## 17  0.0000       0.0000        0        0           0            0   0.000
    ## 18  0.0000       0.0000        0        0           0            0   0.000
    ## 19  0.0000       0.0000        0        0           0            0   0.000
    ## 20  0.0000       0.0000        0        0           0            0   0.000
    ## 21  0.0000       0.0000        0        0           0            0   0.000
    ## 22  0.0000       0.0000        0        0           0            0   0.000
    ## 23  0.0000       0.0000        0        0           0            0   0.000
    ## 24  0.0000       0.0000        0        0           0            0   0.000
    ## 28  0.0000       0.0000        0        0           0            0   0.000
    ## 30  0.0000       0.0000        0        0           0            0   0.000
    ## 34  0.0000       0.0000        0        0           0            0   0.000
    ## 35  0.0000       0.0000        0        0           0            0   0.000
    ## 36  0.0000       0.0000        0        0           0            0   0.000
    ## 37  0.0000       0.0000        0        0           0            0   0.000
    ## 39  0.0000       0.0000        0        0           0            0   0.000
    ## 41  0.0000       0.0000        0        0           0            0   0.000
    ## 42  0.0000       0.0000        0        0           0            0   0.000
    ## 43  0.0000       0.0000        0        0           0            0   0.000
    ## 44  0.0000       0.0000        0        0           0            0   0.000
    ## 45  0.0000       0.0000        0        0           0            0   0.000
    ## 48  0.0000       1.4826        0        0           0            0   0.000
    ## 49  0.0000       0.0000        0        0           0            0   0.000
    ## 50  0.0000       0.0000        0        0           0            0   0.000
    ## 51  0.0000       0.0000        0        0           0            0   0.000
    ##    PF_SOY PF_NUTSDS PF_LEGUMES   D_TOTAL  D_MILK D_YOGURT  D_CHEESE OILS
    ## 1       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 2       0         0          0 1.0004000 1.00040        0 0.0000000    0
    ## 3       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 5       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 6       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 7       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 8       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 9       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 10      0         0          0 0.1536000 0.15360        0 0.0000000    0
    ## 12      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 13      0         0          0 0.3360000 0.33600        0 0.0000000    0
    ## 14      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 16      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 17      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 18      0         0          0 1.9986750 0.00000        0 1.9986750    0
    ## 19      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 20      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 21      0         0          0 0.6638750 0.00000        0 0.6638750    0
    ## 22      0         0          0 0.3813750 0.00000        0 0.3813750    0
    ## 23      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 24      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 28      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 30      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 34      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 35      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 36      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 37      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 39      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 41      0         0          0 0.6210000 0.62100        0 0.0000000    0
    ## 42      0         0          0 0.3751500 0.37515        0 0.0000000    0
    ## 43      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 44      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 45      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 48      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 49      0         0          0 0.3747516 0.00000        0 0.3747516    0
    ## 50      0         0          0 0.3747516 0.00000        0 0.3747516    0
    ## 51      0         0          0 0.3747516 0.00000        0 0.3747516    0
    ##    SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 1    0.000000    0.19880    0.000        1
    ## 2    3.342800    0.00000    0.000        1
    ## 3    0.000000    0.00000    0.000        1
    ## 5    0.000000    0.00000    0.000        1
    ## 6    0.000000    0.00000    0.000        1
    ## 7    2.991000    0.81300    0.000        1
    ## 8    0.000000    1.99584    0.000        1
    ## 9    0.000000    0.00000    0.000        1
    ## 10   8.203200    6.53760    0.000        1
    ## 12   0.000000   15.76752    0.000        1
    ## 13  37.776000    9.81600    0.000        1
    ## 14  12.371400    0.00000    0.000        1
    ## 16   0.000000    0.00000    0.000        1
    ## 17   0.000000    0.00000    0.000        1
    ## 18  25.183305    0.00000    0.000        1
    ## 19   0.000000    0.00000    0.000        1
    ## 20   0.000000    0.00000    0.000        1
    ## 21   8.364825    0.00000    0.000        1
    ## 22   3.055238    0.00000    0.000        1
    ## 23   0.000000    0.00000    0.000        1
    ## 24   0.000000    0.00000    0.000        1
    ## 28   0.000000    0.00000    1.344        1
    ## 30   0.000000    0.00000    0.000        1
    ## 34   0.000000    0.00000    0.000        1
    ## 35   0.000000    1.89420    0.000        1
    ## 36   1.911800    0.00000    0.000        1
    ## 37   0.000000    0.00000    0.000        1
    ## 39   0.000000    1.49800    0.000        1
    ## 41  28.755000   11.25900    0.000        1
    ## 42   2.415600    0.00000    0.000        1
    ## 43   0.000000    0.00000    0.000        1
    ## 44   0.000000    6.15825    0.000        1
    ## 45   0.000000    0.74844    0.000        1
    ## 48   0.000000    0.00000    0.000        1
    ## 49   0.000000    0.00000    0.000        1
    ## 50   2.691832    0.00000    0.000        1
    ## 51   4.265789    0.00000    0.000        1
    ##                                                                  Food_Description
    ## 1                                                                        Cheerios
    ## 2                                                      Milk, cow's, fluid, 2% fat
    ## 3                                                                     Banana, raw
    ## 5                                    Orange juice, canned, bottled or in a carton
    ## 6                                               Coffee, made from ground, regular
    ## 7                                                        Cream substitute, liquid
    ## 8                                                Sugar, white, granulated or lump
    ## 9                                                     Water, bottled, unsweetened
    ## 10          M&M's Milk Chocolate Candies (formerly M&M's Plain Chocolate Candies)
    ## 12                                                          Soft drink, cola-type
    ## 13                                  Ice cream, rich, flavors other than chocolate
    ## 14                     Ground beef, less than 80% lean, cooked (formerly regular)
    ## 16                                                                        Mustard
    ## 17                                                            Onions, mature, raw
    ## 18                                                                Cheese, Cheddar
    ## 19                                                          Lettuce, arugula, raw
    ## 20                             Endive, chicory, escarole, or romaine lettuce, raw
    ## 21                                                                Cheese, Cheddar
    ## 22                                                                    Cheese, NFS
    ## 23                                                            Onions, mature, raw
    ## 24                                                      Pepper, sweet, green, raw
    ## 28                                                                           Beer
    ## 30                                                                   Lettuce, raw
    ## 34                                                         Tea, leaf, unsweetened
    ## 35                                                                     Sugar, raw
    ## 36 Beans, string, green, cooked, from canned, fat added in cooking W/ BUTTER, NFS
    ## 37                     Corn, yellow, cooked, from fresh, fat not added in cooking
    ## 39                                                                     Hard candy
    ## 41                               Ice cream, regular, flavors other than chocolate
    ## 42                                                      Milk, cow's, fluid, whole
    ## 43                                                              Strawberries, raw
    ## 44                                                                          Honey
    ## 45                                                                     Sugar, NFS
    ## 48                                Ham, sliced, prepackaged or deli, luncheon meat
    ## 49                                           Cheese, American, nonfat or fat free
    ## 50                                                   Cheese, Cheddar, reduced fat
    ## 51                                                               Cheese, Monterey

    subset(items, OILS==0) #another way

    ##                             RecallRecId UserName
    ## 1  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 2  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 3  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 5  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 6  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 7  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 8  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 9  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 10 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 12 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 13 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 14 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 16 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 17 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 18 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 19 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 20 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 21 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 22 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 23 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 24 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 28 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 30 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 34 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 35 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 36 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 37 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 39 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 41 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 42 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 43 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 44 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 45 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 49 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 50 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 51 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 1  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 2  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 3  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 5  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 6  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 7  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 8  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 9  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 10 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 12 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 13 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 14 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 16 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 17 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 18 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 19 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 20 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 21 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 22 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 23 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 24 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 28 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 30 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 34 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 35 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 36 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 37 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 39 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 41 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 42 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 43 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 44 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 45 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 49 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 50 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 51 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 1             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 2             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 3             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 5             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 6             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 7             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 8             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 9             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 10            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 12            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 13            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 14            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 16            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 17            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 18            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 19            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 20            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 21            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 22            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 23            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 24            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 28            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 30            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 34            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 35            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 36            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 37            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 39            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 41            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 42            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 43            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 44            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 45            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 49            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 50            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 51            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No         Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 1       1 05/20/2018 11:00        1       4                  1        1
    ## 2       1 05/20/2018 11:00        1       4                  1        1
    ## 3       1 05/20/2018 11:00        1       4                  1        1
    ## 5       1 05/20/2018 11:00        1       4                  1        1
    ## 6       1 05/20/2018 11:00        1       4                  1        1
    ## 7       1 05/20/2018 11:00        1       4                  1        1
    ## 8       1 05/20/2018 11:00        1       4                  1        1
    ## 9       2 05/20/2018 14:00        6       1                  4        6
    ## 10      2 05/20/2018 14:00        6       1                  4        6
    ## 12      3 05/20/2018 17:00        3       2                  3        3
    ## 13      3 05/20/2018 17:00        3       2                  3        3
    ## 14      3 05/20/2018 17:00        3       2                  3        3
    ## 16      3 05/20/2018 17:00        3       2                  3        3
    ## 17      3 05/20/2018 17:00        3       2                  3        3
    ## 18      3 05/20/2018 17:00        3       2                  3        3
    ## 19      3 05/20/2018 17:00        3       2                  3        3
    ## 20      3 05/20/2018 17:00        3       2                  3        3
    ## 21      3 05/20/2018 17:00        3       2                  3        3
    ## 22      3 05/20/2018 17:00        3       2                  3        3
    ## 23      3 05/20/2018 17:00        3       2                  3        3
    ## 24      3 05/20/2018 17:00        3       2                  3        3
    ## 28      4 05/20/2018 19:30        6       1                  2        7
    ## 30      5 05/20/2018 22:00        5       1                  6        1
    ## 34      5 05/20/2018 22:00        5       1                  6        1
    ## 35      5 05/20/2018 22:00        5       1                  6        1
    ## 36      5 05/20/2018 22:00        5       1                  6        1
    ## 37      5 05/20/2018 22:00        5       1                  6        1
    ## 39      6  05/21/2018 0:00        6       1                  4       98
    ## 41      7  05/21/2018 2:00        7       1                  4        1
    ## 42      7  05/21/2018 2:00        7       1                  4        1
    ## 43      7  05/21/2018 2:00        7       1                  4        1
    ## 44      7  05/21/2018 2:00        7       1                  4        1
    ## 45      7  05/21/2018 2:00        7       1                  4        1
    ## 48      8  05/21/2018 3:00        6       3                  5        1
    ## 49      8  05/21/2018 3:00        6       3                  5        1
    ## 50      8  05/21/2018 3:00        6       3                  5        1
    ## 51      8  05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType                           FoodSrce CodeNum FoodCode
    ## 1        1        1             Other store (any type)       1 57123000
    ## 2        2        2             Other store (any type)       2 11112110
    ## 3        3        2             Other store (any type)       3 63107010
    ## 5        5        1             Other store (any type)       5 61210220
    ## 6        6        1             Other store (any type)       6 92101000
    ## 7        7        2             Other store (any type)       7 12210200
    ## 8        8        2             Other store (any type)       8 91101010
    ## 9        9        1                    Other cafeteria       9 94100100
    ## 10      10        1                    Other cafeteria      10 91746100
    ## 12      12        1                                         12 92410310
    ## 13      13        1                                         13 13110120
    ## 14      14        1                                         14 21501000
    ## 16      14        1                                         16 75506010
    ## 17      14        1                                         17 75117020
    ## 18      14        1                                         18 14104100
    ## 19      15        1                                         19 75113080
    ## 20      15        1                                         20 72116000
    ## 21      15        1                                         21 14104100
    ## 22      15        1                                         22 14010000
    ## 23      15        1                                         23 75117020
    ## 24      15        1                                         24 75122100
    ## 28      16        1             Other store (any type)      28 93101000
    ## 30      18        1    Other restaurant, bar or tavern      30 75113000
    ## 34      21        1    Other restaurant, bar or tavern      34 92302000
    ## 35      22        2    Other restaurant, bar or tavern      35 91104200
    ## 36      23        1    Other restaurant, bar or tavern      36 75205033
    ## 37      24        1    Other restaurant, bar or tavern      37 75216111
    ## 39      26        1                        Other: Gift      39 91745020
    ## 41      28        1 Fast food or drive-thru restaurant      41 13110100
    ## 42      28        1 Fast food or drive-thru restaurant      42 11111000
    ## 43      28        1 Fast food or drive-thru restaurant      43 63223020
    ## 44      28        1 Fast food or drive-thru restaurant      44 91302010
    ## 45      28        1 Fast food or drive-thru restaurant      45 91101000
    ## 48      29        1             Other store (any type)      48 25230210
    ## 49      29        1             Other store (any type)      49 14410130
    ## 50      29        1             Other store (any type)      50 14104110
    ## 51      29        1             Other store (any type)      51 14106200
    ##    ModCode  HowMany SubCode PortionCode   FoodAmt      KCAL       PROT
    ## 1        0  1.00000       0       10205  28.00000 105.84000  3.3852000
    ## 2        0  1.00000       0       10205 244.00000 122.00000  8.0520000
    ## 3        0  8.00000       0       61935  48.00000  42.72000  0.5232000
    ## 5        0  9.60000       0       30000 298.56000 146.29440  2.0302080
    ## 6        0 12.00000       0       30000 355.20000   3.55200  0.4262400
    ## 7        0 12.00000       0       63480  30.00000  40.80000  0.3000000
    ## 8        0  2.00000       0       22000   8.40000  32.50800  0.0000000
    ## 9        0 10.14000       0       30000 300.14400   0.00000  0.0000000
    ## 10       0  1.00000       0       61538  48.00000 236.16000  2.0784000
    ## 12       0 24.00000       0       30000 736.80000 272.61600  0.5157600
    ## 13       0  2.00000       0       61396 240.00000 597.60000  8.4000000
    ## 14       0  2.00000       0       64195 158.00000 388.68000 36.7508000
    ## 16       0  4.00000       0       22000  20.00000  13.40000  0.8740000
    ## 17       0  4.00000       0       61401  56.00000  22.40000  0.6160000
    ## 18       0 85.05000       0          98  85.05000 342.75150 21.1774500
    ## 19       0  1.25000       0       10205  25.00000   6.25000  0.6450000
    ## 20       0  1.25000       0       10346  58.75000  11.16250  0.8166250
    ## 21       0  0.25000       0       10010  28.25000 113.84750  7.0342500
    ## 22       0  0.12500       0       10205  14.12500  47.74250  3.2092000
    ## 23       0  0.15625       0       10010  25.00000  10.00000  0.2750000
    ## 24       0  0.31250       0       10010  46.56250   9.31250  0.4004375
    ## 28       0 16.00000       0       30000 480.00000 206.40000  2.2080000
    ## 30       0  1.00000       0       10160  55.00000   7.70000  0.4950000
    ## 34       0  9.60000       0       30000 284.16000   2.84160  0.0000000
    ## 35       0  2.00000       0       22000   8.20000  31.16000  0.0098400
    ## 36  200058  0.50000       0       10029  79.00000  36.34000  0.9875000
    ## 37       0  2.00000       0       61345 200.00000 190.00000  6.7800000
    ## 39       0  5.00000 1000179       61667  10.00000  39.40000  0.0000000
    ## 41       0  2.25000       0       61396 270.00000 558.90000  9.4500000
    ## 42       0  0.37500       0       10205  91.50000  55.81500  2.8822500
    ## 43       0  3.00000       0       61241  36.00000  11.52000  0.2412000
    ## 44       0  1.50000       0       21000  31.50000  95.76000  0.0945000
    ## 45       0  0.75000       0       22000   3.15000  12.19050  0.0000000
    ## 48       0  1.50000       0       62008  42.00000  55.02000  7.1106000
    ## 49       0 15.94687       0          98  15.94687  20.09306  3.3568172
    ## 50       0 15.94687       0          98  15.94687  49.27584  4.3614703
    ## 51       0 15.94687       0          98  15.94687  59.48184  3.9037950
    ##           TFAT       CARB       MOIS   ALC    CAFF    THEO        SUGR
    ## 1   1.88440000 20.5044000   1.436400  0.00   0.000  0.0000  1.22080000
    ## 2   4.83120000 11.7120000 217.672400  0.00   0.000  0.0000 12.34640000
    ## 3   0.15840000 10.9632000  35.956800  0.00   0.000  0.0000  5.87040000
    ## 5   0.35827200 34.4538240 260.404032  0.00   0.000  0.0000 24.81033600
    ## 6   0.07104000  0.0000000 353.033280  0.00 142.080  0.0000  0.00000000
    ## 7   2.99100000  3.4140000  23.181000  0.00   0.000  0.0000  3.41400000
    ## 8   0.00000000  8.3983200   0.001680  0.00   0.000  0.0000  8.38320000
    ## 9   0.00000000  0.0000000 300.083971  0.00   0.000  0.0000  0.00000000
    ## 10 10.14240000 34.1712000   0.816000  0.00   6.720 68.6400 30.56640000
    ## 12  0.14736000 70.4380800 665.404080  0.00  58.944  0.0000 66.09096000
    ## 13 38.88000000 53.4960000 137.280000  0.00   0.000  0.0000 49.56000000
    ## 14 25.75400000  0.0000000  91.956000  0.00   0.000  0.0000  0.00000000
    ## 16  0.80200000  1.0660000  16.530000  0.00   0.000  0.0000  0.17200000
    ## 17  0.05600000  5.2304000  49.901600  0.00   0.000  0.0000  2.37440000
    ## 18 28.18557000  1.0886400  31.255875  0.00   0.000  0.0000  0.44226000
    ## 19  0.16500000  0.9125000  22.927500  0.00   0.000  0.0000  0.51250000
    ## 20  0.15862500  2.2207500  54.913625  0.00   0.000  0.0000  0.41712500
    ## 21  9.36205000  0.3616000  10.381875  0.00   0.000  0.0000  0.14690000
    ## 22  3.62730000  0.5395750   6.097762  0.00   0.000  0.0000  0.35171250
    ## 23  0.02500000  2.3350000  22.277500  0.00   0.000  0.0000  1.06000000
    ## 24  0.07915625  2.1605000  43.717531  0.00   0.000  0.0000  1.11750000
    ## 28  0.00000000 17.0400000 441.408000 18.72   0.000  0.0000  0.00000000
    ## 30  0.07700000  1.6335000  52.602000  0.00   0.000  0.0000  1.08350000
    ## 34  0.00000000  0.8524800 283.307520  0.00  56.832  5.6832  0.00000000
    ## 35  0.00000000  8.0433800   0.109880  0.00   0.000  0.0000  7.95564000
    ## 36  2.20410000  3.2548000  71.732000  0.00   0.000  0.0000  1.00330000
    ## 37  2.98000000 41.7200000 145.960000  0.00   0.000  0.0000  9.02000000
    ## 39  0.02000000  9.8000000   0.130000  0.00   0.000  0.0000  6.29000000
    ## 41 29.70000000 63.7200000 164.700000  0.00   0.000  0.0000 57.29400000
    ## 42  2.97375000  4.3920000  80.638950  0.00   0.000  0.0000  4.62075000
    ## 43  0.10800000  2.7648000  32.742000  0.00   0.000  0.0000  1.76040000
    ## 44  0.00000000 25.9560000   5.386500  0.00   0.000  0.0000 25.86780000
    ## 45  0.00000000  3.1493700   0.000630  0.00   0.000  0.0000  3.14370000
    ## 48  1.47000000  0.4074000  31.512600  0.00   0.000  0.0000  0.00000000
    ## 49  0.00000000  1.6792059  10.440419  0.00   0.000  0.0000  0.83880562
    ## 50  3.25475719  0.6474431   7.062871  0.00   0.000  0.0000  0.04146187
    ## 51  4.82871375  0.1084387   6.539813  0.00   0.000  0.0000  0.07973437
    ##         FIBE      CALC       IRON      MAGN      PHOS      POTA       SODI
    ## 1  2.6320000 112.28000 9.28760000 35.840000 134.68000 179.48000 139.160000
    ## 2  0.0000000 292.80000 0.04880000 26.840000 224.48000 341.60000 114.680000
    ## 3  1.2480000   2.40000 0.12480000 12.960000  10.56000 171.84000   0.480000
    ## 5  0.8956800  32.84160 0.38812800 32.841600  50.75520 531.43680   5.971200
    ## 6  0.0000000   7.10400 0.03552000 10.656000  10.65600 174.04800   7.104000
    ## 7  0.0000000   2.70000 0.00900000  0.000000  19.20000  57.30000  20.100000
    ## 8  0.0000000   0.08400 0.00420000  0.000000   0.00000   0.16800   0.084000
    ## 9  0.0000000  30.01440 0.00000000  6.002880   0.00000   0.00000   6.002880
    ## 10 1.3440000  50.40000 0.53280000 21.120000  70.08000 125.28000  29.280000
    ## 12 0.0000000  14.73600 0.81048000  0.000000  73.68000  14.73600  29.472000
    ## 13 0.0000000 280.80000 0.81600000 26.400000 252.00000 376.80000 146.400000
    ## 14 0.0000000  50.56000 3.91840000 31.600000 311.26000 504.02000 646.220000
    ## 16 0.6600000  11.60000 0.30200000  9.800000  21.20000  27.60000 227.000000
    ## 17 0.9520000  12.88000 0.11760000  5.600000  16.24000  81.76000   2.240000
    ## 18 0.0000000 613.21050 0.57834000 23.814000 435.45600  83.34900 528.160500
    ## 19 0.4000000  40.00000 0.36500000 11.750000  13.00000  92.25000   6.750000
    ## 20 1.8212500  36.42500 0.52875000 11.750000  20.56250 192.11250  14.687500
    ## 21 0.0000000 203.68250 0.19210000  7.910000 144.64000  27.68500 175.432500
    ## 22 0.0000000 134.18750 0.09181250  4.096250  85.17375  20.76375 115.260000
    ## 23 0.4250000   5.75000 0.05250000  2.500000   7.25000  36.50000   1.000000
    ## 24 0.7915625   4.65625 0.15831250  4.656250   9.31250  81.48438   1.396875
    ## 28 0.0000000  19.20000 0.09600000 28.800000  67.20000 129.60000  19.200000
    ## 30 0.6600000   9.90000 0.22550000  3.850000  11.00000  77.55000   5.500000
    ## 34 0.0000000   0.00000 0.05683200  8.524800   2.84160 105.13920   8.524800
    ## 35 0.0000000   6.80600 0.05822000  0.738000   0.32800  10.90600   2.296000
    ## 36 1.8960000  30.02000 0.67150000 10.270000  16.59000  82.16000 203.820000
    ## 37 4.8000000   6.00000 0.90000000 52.000000 154.00000 434.00000 454.000000
    ## 39 0.0000000   0.30000 0.03000000  0.300000   0.30000   0.50000   3.800000
    ## 41 1.8900000 345.60000 0.24300000 37.800000 283.50000 537.30000 216.000000
    ## 42 0.0000000 103.39500 0.02745000  9.150000  76.86000 120.78000  39.345000
    ## 43 0.7200000   5.76000 0.14760000  4.680000   8.64000  55.08000   0.360000
    ## 44 0.0630000   1.89000 0.13230000  0.630000   1.26000  16.38000   1.260000
    ## 45 0.0000000   0.03150 0.00157500  0.000000   0.00000   0.06300   0.031500
    ## 48 0.0000000   2.10000 0.24360000  7.560000 109.62000 194.04000 551.880000
    ## 49 0.0000000 125.82084 0.00000000 18.338906  50.39213  62.67122 209.860875
    ## 50 0.0000000 121.35572 0.01913625  4.305656  82.92375  10.04653 100.146375
    ## 51 0.0000000 118.96369 0.11481750  4.305656  70.80412  12.91697  95.681250
    ##          ZINC        COPP      SELE        VC         VB1        VB2
    ## 1  4.68440000 0.107800000  6.972000   6.04800 0.371560000 0.39676000
    ## 2  1.17120000 0.014640000  6.100000   0.48800 0.095160000 0.45140000
    ## 3  0.07200000 0.037440000  0.480000   4.17600 0.014880000 0.03504000
    ## 5  0.20899200 0.125395200  0.298560 100.31616 0.137337600 0.11643840
    ## 6  0.07104000 0.007104000  0.000000   0.00000 0.049728000 0.26995200
    ## 7  0.00600000 0.000000000  0.330000   0.00000 0.000000000 0.00000000
    ## 8  0.00084000 0.000588000  0.050400   0.00000 0.000000000 0.00159600
    ## 9  0.00000000 0.021010080  0.000000   0.00000 0.000000000 0.00000000
    ## 10 0.77280000 0.165120000  1.584000   0.24000 0.037920000 0.10224000
    ## 12 0.14736000 0.007368000  0.736800   0.00000 0.000000000 0.00000000
    ## 13 1.12800000 0.019200000  8.400000   0.00000 0.098400000 0.40080000
    ## 14 9.32200000 0.112180000 30.652000   0.00000 0.067940000 0.27650000
    ## 16 0.12800000 0.017000000  6.580000   0.30000 0.068600000 0.00600000
    ## 17 0.09520000 0.021840000  0.280000   4.14400 0.025760000 0.01512000
    ## 18 2.64505500 0.026365500 11.821950   0.00000 0.022963500 0.31893750
    ## 19 0.11750000 0.019000000  0.075000   3.75000 0.011000000 0.02150000
    ## 20 0.28200000 0.086362500  0.176250   6.75625 0.041712500 0.04758750
    ## 21 0.87857500 0.008757500  3.926750   0.00000 0.007627500 0.10593750
    ## 22 0.38702500 0.004520000  2.090500   0.00000 0.004096250 0.05296875
    ## 23 0.04250000 0.009750000  0.125000   1.85000 0.011500000 0.00675000
    ## 24 0.06053125 0.030731250  0.000000  37.43625 0.026540625 0.01303750
    ## 28 0.04800000 0.024000000  2.880000   0.00000 0.024000000 0.12000000
    ## 30 0.08250000 0.013750000  0.055000   1.54000 0.022550000 0.01375000
    ## 34 0.05683200 0.028416000  0.000000   0.00000 0.000000000 0.03978240
    ## 35 0.00246000 0.003854000  0.098400   0.00000 0.000000000 0.00000000
    ## 36 0.16590000 0.030020000  0.316000   1.89600 0.011850000 0.03555000
    ## 37 1.24000000 0.098000000  0.400000  11.00000 0.184000000 0.11400000
    ## 39 0.00100000 0.002900000  0.060000   0.00000 0.000400000 0.00030000
    ## 41 1.86300000 0.062100000  4.860000   1.62000 0.110700000 0.64800000
    ## 42 0.33855000 0.022875000  3.385500   0.00000 0.042090000 0.15463500
    ## 43 0.05040000 0.017280000  0.144000  21.16800 0.008640000 0.00792000
    ## 44 0.06930000 0.011340000  0.252000   0.15750 0.000000000 0.01197000
    ## 45 0.00031500 0.000220500  0.018900   0.00000 0.000000000 0.00059850
    ## 48 0.65940000 0.072660000 13.272000   0.00000 0.141120000 0.11172000
    ## 49 0.65541656 0.089143031  2.328244   0.00000 0.065701125 0.08691047
    ## 50 0.70804125 0.006857156  5.708981   0.00000 0.003348844 0.06330909
    ## 51 0.47840625 0.005103000  2.312297   0.00000 0.002392031 0.06219281
    ##          NIAC        VB6       FOLA    FA        FF       FDFE      VB12
    ## 1  5.87076000 0.66920000 199.920000 194.6  5.320000 336.280000 1.8956000
    ## 2  0.22448000 0.09272000  12.200000   0.0 12.200000  12.200000 1.2932000
    ## 3  0.31920000 0.17616000   9.600000   0.0  9.600000   9.600000 0.0000000
    ## 5  0.83596800 0.22690560  56.726400   0.0 56.726400  56.726400 0.0000000
    ## 6  0.67843200 0.00355200   7.104000   0.0  7.104000   7.104000 0.0000000
    ## 7  0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 8  0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 9  0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 10 0.12960000 0.01200000   3.840000   0.0  3.840000   3.840000 0.2544000
    ## 12 0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 13 0.19680000 0.10800000  19.200000   0.0 19.200000  21.600000 0.9360000
    ## 14 8.27604000 0.53878000  15.800000   0.0 15.800000  15.800000 3.9500000
    ## 16 0.10460000 0.01260000   1.400000   0.0  1.400000   1.400000 0.0000000
    ## 17 0.06496000 0.06720000  10.640000   0.0 10.640000  10.640000 0.0000000
    ## 18 0.06804000 0.06293700  15.309000   0.0 15.309000  15.309000 0.7059150
    ## 19 0.07625000 0.01825000  24.250000   0.0 24.250000  24.250000 0.0000000
    ## 20 0.23735000 0.03877500  75.787500   0.0 75.787500  75.787500 0.0000000
    ## 21 0.02260000 0.02090500   5.085000   0.0  5.085000   5.085000 0.2344750
    ## 22 0.01596125 0.01243000   2.260000   0.0  2.260000   2.260000 0.1469000
    ## 23 0.02900000 0.03000000   4.750000   0.0  4.750000   4.750000 0.0000000
    ## 24 0.22350000 0.10430000   4.656250   0.0  4.656250   4.656250 0.0000000
    ## 28 2.46240000 0.22080000  28.800000   0.0 28.800000  28.800000 0.0960000
    ## 30 0.06765000 0.02310000  15.950000   0.0 15.950000  15.950000 0.0000000
    ## 34 0.00000000 0.00000000  14.208000   0.0 14.208000  14.208000 0.0000000
    ## 35 0.00902000 0.00336200   0.082000   0.0  0.082000   0.082000 0.0000000
    ## 36 0.15800000 0.02291000  20.540000   0.0 20.540000  20.540000 0.0000000
    ## 37 3.34600000 0.27600000  46.000000   0.0 46.000000  46.000000 0.0000000
    ## 39 0.00070000 0.00030000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 41 0.31320000 0.12960000  13.500000   0.0 13.500000  13.500000 1.0530000
    ## 42 0.08143500 0.03294000   4.575000   0.0  4.575000   4.575000 0.4117500
    ## 43 0.13896000 0.01692000   8.640000   0.0  8.640000   8.640000 0.0000000
    ## 44 0.03811500 0.00756000   0.630000   0.0  0.630000   0.630000 0.0000000
    ## 45 0.00000000 0.00000000   0.000000   0.0  0.000000   0.000000 0.0000000
    ## 48 2.39274000 0.16548000   0.000000   0.0  0.840000   0.840000 0.1512000
    ## 49 0.88664625 0.09041878   1.435219   0.0  1.435219   1.435219 0.2950172
    ## 50 0.02312297 0.01339537   3.189375   0.0  3.189375   3.189375 0.2248509
    ## 51 0.01483059 0.01259803   2.870437   0.0  2.870437   2.870437 0.1323591
    ##         VARA        RET         BCAR       ACAR        CRYP LYCO
    ## 1  277.20000 277.200000    0.0000000   0.000000   0.0000000    0
    ## 2  134.20000 134.200000    9.7600000   0.000000   0.0000000    0
    ## 3    1.44000   0.000000   12.4800000  12.000000   0.0000000    0
    ## 5    5.97120   0.000000   23.8848000  23.884800  80.6112000    0
    ## 6    0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 7    0.30000   0.000000    2.7000000   0.000000   0.0000000    0
    ## 8    0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 9    0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 10  26.88000  26.880000    0.0000000   0.000000   0.0000000    0
    ## 12   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 13 436.80000 429.600000   76.8000000   2.400000   2.4000000    0
    ## 14   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 16   0.80000   0.000000    5.8000000   0.000000   5.2000000    0
    ## 17   0.00000   0.000000    0.5600000   0.000000   0.0000000    0
    ## 18 225.38250 219.429000   72.2925000   0.000000   0.0000000    0
    ## 19  29.75000   0.000000  356.0000000   0.000000   0.0000000    0
    ## 20 162.73750   0.000000 1949.9125000   0.000000   0.0000000    0
    ## 21  74.86250  72.885000   24.0125000   0.000000   0.0000000    0
    ## 22  32.20500  30.933750   13.7012500   0.000000   1.2712500    0
    ## 23   0.00000   0.000000    0.2500000   0.000000   0.0000000    0
    ## 24   8.38125   0.000000   96.8500000   9.778125   3.2593750    0
    ## 28   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 30  13.75000   0.000000  164.4500000   2.200000   0.0000000    0
    ## 34   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 35   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 36  30.02000  15.800000   97.1700000 119.290000  18.1700000    0
    ## 37  26.00000   0.000000  132.0000000  46.000000 320.0000000    0
    ## 39   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 41 318.60000 313.200000   51.3000000   0.000000   0.0000000    0
    ## 42  42.09000  41.175000    6.4050000   0.000000   0.0000000    0
    ## 43   0.36000   0.000000    2.5200000   0.000000   0.0000000    0
    ## 44   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 45   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 48   0.00000   0.000000    0.0000000   0.000000   0.0000000    0
    ## 49   8.93025   8.770781    0.4784062   0.000000   0.0000000    0
    ## 50  23.12297  22.644562    4.4651250   0.000000   0.1594687    0
    ## 51  31.57481  30.618000   12.4385625   0.000000   0.0000000    0
    ##             LZ       ATOC           VK      CHOLE        SFAT       S040
    ## 1    41.720000 0.18200000   0.50400000   0.000000  0.42000000 0.00000000
    ## 2     0.000000 0.07320000   0.48800000  19.520000  3.06708000 0.18788000
    ## 3    10.560000 0.04800000   0.24000000   0.000000  0.05376000 0.00000000
    ## 5    80.611200 0.59712000   0.00000000   0.000000  0.04179840 0.00000000
    ## 6     0.000000 0.03552000   0.35520000   0.000000  0.00710400 0.00000000
    ## 7     0.000000 0.24300000   0.75000000   0.000000  0.58110000 0.00000000
    ## 8     0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 9     0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 10    0.000000 0.17280000   1.92000000   6.720000  6.27840000 0.22176000
    ## 12    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 13   81.600000 1.22400000   3.12000000 220.800000 24.78960000 1.17840000
    ## 14    0.000000 0.69520000   3.16000000 129.560000  9.96506000 0.00000000
    ## 16    3.600000 0.07200000   0.36000000   0.000000  0.04960000 0.00000000
    ## 17    2.240000 0.01120000   0.22400000   0.000000  0.02352000 0.00000000
    ## 18    0.000000 0.24664500   2.38140000  89.302500 17.93874600 0.88962300
    ## 19  888.750000 0.10750000  27.15000000   0.000000  0.02150000 0.00000000
    ## 20 2469.850000 0.55225000 123.61000000   0.000000  0.03113750 0.00000000
    ## 21    0.000000 0.08192500   0.79100000  29.662500  5.95849000 0.29549500
    ## 22    3.813750 0.05650000   0.36725000  12.288750  2.26098875 0.10424250
    ## 23    1.000000 0.00500000   0.10000000   0.000000  0.01050000 0.00000000
    ## 24  158.778125 0.17228125   3.44562500   0.000000  0.02700625 0.00000000
    ## 28    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 30  152.350000 0.09900000  13.25500000   0.000000  0.00990000 0.00000000
    ## 34    0.000000 0.00000000   0.00000000   0.000000  0.00568320 0.00000000
    ## 35    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 36  346.020000 0.07900000  29.94100000   4.740000  1.28217000 0.07663000
    ## 37 1802.000000 0.18000000   0.80000000   0.000000  0.39200000 0.00000000
    ## 39    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 41    0.000000 0.81000000   0.81000000 118.800000 18.33300000 0.97200000
    ## 42    0.000000 0.06405000   0.27450000   9.150000  1.70647500 0.06862500
    ## 43    9.360000 0.10440000   0.79200000   0.000000  0.00540000 0.00000000
    ## 44    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 45    0.000000 0.00000000   0.00000000   0.000000  0.00000000 0.00000000
    ## 48    0.000000 0.12180000   0.00000000  17.220000  0.46746000 0.00000000
    ## 49    0.000000 0.04305656   0.03189375   4.146187  0.00000000 0.00000000
    ## 50    0.637875 0.07654500   0.23920312  12.119625  2.00962519 0.07000678
    ## 51    0.000000 0.04146187   0.39867188  14.192719  3.04043119 0.15659831
    ##          S060       S080       S100       S120      S140        S160
    ## 1  0.00000000 0.00000000 0.00000000 0.00000000 0.0050400  0.36876000
    ## 2  0.09760000 0.04880000 0.11956000 0.13420000 0.4270000  1.36152000
    ## 3  0.00000000 0.00000000 0.00048000 0.00096000 0.0009600  0.04896000
    ## 5  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.04179840
    ## 6  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00710400
    ## 7  0.00000000 0.00150000 0.00390000 0.01860000 0.0057000  0.26520000
    ## 8  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 9  0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 10 0.08016000 0.04560000 0.08688000 0.09552000 0.2923200  2.62320000
    ## 12 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 13 0.69600000 0.40560000 0.91200000 1.02000000 3.6624000 10.00320000
    ## 14 0.00000000 0.00000000 0.00000000 0.01896000 0.7631400  5.61216000
    ## 16 0.00000000 0.00000000 0.00000000 0.00060000 0.0008000  0.02800000
    ## 17 0.00000000 0.00000000 0.00000000 0.00000000 0.0022400  0.01904000
    ## 18 0.44991450 0.23728950 0.51030000 0.46012050 2.8321650  8.33745150
    ## 19 0.00000000 0.00000000 0.00000000 0.00075000 0.0000000  0.01800000
    ## 20 0.00000000 0.00000000 0.00000000 0.00000000 0.0011750  0.02702500
    ## 21 0.14944250 0.07881750 0.16950000 0.15283250 0.9407250  2.76934750
    ## 22 0.05325125 0.03234625 0.07189625 0.06893000 0.3599050  1.04652125
    ## 23 0.00000000 0.00000000 0.00000000 0.00000000 0.0010000  0.00850000
    ## 24 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.02328125
    ## 28 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 30 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00880000
    ## 34 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00284160
    ## 35 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 36 0.04740000 0.02844000 0.06004000 0.06162000 0.1761700  0.56959000
    ## 37 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.36800000
    ## 39 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 41 0.56700000 0.32400000 0.75600000 0.83700000 3.0510000  8.26200000
    ## 42 0.06862500 0.06862500 0.06862500 0.07045500 0.2717550  0.75853500
    ## 43 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00432000
    ## 44 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 45 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 48 0.00168000 0.00000000 0.00000000 0.00000000 0.0189000  0.30576000
    ## 49 0.00000000 0.00000000 0.00000000 0.00000000 0.0000000  0.00000000
    ## 50 0.05756822 0.03635887 0.08978091 0.10221947 0.3269109  0.91838053
    ## 51 0.03891037 0.04879744 0.08978091 0.06346856 0.5761606  1.23795591
    ##         S180       MFAT       M161       M181       M201         M221
    ## 1  0.0364000  0.6652800 0.00308000  0.6487600 0.01260000 0.0005600000
    ## 2  0.5929200  1.3664000 0.06588000  1.2395200 0.00488000 0.0000000000
    ## 3  0.0024000  0.0153600 0.00480000  0.0105600 0.00000000 0.0000000000
    ## 5  0.0000000  0.0656832 0.00895680  0.0537408 0.00000000 0.0000000000
    ## 6  0.0000000  0.0532800 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 7  0.2928000  2.2653000 0.00000000  2.2677000 0.00000000 0.0000000000
    ## 8  0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 9  0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 10 2.6904000  2.4878400 0.07056000  2.3697600 0.00000000 0.0000000000
    ## 12 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 13 4.5576000 10.7040000 0.86400000  9.8352000 0.00480000 0.0000000000
    ## 14 2.9403800 11.8452600 0.96696000 10.0835600 0.09006000 0.0000000000
    ## 16 0.0092000  0.5254000 0.00180000  0.1860000 0.06820000 0.2526000000
    ## 17 0.0022400  0.0072800 0.00000000  0.0072800 0.00000000 0.0000000000
    ## 18 3.4079535  7.9870455 0.85390200  6.7232025 0.00000000 0.0000000000
    ## 19 0.0010000  0.0122500 0.00025000  0.0115000 0.00000000 0.0000000000
    ## 20 0.0017625  0.0041125 0.00058750  0.0035250 0.00000000 0.0000000000
    ## 21 1.1319775  2.6529575 0.28363000  2.2331625 0.00000000 0.0000000000
    ## 22 0.4237500  1.0168587 0.09520250  0.8674162 0.00720375 0.0000000000
    ## 23 0.0010000  0.0032500 0.00000000  0.0032500 0.00000000 0.0000000000
    ## 24 0.0037250  0.0037250 0.00000000  0.0037250 0.00000000 0.0000000000
    ## 28 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 30 0.0011000  0.0033000 0.00055000  0.0022000 0.00000000 0.0000000000
    ## 34 0.0000000  0.0028416 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 35 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 36 0.2456900  0.5095500 0.02291000  0.4842700 0.00237000 0.0000000000
    ## 37 0.0240000  0.7440000 0.00000000  0.7440000 0.00000000 0.0000000000
    ## 39 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 41 3.5532000  8.0163000 0.55620000  7.4601000 0.00000000 0.0000000000
    ## 42 0.3339750  0.7429800 0.00000000  0.7429800 0.00000000 0.0000000000
    ## 43 0.0010800  0.0154800 0.00036000  0.0151200 0.00000000 0.0000000000
    ## 44 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 45 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 48 0.1411200  0.7077000 0.04452000  0.6531000 0.01008000 0.0000000000
    ## 49 0.0000000  0.0000000 0.00000000  0.0000000 0.00000000 0.0000000000
    ## 50 0.3442930  0.8458222 0.05214628  0.7477490 0.00637875 0.0003189375
    ## 51 0.5458615  1.3955110 0.14718966  1.1749657 0.00000000 0.0000000000
    ##          PFAT       P182       P183      P184        P204         P205
    ## 1  0.68096000 0.65968000 0.01904000 0.0000000 0.000000000 0.0000000000
    ## 2  0.17812000 0.15128000 0.01952000 0.0000000 0.000000000 0.0000000000
    ## 3  0.03504000 0.02208000 0.01296000 0.0000000 0.000000000 0.0000000000
    ## 5  0.08956800 0.06866880 0.02089920 0.0000000 0.000000000 0.0000000000
    ## 6  0.00355200 0.00355200 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 7  0.00810000 0.00660000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 8  0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 9  0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 10 0.44208000 0.41472000 0.02736000 0.0000000 0.000000000 0.0000000000
    ## 12 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 13 1.63200000 1.04880000 0.53280000 0.0024000 0.033600000 0.0024000000
    ## 14 0.71890000 0.56248000 0.06952000 0.0000000 0.063200000 0.0047400000
    ## 16 0.19080000 0.08860000 0.09160000 0.0000000 0.000000000 0.0000000000
    ## 17 0.00952000 0.00728000 0.00224000 0.0000000 0.000000000 0.0000000000
    ## 18 0.80117100 0.49073850 0.31043250 0.0000000 0.000000000 0.0000000000
    ## 19 0.07975000 0.03250000 0.04250000 0.0000000 0.000500000 0.0000000000
    ## 20 0.07402500 0.04582500 0.02820000 0.0000000 0.000000000 0.0000000000
    ## 21 0.26611500 0.16300250 0.10311250 0.0000000 0.000000000 0.0000000000
    ## 22 0.11624875 0.07924125 0.03262875 0.0002825 0.001130000 0.0004237500
    ## 23 0.00425000 0.00325000 0.00100000 0.0000000 0.000000000 0.0000000000
    ## 24 0.02886875 0.02514375 0.00372500 0.0000000 0.000000000 0.0000000000
    ## 28 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 30 0.04070000 0.01155000 0.02860000 0.0000000 0.000000000 0.0000000000
    ## 34 0.01136640 0.00284160 0.00852480 0.0000000 0.000000000 0.0000000000
    ## 35 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 36 0.22199000 0.12087000 0.09875000 0.0000000 0.000000000 0.0000000000
    ## 37 1.19800000 1.16600000 0.03600000 0.0000000 0.000000000 0.0000000000
    ## 39 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 41 1.22040000 0.74250000 0.47250000 0.0000000 0.000000000 0.0081000000
    ## 42 0.17842500 0.10980000 0.06862500 0.0000000 0.000000000 0.0000000000
    ## 43 0.05580000 0.03240000 0.02340000 0.0000000 0.000000000 0.0000000000
    ## 44 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 45 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 48 0.14700000 0.13440000 0.00672000 0.0000000 0.005460000 0.0000000000
    ## 49 0.00000000 0.00000000 0.00000000 0.0000000 0.000000000 0.0000000000
    ## 50 0.14240559 0.11848528 0.01020600 0.0000000 0.005581406 0.0009568125
    ## 51 0.14336241 0.10158159 0.04162134 0.0000000 0.000000000 0.0000000000
    ##           P225       P226       VITD      CHOLN VITE_ADD B12_ADD F_TOTAL
    ## 1  0.000000000 0.00000000 0.95200000   7.336000        0  1.8956 0.00000
    ## 2  0.000000000 0.00000000 2.92800000  40.016000        0  0.0000 0.00000
    ## 3  0.000000000 0.00000000 0.00000000   4.704000        0  0.0000 0.32160
    ## 5  0.000000000 0.00000000 0.00000000  18.510720        0  0.0000 1.19424
    ## 6  0.000000000 0.00000000 0.00000000   9.235200        0  0.0000 0.00000
    ## 7  0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 8  0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 9  0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 10 0.000000000 0.00000000 0.00000000  10.416000        0  0.0000 0.00000
    ## 12 0.000000000 0.00000000 0.00000000   2.210400        0  0.0000 0.00000
    ## 13 0.000000000 0.00960000 0.72000000  62.400000        0  0.0000 0.00000
    ## 14 0.025280000 0.00158000 0.31600000 119.922000        0  0.0000 0.00000
    ## 16 0.000000000 0.00000000 0.00000000   4.480000        0  0.0000 0.00000
    ## 17 0.000000000 0.00000000 0.00000000   3.416000        0  0.0000 0.00000
    ## 18 0.000000000 0.00000000 0.51030000  14.033250        0  0.0000 0.00000
    ## 19 0.000000000 0.00000000 0.00000000   3.825000        0  0.0000 0.00000
    ## 20 0.000000000 0.00000000 0.00000000   7.755000        0  0.0000 0.00000
    ## 21 0.000000000 0.00000000 0.16950000   4.661250        0  0.0000 0.00000
    ## 22 0.000565000 0.00014125 0.33900000   3.107500        0  0.0000 0.00000
    ## 23 0.000000000 0.00000000 0.00000000   1.525000        0  0.0000 0.00000
    ## 24 0.000000000 0.00000000 0.00000000   2.560938        0  0.0000 0.00000
    ## 28 0.000000000 0.00000000 0.00000000  48.480000        0  0.0000 0.00000
    ## 30 0.000000000 0.00000000 0.00000000   3.685000        0  0.0000 0.00000
    ## 34 0.000000000 0.00000000 0.00000000   1.136640        0  0.0000 0.00000
    ## 35 0.000000000 0.00000000 0.00000000   0.188600        0  0.0000 0.00000
    ## 36 0.000000000 0.00000000 0.00000000  11.692000        0  0.0000 0.00000
    ## 37 0.000000000 0.00000000 0.00000000  57.800000        0  0.0000 0.00000
    ## 39 0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 41 0.000000000 0.00000000 0.54000000  70.200000        0  0.0000 0.00000
    ## 42 0.000000000 0.00000000 1.18950000  13.084500        0  0.0000 0.00000
    ## 43 0.000000000 0.00000000 0.00000000   2.052000        0  0.0000 0.24840
    ## 44 0.000000000 0.00000000 0.00000000   0.693000        0  0.0000 0.00000
    ## 45 0.000000000 0.00000000 0.00000000   0.000000        0  0.0000 0.00000
    ## 48 0.000000000 0.00000000 0.29400000  26.208000        0  0.0000 0.00000
    ## 49 0.000000000 0.00000000 0.01594687   6.123600        0  0.0000 0.00000
    ## 50 0.001594687 0.00000000 0.04784062   2.455819        0  0.0000 0.00000
    ## 51 0.000000000 0.00000000 0.09568125   2.455819        0  0.0000 0.00000
    ##    F_CITMLB F_OTHER F_JUICE   V_TOTAL V_DRKGR V_REDOR_TOTAL V_REDOR_TOMATO
    ## 1    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 2    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 3    0.0000  0.3216 0.00000 0.0000000  0.0000             0              0
    ## 5    0.0000  0.0000 1.19424 0.0000000  0.0000             0              0
    ## 6    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 7    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 8    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 9    0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 10   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 12   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 13   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 14   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 16   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 17   0.0000  0.0000 0.00000 0.3528000  0.0000             0              0
    ## 18   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 19   0.0000  0.0000 0.00000 0.6250000  0.6250             0              0
    ## 20   0.0000  0.0000 0.00000 0.5875000  0.5875             0              0
    ## 21   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 22   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 23   0.0000  0.0000 0.00000 0.1575000  0.0000             0              0
    ## 24   0.0000  0.0000 0.00000 0.3864687  0.0000             0              0
    ## 28   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 30   0.0000  0.0000 0.00000 0.5005000  0.0000             0              0
    ## 34   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 35   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 36   0.0000  0.0000 0.00000 0.5846000  0.0000             0              0
    ## 37   0.0000  0.0000 0.00000 1.2200000  0.0000             0              0
    ## 39   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 41   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 42   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 43   0.2484  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 44   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 45   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 48   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 49   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 50   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ## 51   0.0000  0.0000 0.00000 0.0000000  0.0000             0              0
    ##    V_REDOR_OTHER V_STARCHY_TOTAL V_STARCHY_POTATO V_STARCHY_OTHER
    ## 1              0            0.00                0            0.00
    ## 2              0            0.00                0            0.00
    ## 3              0            0.00                0            0.00
    ## 5              0            0.00                0            0.00
    ## 6              0            0.00                0            0.00
    ## 7              0            0.00                0            0.00
    ## 8              0            0.00                0            0.00
    ## 9              0            0.00                0            0.00
    ## 10             0            0.00                0            0.00
    ## 12             0            0.00                0            0.00
    ## 13             0            0.00                0            0.00
    ## 14             0            0.00                0            0.00
    ## 16             0            0.00                0            0.00
    ## 17             0            0.00                0            0.00
    ## 18             0            0.00                0            0.00
    ## 19             0            0.00                0            0.00
    ## 20             0            0.00                0            0.00
    ## 21             0            0.00                0            0.00
    ## 22             0            0.00                0            0.00
    ## 23             0            0.00                0            0.00
    ## 24             0            0.00                0            0.00
    ## 28             0            0.00                0            0.00
    ## 30             0            0.00                0            0.00
    ## 34             0            0.00                0            0.00
    ## 35             0            0.00                0            0.00
    ## 36             0            0.00                0            0.00
    ## 37             0            1.22                0            1.22
    ## 39             0            0.00                0            0.00
    ## 41             0            0.00                0            0.00
    ## 42             0            0.00                0            0.00
    ## 43             0            0.00                0            0.00
    ## 44             0            0.00                0            0.00
    ## 45             0            0.00                0            0.00
    ## 48             0            0.00                0            0.00
    ## 49             0            0.00                0            0.00
    ## 50             0            0.00                0            0.00
    ## 51             0            0.00                0            0.00
    ##      V_OTHER V_LEGUMES G_TOTAL G_WHOLE G_REFINED PF_TOTAL PF_MPS_TOTAL
    ## 1  0.0000000         0  0.9184  0.9184         0   0.0000       0.0000
    ## 2  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 3  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 5  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 6  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 7  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 8  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 9  0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 10 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 12 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 13 0.0000000         0  0.0000  0.0000         0   0.1440       0.0000
    ## 14 0.0000000         0  0.0000  0.0000         0   5.0876       5.0876
    ## 16 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 17 0.3528000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 18 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 19 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 20 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 21 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 22 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 23 0.1575000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 24 0.3864687         0  0.0000  0.0000         0   0.0000       0.0000
    ## 28 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 30 0.5005000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 34 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 35 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 36 0.5846000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 37 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 39 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 41 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 42 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 43 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 44 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 45 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 48 0.0000000         0  0.0000  0.0000         0   1.4826       1.4826
    ## 49 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 50 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ## 51 0.0000000         0  0.0000  0.0000         0   0.0000       0.0000
    ##    PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT PF_SEAFD_HI PF_SEAFD_LOW PF_EGGS
    ## 1   0.0000       0.0000        0        0           0            0   0.000
    ## 2   0.0000       0.0000        0        0           0            0   0.000
    ## 3   0.0000       0.0000        0        0           0            0   0.000
    ## 5   0.0000       0.0000        0        0           0            0   0.000
    ## 6   0.0000       0.0000        0        0           0            0   0.000
    ## 7   0.0000       0.0000        0        0           0            0   0.000
    ## 8   0.0000       0.0000        0        0           0            0   0.000
    ## 9   0.0000       0.0000        0        0           0            0   0.000
    ## 10  0.0000       0.0000        0        0           0            0   0.000
    ## 12  0.0000       0.0000        0        0           0            0   0.000
    ## 13  0.0000       0.0000        0        0           0            0   0.144
    ## 14  5.0876       0.0000        0        0           0            0   0.000
    ## 16  0.0000       0.0000        0        0           0            0   0.000
    ## 17  0.0000       0.0000        0        0           0            0   0.000
    ## 18  0.0000       0.0000        0        0           0            0   0.000
    ## 19  0.0000       0.0000        0        0           0            0   0.000
    ## 20  0.0000       0.0000        0        0           0            0   0.000
    ## 21  0.0000       0.0000        0        0           0            0   0.000
    ## 22  0.0000       0.0000        0        0           0            0   0.000
    ## 23  0.0000       0.0000        0        0           0            0   0.000
    ## 24  0.0000       0.0000        0        0           0            0   0.000
    ## 28  0.0000       0.0000        0        0           0            0   0.000
    ## 30  0.0000       0.0000        0        0           0            0   0.000
    ## 34  0.0000       0.0000        0        0           0            0   0.000
    ## 35  0.0000       0.0000        0        0           0            0   0.000
    ## 36  0.0000       0.0000        0        0           0            0   0.000
    ## 37  0.0000       0.0000        0        0           0            0   0.000
    ## 39  0.0000       0.0000        0        0           0            0   0.000
    ## 41  0.0000       0.0000        0        0           0            0   0.000
    ## 42  0.0000       0.0000        0        0           0            0   0.000
    ## 43  0.0000       0.0000        0        0           0            0   0.000
    ## 44  0.0000       0.0000        0        0           0            0   0.000
    ## 45  0.0000       0.0000        0        0           0            0   0.000
    ## 48  0.0000       1.4826        0        0           0            0   0.000
    ## 49  0.0000       0.0000        0        0           0            0   0.000
    ## 50  0.0000       0.0000        0        0           0            0   0.000
    ## 51  0.0000       0.0000        0        0           0            0   0.000
    ##    PF_SOY PF_NUTSDS PF_LEGUMES   D_TOTAL  D_MILK D_YOGURT  D_CHEESE OILS
    ## 1       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 2       0         0          0 1.0004000 1.00040        0 0.0000000    0
    ## 3       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 5       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 6       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 7       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 8       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 9       0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 10      0         0          0 0.1536000 0.15360        0 0.0000000    0
    ## 12      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 13      0         0          0 0.3360000 0.33600        0 0.0000000    0
    ## 14      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 16      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 17      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 18      0         0          0 1.9986750 0.00000        0 1.9986750    0
    ## 19      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 20      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 21      0         0          0 0.6638750 0.00000        0 0.6638750    0
    ## 22      0         0          0 0.3813750 0.00000        0 0.3813750    0
    ## 23      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 24      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 28      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 30      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 34      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 35      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 36      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 37      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 39      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 41      0         0          0 0.6210000 0.62100        0 0.0000000    0
    ## 42      0         0          0 0.3751500 0.37515        0 0.0000000    0
    ## 43      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 44      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 45      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 48      0         0          0 0.0000000 0.00000        0 0.0000000    0
    ## 49      0         0          0 0.3747516 0.00000        0 0.3747516    0
    ## 50      0         0          0 0.3747516 0.00000        0 0.3747516    0
    ## 51      0         0          0 0.3747516 0.00000        0 0.3747516    0
    ##    SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 1    0.000000    0.19880    0.000        1
    ## 2    3.342800    0.00000    0.000        1
    ## 3    0.000000    0.00000    0.000        1
    ## 5    0.000000    0.00000    0.000        1
    ## 6    0.000000    0.00000    0.000        1
    ## 7    2.991000    0.81300    0.000        1
    ## 8    0.000000    1.99584    0.000        1
    ## 9    0.000000    0.00000    0.000        1
    ## 10   8.203200    6.53760    0.000        1
    ## 12   0.000000   15.76752    0.000        1
    ## 13  37.776000    9.81600    0.000        1
    ## 14  12.371400    0.00000    0.000        1
    ## 16   0.000000    0.00000    0.000        1
    ## 17   0.000000    0.00000    0.000        1
    ## 18  25.183305    0.00000    0.000        1
    ## 19   0.000000    0.00000    0.000        1
    ## 20   0.000000    0.00000    0.000        1
    ## 21   8.364825    0.00000    0.000        1
    ## 22   3.055238    0.00000    0.000        1
    ## 23   0.000000    0.00000    0.000        1
    ## 24   0.000000    0.00000    0.000        1
    ## 28   0.000000    0.00000    1.344        1
    ## 30   0.000000    0.00000    0.000        1
    ## 34   0.000000    0.00000    0.000        1
    ## 35   0.000000    1.89420    0.000        1
    ## 36   1.911800    0.00000    0.000        1
    ## 37   0.000000    0.00000    0.000        1
    ## 39   0.000000    1.49800    0.000        1
    ## 41  28.755000   11.25900    0.000        1
    ## 42   2.415600    0.00000    0.000        1
    ## 43   0.000000    0.00000    0.000        1
    ## 44   0.000000    6.15825    0.000        1
    ## 45   0.000000    0.74844    0.000        1
    ## 48   0.000000    0.00000    0.000        1
    ## 49   0.000000    0.00000    0.000        1
    ## 50   2.691832    0.00000    0.000        1
    ## 51   4.265789    0.00000    0.000        1
    ##                                                                  Food_Description
    ## 1                                                                        Cheerios
    ## 2                                                      Milk, cow's, fluid, 2% fat
    ## 3                                                                     Banana, raw
    ## 5                                    Orange juice, canned, bottled or in a carton
    ## 6                                               Coffee, made from ground, regular
    ## 7                                                        Cream substitute, liquid
    ## 8                                                Sugar, white, granulated or lump
    ## 9                                                     Water, bottled, unsweetened
    ## 10          M&M's Milk Chocolate Candies (formerly M&M's Plain Chocolate Candies)
    ## 12                                                          Soft drink, cola-type
    ## 13                                  Ice cream, rich, flavors other than chocolate
    ## 14                     Ground beef, less than 80% lean, cooked (formerly regular)
    ## 16                                                                        Mustard
    ## 17                                                            Onions, mature, raw
    ## 18                                                                Cheese, Cheddar
    ## 19                                                          Lettuce, arugula, raw
    ## 20                             Endive, chicory, escarole, or romaine lettuce, raw
    ## 21                                                                Cheese, Cheddar
    ## 22                                                                    Cheese, NFS
    ## 23                                                            Onions, mature, raw
    ## 24                                                      Pepper, sweet, green, raw
    ## 28                                                                           Beer
    ## 30                                                                   Lettuce, raw
    ## 34                                                         Tea, leaf, unsweetened
    ## 35                                                                     Sugar, raw
    ## 36 Beans, string, green, cooked, from canned, fat added in cooking W/ BUTTER, NFS
    ## 37                     Corn, yellow, cooked, from fresh, fat not added in cooking
    ## 39                                                                     Hard candy
    ## 41                               Ice cream, regular, flavors other than chocolate
    ## 42                                                      Milk, cow's, fluid, whole
    ## 43                                                              Strawberries, raw
    ## 44                                                                          Honey
    ## 45                                                                     Sugar, NFS
    ## 48                                Ham, sliced, prepackaged or deli, luncheon meat
    ## 49                                           Cheese, American, nonfat or fat free
    ## 50                                                   Cheese, Cheddar, reduced fat
    ## 51                                                               Cheese, Monterey

You can also use conditional subsetting on characters (i.e. not numbers)

    items$FoodSrce != "Other cafeteria" #notice the ""

    ##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE  TRUE
    ## [12]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [23]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [34]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [45]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

***DIY: Return all rows where the PROT value is greather than or equal
to 5. How many rows are there?***

    items[items$PROT >= 5,]

    ##                             RecallRecId UserName
    ## 2  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 4  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 11 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 13 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 14 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 15 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 18 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 21 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 29 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 31 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 32 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 33 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 37 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 41 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 2  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 4  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 11 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 13 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 14 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 15 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 18 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 21 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 29 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 31 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 32 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 33 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 37 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 41 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 2             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 4             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 11            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 13            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 14            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 15            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 18            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 21            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 29            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 31            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 32            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 33            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 37            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 41            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No         Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 2       1 05/20/2018 11:00        1       4                  1        1
    ## 4       1 05/20/2018 11:00        1       4                  1        1
    ## 11      3 05/20/2018 17:00        3       2                  3        3
    ## 13      3 05/20/2018 17:00        3       2                  3        3
    ## 14      3 05/20/2018 17:00        3       2                  3        3
    ## 15      3 05/20/2018 17:00        3       2                  3        3
    ## 18      3 05/20/2018 17:00        3       2                  3        3
    ## 21      3 05/20/2018 17:00        3       2                  3        3
    ## 29      4 05/20/2018 19:30        6       1                  2        7
    ## 31      5 05/20/2018 22:00        5       1                  6        1
    ## 32      5 05/20/2018 22:00        5       1                  6        1
    ## 33      5 05/20/2018 22:00        5       1                  6        1
    ## 37      5 05/20/2018 22:00        5       1                  6        1
    ## 41      7  05/21/2018 2:00        7       1                  4        1
    ## 48      8  05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType                           FoodSrce CodeNum FoodCode
    ## 2        2        2             Other store (any type)       2 11112110
    ## 4        4        1             Other store (any type)       4 32131000
    ## 11      11        1                                         11 58106725
    ## 13      13        1                                         13 13110120
    ## 14      14        1                                         14 21501000
    ## 15      14        1                                         15 51320500
    ## 18      14        1                                         18 14104100
    ## 21      15        1                                         21 14104100
    ## 29      17        1                              Other      29 71201015
    ## 31      19        1    Other restaurant, bar or tavern      31 27345310
    ## 32      20        1    Other restaurant, bar or tavern      32 27116100
    ## 33      20        1    Other restaurant, bar or tavern      33 56205002
    ## 37      24        1    Other restaurant, bar or tavern      37 75216111
    ## 41      28        1 Fast food or drive-thru restaurant      41 13110100
    ## 48      29        1             Other store (any type)      48 25230210
    ##    ModCode HowMany SubCode PortionCode FoodAmt      KCAL     PROT     TFAT
    ## 2        0    1.00       0       10205  244.00  122.0000  8.05200  4.83120
    ## 4        0    6.00       0       61009  678.00 1240.7400 79.32600 93.83520
    ## 11       0    2.00       0       64369  204.00  497.7600 22.48080 22.23600
    ## 13       0    2.00       0       61396  240.00  597.6000  8.40000 38.88000
    ## 14       0    2.00       0       64195  158.00  388.6800 36.75080 25.75400
    ## 15       0    2.00       0       60847  104.00  283.9200  8.94400  6.55200
    ## 18       0   85.05       0          98   85.05  342.7515 21.17745 28.18557
    ## 21       0    0.25       0       10010   28.25  113.8475  7.03425  9.36205
    ## 29       0    4.00       0       10247  100.00  542.0000  6.56000 36.40000
    ## 31       0    1.50       0       10205  325.50  416.6400 32.90805 20.14845
    ## 32       0    1.00       0       10205  236.00  247.8000 14.91520 14.06560
    ## 33       0    1.50       0       10043  244.50  366.7500  6.35700  7.45725
    ## 37       0    2.00       0       61345  200.00  190.0000  6.78000  2.98000
    ## 41       0    2.25       0       61396  270.00  558.9000  9.45000 29.70000
    ## 48       0    1.50       0       62008   42.00   55.0200  7.11060  1.47000
    ##        CARB      MOIS ALC CAFF THEO     SUGR  FIBE     CALC    IRON
    ## 2  11.71200 217.67240   0    0    0 12.34640 0.000 292.8000 0.04880
    ## 4  17.62800 473.78640   0    0    0 11.39040 2.034 691.5600 7.39020
    ## 11 51.77520 102.81600   0    0    0  7.60920 4.488 244.8000 3.79440
    ## 13 53.49600 137.28000   0    0    0 49.56000 0.000 280.8000 0.81600
    ## 14  0.00000  91.95600   0    0    0  0.00000 0.000  50.5600 3.91840
    ## 15 47.84000  38.48000   0    0    0  1.69520 3.952 183.0400 3.69200
    ## 18  1.08864  31.25587   0    0    0  0.44226 0.000 613.2105 0.57834
    ## 21  0.36160  10.38188   0    0    0  0.14690 0.000 203.6825 0.19210
    ## 29 50.81000   2.28000   0    0    0  0.37000 4.400  24.0000 1.61000
    ## 31 26.20275 242.39985   0    0    0  4.75230 3.906  71.6100 1.95300
    ## 32 16.26040 188.89440   0    0    0  3.46920 4.012  77.8800 2.59600
    ## 33 66.55290 161.66340   0    0    0  0.12225 0.978  24.4500 2.83620
    ## 37 41.72000 145.96000   0    0    0  9.02000 4.800   6.0000 0.90000
    ## 41 63.72000 164.70000   0    0    0 57.29400 1.890 345.6000 0.24300
    ## 48  0.40740  31.51260   0    0    0  0.00000 0.000   2.1000 0.24360
    ##       MAGN     PHOS     POTA      SODI     ZINC      COPP      SELE     VC
    ## 2   26.840  224.480  341.600  114.6800 1.171200 0.0146400   6.10000  0.488
    ## 4  101.700 1213.620 1450.920 2922.1800 9.017400 0.4407000 130.17600 23.730
    ## 11  46.920  373.320  375.360 1201.5600 2.529600 0.2815200  47.12400  0.204
    ## 13  26.400  252.000  376.800  146.4000 1.128000 0.0192000   8.40000  0.000
    ## 14  31.600  311.260  504.020  646.2200 9.322000 0.1121800  30.65200  0.000
    ## 15  37.440  108.160  119.600  544.9600 0.936000 0.1560000  34.32000  0.000
    ## 18  23.814  435.456   83.349  528.1605 2.645055 0.0263655  11.82195  0.000
    ## 21   7.910  144.640   27.685  175.4325 0.878575 0.0087575   3.92675  0.000
    ## 29  70.000  155.000 1642.000  450.0000 2.390000 0.3980000   8.10000 18.600
    ## 31  58.590  318.990  732.375  764.9250 1.953000 0.1725150  36.78150 35.154
    ## 32  49.560  148.680  531.000  202.9600 3.280400 0.2124000  12.50800 23.128
    ## 33  29.340  102.690   83.130  581.9100 1.149150 0.1638150  17.60400  0.000
    ## 37  52.000  154.000  434.000  454.0000 1.240000 0.0980000   0.40000 11.000
    ## 41  37.800  283.500  537.300  216.0000 1.863000 0.0621000   4.86000  1.620
    ## 48   7.560  109.620  194.040  551.8800 0.659400 0.0726600  13.27200  0.000
    ##          VB1       VB2     NIAC      VB6    FOLA      FA      FF    FDFE
    ## 2  0.0951600 0.4514000  0.22448 0.092720  12.200   0.000  12.200  12.200
    ## 4  0.7458000 1.9390800  8.21058 1.044120 142.380   0.000 142.380 142.380
    ## 11 0.5222400 0.5426400  6.32400 0.199920 126.480  73.440  53.040 177.480
    ## 13 0.0984000 0.4008000  0.19680 0.108000  19.200   0.000  19.200  21.600
    ## 14 0.0679400 0.2765000  8.27604 0.538780  15.800   0.000  15.800  15.800
    ## 15 0.4503200 0.2839200  4.23488 0.079040  62.400  46.800  15.600  95.680
    ## 18 0.0229635 0.3189375  0.06804 0.062937  15.309   0.000  15.309  15.309
    ## 21 0.0076275 0.1059375  0.02260 0.020905   5.085   0.000   5.085   5.085
    ## 29 0.0630000 0.2300000  4.18200 0.723000  75.000   0.000  75.000  75.000
    ## 31 0.2441250 0.3417750 10.28906 1.048110  94.395  26.040  71.610 113.925
    ## 32 0.1416000 0.1793600  2.75176 0.420080  66.080   0.000  66.080  66.080
    ## 33 0.3838650 0.0317850  3.48657 0.220050 136.920 129.585   7.335 229.830
    ## 37 0.1840000 0.1140000  3.34600 0.276000  46.000   0.000  46.000  46.000
    ## 41 0.1107000 0.6480000  0.31320 0.129600  13.500   0.000  13.500  13.500
    ## 48 0.1411200 0.1117200  2.39274 0.165480   0.000   0.000   0.840   0.840
    ##        VB12     VARA     RET      BCAR     ACAR   CRYP    LYCO      LZ
    ## 2  1.293200 134.2000 134.200    9.7600    0.000   0.00    0.00    0.00
    ## 4  4.203600 759.3600 684.780  779.7000  162.720  27.12 4183.26 1715.34
    ## 11 1.387200 124.4400 110.160  165.2400    0.000   0.00 3445.56   53.04
    ## 13 0.936000 436.8000 429.600   76.8000    2.400   2.40    0.00   81.60
    ## 14 3.950000   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ## 15 0.000000   0.0000   0.000    0.0000    0.000   0.00    0.00   67.60
    ## 18 0.705915 225.3825 219.429   72.2925    0.000   0.00    0.00    0.00
    ## 21 0.234475  74.8625  72.885   24.0125    0.000   0.00    0.00    0.00
    ## 29 0.000000   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ## 31 0.260400 439.4250   6.510 4361.7000 1656.795   0.00    0.00  911.40
    ## 32 0.873200 311.5200   0.000 3282.7600  901.520   0.00  250.16 2461.48
    ## 33 0.000000   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ## 37 0.000000  26.0000   0.000  132.0000   46.000 320.00    0.00 1802.00
    ## 41 1.053000 318.6000 313.200   51.3000    0.000   0.00    0.00    0.00
    ## 48 0.151200   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ##        ATOC       VK     CHOLE      SFAT     S040      S060      S080
    ## 2  0.073200   0.4880   19.5200  3.067080 0.187880 0.0976000 0.0488000
    ## 4  7.458000  40.0020 1274.6400 32.645700 0.616980 0.3186600 0.1898400
    ## 11 1.754400  12.6480   55.0800  8.990280 0.299880 0.0571200 0.0795600
    ## 13 1.224000   3.1200  220.8000 24.789600 1.178400 0.6960000 0.4056000
    ## 14 0.695200   3.1600  129.5600  9.965060 0.000000 0.0000000 0.0000000
    ## 15 0.374400   2.8080    0.0000  1.556880 0.000000 0.0000000 0.0031200
    ## 18 0.246645   2.3814   89.3025 17.938746 0.889623 0.4499145 0.2372895
    ## 21 0.081925   0.7910   29.6625  5.958490 0.295495 0.1494425 0.0788175
    ## 29 6.740000  22.1000    0.0000  4.014000 0.000000 0.0000000 0.0000000
    ## 31 3.580500 107.7405  100.9050  3.043425 0.000000 0.0000000 0.0000000
    ## 32 2.006000 117.0560   44.8400  3.844440 0.002360 0.0023600 0.0023600
    ## 33 0.929100   7.5795    0.0000  1.070910 0.000000 0.0000000 0.0000000
    ## 37 0.180000   0.8000    0.0000  0.392000 0.000000 0.0000000 0.0000000
    ## 41 0.810000   0.8100  118.8000 18.333000 0.972000 0.5670000 0.3240000
    ## 48 0.121800   0.0000   17.2200  0.467460 0.000000 0.0016800 0.0000000
    ##       S100      S120     S140      S160     S180      MFAT     M161
    ## 2  0.11956 0.1342000 0.427000  1.361520 0.592920  1.366400 0.065880
    ## 4  0.40002 0.3525600 2.339100 19.485720 8.007180 35.798400 1.823820
    ## 11 0.18972 0.2182800 0.911880  4.753200 2.244000  7.725480 0.397800
    ## 13 0.91200 1.0200000 3.662400 10.003200 4.557600 10.704000 0.864000
    ## 14 0.00000 0.0189600 0.763140  5.612160 2.940380 11.845260 0.966960
    ## 15 0.00000 0.0000000 0.028080  0.858000 0.658320  3.233360 0.005200
    ## 18 0.51030 0.4601205 2.832165  8.337452 3.407954  7.987045 0.853902
    ## 21 0.16950 0.1528325 0.940725  2.769347 1.131978  2.652957 0.283630
    ## 29 0.00100 0.0080000 0.006000  2.830000 1.084000 15.999000 0.043000
    ## 31 0.01953 0.0065100 0.019530  2.125515 0.706335  7.672035 0.192045
    ## 32 0.02360 0.0236000 0.252520  2.409560 1.062000  5.786720 0.323320
    ## 33 0.00000 0.0000000 0.004890  0.772620 0.224940  2.953560 0.017115
    ## 37 0.00000 0.0000000 0.000000  0.368000 0.024000  0.744000 0.000000
    ## 41 0.75600 0.8370000 3.051000  8.262000 3.553200  8.016300 0.556200
    ## 48 0.00000 0.0000000 0.018900  0.305760 0.141120  0.707700 0.044520
    ##         M181     M201    M221      PFAT       P182      P183    P184
    ## 2   1.239520 0.004880 0.00000  0.178120  0.1512800 0.0195200 0.00000
    ## 4  33.188100 0.413580 0.00678 19.621320 16.5906600 1.7492400 0.00000
    ## 11  7.133880 0.085680 0.00204  3.855600  3.1028400 0.3202800 0.05916
    ## 13  9.835200 0.004800 0.00000  1.632000  1.0488000 0.5328000 0.00240
    ## 14 10.083560 0.090060 0.00000  0.718900  0.5624800 0.0695200 0.00000
    ## 15  3.228160 0.000000 0.00000  1.151280  1.0909600 0.0603200 0.00000
    ## 18  6.723202 0.000000 0.00000  0.801171  0.4907385 0.3104325 0.00000
    ## 21  2.233163 0.000000 0.00000  0.266115  0.1630025 0.1031125 0.00000
    ## 29 15.912000 0.044000 0.00000 15.998000 15.8270000 0.1720000 0.00000
    ## 31  7.174020 0.100905 0.00000  7.691565  6.4904700 0.9699900 0.00000
    ## 32  5.413840 0.044840 0.00000  3.131720  2.6125200 0.5026800 0.00000
    ## 33  2.897325 0.036675 0.00000  3.117375  2.6968350 0.4180950 0.00000
    ## 37  0.744000 0.000000 0.00000  1.198000  1.1660000 0.0360000 0.00000
    ## 41  7.460100 0.000000 0.00000  1.220400  0.7425000 0.4725000 0.00000
    ## 48  0.653100 0.010080 0.00000  0.147000  0.1344000 0.0067200 0.00000
    ##        P204     P205     P225    P226   VITD     CHOLN VITE_ADD B12_ADD
    ## 2  0.000000 0.000000 0.000000 0.00000 2.9280  40.01600        0       0
    ## 4  0.657660 0.000000 0.040680 0.17628 8.8140 871.23000        0       0
    ## 11 0.044880 0.000000 0.000000 0.00000 0.0000  44.26800        0       0
    ## 13 0.033600 0.002400 0.000000 0.00960 0.7200  62.40000        0       0
    ## 14 0.063200 0.004740 0.025280 0.00158 0.3160 119.92200        0       0
    ## 15 0.000000 0.000000 0.000000 0.00000 0.0000  19.44800        0       0
    ## 18 0.000000 0.000000 0.000000 0.00000 0.5103  14.03325        0       0
    ## 21 0.000000 0.000000 0.000000 0.00000 0.1695   4.66125        0       0
    ## 29 0.000000 0.000000 0.000000 0.00000 0.0000  12.10000        0       0
    ## 31 0.074865 0.003255 0.009765 0.00651 0.0000  78.12000        0       0
    ## 32 0.009440 0.000000 0.007080 0.00000 0.0000  70.80000        0       0
    ## 33 0.000000 0.000000 0.000000 0.00000 0.0000   4.89000        0       0
    ## 37 0.000000 0.000000 0.000000 0.00000 0.0000  57.80000        0       0
    ## 41 0.000000 0.008100 0.000000 0.00000 0.5400  70.20000        0       0
    ## 48 0.005460 0.000000 0.000000 0.00000 0.2940  26.20800        0       0
    ##    F_TOTAL F_CITMLB F_OTHER F_JUICE V_TOTAL V_DRKGR V_REDOR_TOTAL
    ## 2        0        0       0       0 0.00000 0.00000       0.00000
    ## 4        0        0       0       0 1.08480 0.00000       1.08480
    ## 11       0        0       0       0 0.38760 0.00000       0.16320
    ## 13       0        0       0       0 0.00000 0.00000       0.00000
    ## 14       0        0       0       0 0.00000 0.00000       0.00000
    ## 15       0        0       0       0 0.00000 0.00000       0.00000
    ## 18       0        0       0       0 0.00000 0.00000       0.00000
    ## 21       0        0       0       0 0.00000 0.00000       0.00000
    ## 29       0        0       0       0 1.75000 0.00000       0.00000
    ## 31       0        0       0       0 1.00905 0.29295       0.29295
    ## 32       0        0       0       0 0.89680 0.14160       0.21240
    ## 33       0        0       0       0 0.00000 0.00000       0.00000
    ## 37       0        0       0       0 1.22000 0.00000       0.00000
    ## 41       0        0       0       0 0.00000 0.00000       0.00000
    ## 48       0        0       0       0 0.00000 0.00000       0.00000
    ##    V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL V_STARCHY_POTATO
    ## 2          0.0000       0.00000           0.000            0.000
    ## 4          1.0848       0.00000           0.000            0.000
    ## 11         0.1632       0.00000           0.000            0.000
    ## 13         0.0000       0.00000           0.000            0.000
    ## 14         0.0000       0.00000           0.000            0.000
    ## 15         0.0000       0.00000           0.000            0.000
    ## 18         0.0000       0.00000           0.000            0.000
    ## 21         0.0000       0.00000           0.000            0.000
    ## 29         0.0000       0.00000           1.750            1.750
    ## 31         0.0000       0.29295           0.000            0.000
    ## 32         0.0472       0.16520           0.236            0.236
    ## 33         0.0000       0.00000           0.000            0.000
    ## 37         0.0000       0.00000           1.220            0.000
    ## 41         0.0000       0.00000           0.000            0.000
    ## 48         0.0000       0.00000           0.000            0.000
    ##    V_STARCHY_OTHER V_OTHER V_LEGUMES G_TOTAL G_WHOLE G_REFINED PF_TOTAL
    ## 2             0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 4             0.00 0.00000    0.0000 0.00000  0.0000   0.00000   9.3564
    ## 11            0.00 0.22440    0.0000 3.69240  0.0000   3.69240   0.6324
    ## 13            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.1440
    ## 14            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   5.0876
    ## 15            0.00 0.00000    0.0000 3.67120  0.9776   2.69360   0.0000
    ## 18            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 21            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 29            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 31            0.00 0.42315    0.0000 0.55335  0.0000   0.55335   3.2550
    ## 32            0.00 0.30680    0.0236 0.00000  0.0000   0.00000   1.1564
    ## 33            0.00 0.00000    0.0000 2.88510  0.0000   2.88510   0.0000
    ## 37            1.22 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 41            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 48            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   1.4826
    ##    PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT PF_SEAFD_HI
    ## 2        0.0000  0.0000       0.0000        0    0.000           0
    ## 4        3.3222  0.0000       3.3222        0    0.000           0
    ## 11       0.6324  0.0000       0.6324        0    0.000           0
    ## 13       0.0000  0.0000       0.0000        0    0.000           0
    ## 14       5.0876  5.0876       0.0000        0    0.000           0
    ## 15       0.0000  0.0000       0.0000        0    0.000           0
    ## 18       0.0000  0.0000       0.0000        0    0.000           0
    ## 21       0.0000  0.0000       0.0000        0    0.000           0
    ## 29       0.0000  0.0000       0.0000        0    0.000           0
    ## 31       3.2550  0.0000       0.0000        0    3.255           0
    ## 32       1.1564  1.1564       0.0000        0    0.000           0
    ## 33       0.0000  0.0000       0.0000        0    0.000           0
    ## 37       0.0000  0.0000       0.0000        0    0.000           0
    ## 41       0.0000  0.0000       0.0000        0    0.000           0
    ## 48       1.4826  0.0000       1.4826        0    0.000           0
    ##    PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES  D_TOTAL D_MILK
    ## 2             0  0.0000      0         0      0.000 1.000400 1.0004
    ## 4             0  6.0342      0         0      0.000 1.627200 0.4068
    ## 11            0  0.0000      0         0      0.000 0.652800 0.0000
    ## 13            0  0.1440      0         0      0.000 0.336000 0.3360
    ## 14            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 15            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 18            0  0.0000      0         0      0.000 1.998675 0.0000
    ## 21            0  0.0000      0         0      0.000 0.663875 0.0000
    ## 29            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 31            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 32            0  0.0000      0         0      0.118 0.023600 0.0000
    ## 33            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 37            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 41            0  0.0000      0         0      0.000 0.621000 0.6210
    ## 48            0  0.0000      0         0      0.000 0.000000 0.0000
    ##    D_YOGURT D_CHEESE     OILS SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 2    0.0000 0.000000  0.00000   3.342800     0.0000        0        1
    ## 4    0.0000 1.220400 20.47560  45.968400     0.0000        0        1
    ## 11   0.0000 0.652800  1.04040  19.278000     0.2448        0        1
    ## 13   0.0000 0.000000  0.00000  37.776000     9.8160        0        1
    ## 14   0.0000 0.000000  0.00000  12.371400     0.0000        0        1
    ## 15   0.0000 0.000000  5.44960   0.000000     0.3536        0        1
    ## 18   0.0000 1.998675  0.00000  25.183305     0.0000        0        1
    ## 21   0.0000 0.663875  0.00000   8.364825     0.0000        0        1
    ## 29   0.0000 0.000000 36.40000   0.000000     0.0000        0        1
    ## 31   0.0000 0.000000 15.39615   0.000000     0.0000        0        1
    ## 32   0.0236 0.000000  6.18320   4.342400     0.0000        0        1
    ## 33   0.0000 0.000000  6.79710   0.000000     0.0000        0        1
    ## 37   0.0000 0.000000  0.00000   0.000000     0.0000        0        1
    ## 41   0.0000 0.000000  0.00000  28.755000    11.2590        0        1
    ## 48   0.0000 0.000000  0.00000   0.000000     0.0000        0        1
    ##                                                                                                             Food_Description
    ## 2                                                                                                 Milk, cow's, fluid, 2% fat
    ## 4                                         Egg omelet or scrambled egg, with cheese, meat, and tomatoes, fat added in cooking
    ## 11                                                                             Pizza with meat and vegetables, regular crust
    ## 13                                                                             Ice cream, rich, flavors other than chocolate
    ## 14                                                                Ground beef, less than 80% lean, cooked (formerly regular)
    ## 15                                                                                          Roll, whole wheat, NS as to 100%
    ## 18                                                                                                           Cheese, Cheddar
    ## 21                                                                                                           Cheese, Cheddar
    ## 29                                                                                           White potato chips, regular cut
    ## 31 Chicken or turkey, rice, and vegetables (including carrots, broccoli, and/or dark-green leafy), soy-based sauce (mixture)
    ## 32                                                                                                                Beef curry
    ## 33                                                                  Rice, white, cooked, fat added in cooking, made with oil
    ## 37                                                                Corn, yellow, cooked, from fresh, fat not added in cooking
    ## 41                                                                          Ice cream, regular, flavors other than chocolate
    ## 48                                                                           Ham, sliced, prepackaged or deli, luncheon meat

    #another way: 
    subset(items, PROT >= 5)

    ##                             RecallRecId UserName
    ## 2  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 4  f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 11 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 13 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 14 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 15 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 18 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 21 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 29 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 31 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 32 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 33 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 37 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 41 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ## 48 f52ae861-cd5b-4ec2-9af1-eec184537f78  Snow373
    ##                                  UserID RecallNo RecallAttempt
    ## 2  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 4  4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 11 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 13 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 14 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 15 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 18 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 21 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 29 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 31 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 32 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 33 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 37 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 41 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ## 48 4fcd4df5-55ea-4249-b8fd-7b64a1ad9e58        4             0
    ##    RecallStatus IntakeStartDateTime IntakeEndDateTime ReportingDate Lang
    ## 2             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 4             2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 11            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 13            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 14            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 15            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 18            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 21            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 29            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 31            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 32            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 33            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 37            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 41            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ## 48            2     05/20/2018 0:00  05/20/2018 23:59    05/21/2018    1
    ##    Occ_No         Occ_Time Occ_Name EatWith WatchTVuseComputer Location
    ## 2       1 05/20/2018 11:00        1       4                  1        1
    ## 4       1 05/20/2018 11:00        1       4                  1        1
    ## 11      3 05/20/2018 17:00        3       2                  3        3
    ## 13      3 05/20/2018 17:00        3       2                  3        3
    ## 14      3 05/20/2018 17:00        3       2                  3        3
    ## 15      3 05/20/2018 17:00        3       2                  3        3
    ## 18      3 05/20/2018 17:00        3       2                  3        3
    ## 21      3 05/20/2018 17:00        3       2                  3        3
    ## 29      4 05/20/2018 19:30        6       1                  2        7
    ## 31      5 05/20/2018 22:00        5       1                  6        1
    ## 32      5 05/20/2018 22:00        5       1                  6        1
    ## 33      5 05/20/2018 22:00        5       1                  6        1
    ## 37      5 05/20/2018 22:00        5       1                  6        1
    ## 41      7  05/21/2018 2:00        7       1                  4        1
    ## 48      8  05/21/2018 3:00        6       3                  5        1
    ##    FoodNum FoodType                           FoodSrce CodeNum FoodCode
    ## 2        2        2             Other store (any type)       2 11112110
    ## 4        4        1             Other store (any type)       4 32131000
    ## 11      11        1                                         11 58106725
    ## 13      13        1                                         13 13110120
    ## 14      14        1                                         14 21501000
    ## 15      14        1                                         15 51320500
    ## 18      14        1                                         18 14104100
    ## 21      15        1                                         21 14104100
    ## 29      17        1                              Other      29 71201015
    ## 31      19        1    Other restaurant, bar or tavern      31 27345310
    ## 32      20        1    Other restaurant, bar or tavern      32 27116100
    ## 33      20        1    Other restaurant, bar or tavern      33 56205002
    ## 37      24        1    Other restaurant, bar or tavern      37 75216111
    ## 41      28        1 Fast food or drive-thru restaurant      41 13110100
    ## 48      29        1             Other store (any type)      48 25230210
    ##    ModCode HowMany SubCode PortionCode FoodAmt      KCAL     PROT     TFAT
    ## 2        0    1.00       0       10205  244.00  122.0000  8.05200  4.83120
    ## 4        0    6.00       0       61009  678.00 1240.7400 79.32600 93.83520
    ## 11       0    2.00       0       64369  204.00  497.7600 22.48080 22.23600
    ## 13       0    2.00       0       61396  240.00  597.6000  8.40000 38.88000
    ## 14       0    2.00       0       64195  158.00  388.6800 36.75080 25.75400
    ## 15       0    2.00       0       60847  104.00  283.9200  8.94400  6.55200
    ## 18       0   85.05       0          98   85.05  342.7515 21.17745 28.18557
    ## 21       0    0.25       0       10010   28.25  113.8475  7.03425  9.36205
    ## 29       0    4.00       0       10247  100.00  542.0000  6.56000 36.40000
    ## 31       0    1.50       0       10205  325.50  416.6400 32.90805 20.14845
    ## 32       0    1.00       0       10205  236.00  247.8000 14.91520 14.06560
    ## 33       0    1.50       0       10043  244.50  366.7500  6.35700  7.45725
    ## 37       0    2.00       0       61345  200.00  190.0000  6.78000  2.98000
    ## 41       0    2.25       0       61396  270.00  558.9000  9.45000 29.70000
    ## 48       0    1.50       0       62008   42.00   55.0200  7.11060  1.47000
    ##        CARB      MOIS ALC CAFF THEO     SUGR  FIBE     CALC    IRON
    ## 2  11.71200 217.67240   0    0    0 12.34640 0.000 292.8000 0.04880
    ## 4  17.62800 473.78640   0    0    0 11.39040 2.034 691.5600 7.39020
    ## 11 51.77520 102.81600   0    0    0  7.60920 4.488 244.8000 3.79440
    ## 13 53.49600 137.28000   0    0    0 49.56000 0.000 280.8000 0.81600
    ## 14  0.00000  91.95600   0    0    0  0.00000 0.000  50.5600 3.91840
    ## 15 47.84000  38.48000   0    0    0  1.69520 3.952 183.0400 3.69200
    ## 18  1.08864  31.25587   0    0    0  0.44226 0.000 613.2105 0.57834
    ## 21  0.36160  10.38188   0    0    0  0.14690 0.000 203.6825 0.19210
    ## 29 50.81000   2.28000   0    0    0  0.37000 4.400  24.0000 1.61000
    ## 31 26.20275 242.39985   0    0    0  4.75230 3.906  71.6100 1.95300
    ## 32 16.26040 188.89440   0    0    0  3.46920 4.012  77.8800 2.59600
    ## 33 66.55290 161.66340   0    0    0  0.12225 0.978  24.4500 2.83620
    ## 37 41.72000 145.96000   0    0    0  9.02000 4.800   6.0000 0.90000
    ## 41 63.72000 164.70000   0    0    0 57.29400 1.890 345.6000 0.24300
    ## 48  0.40740  31.51260   0    0    0  0.00000 0.000   2.1000 0.24360
    ##       MAGN     PHOS     POTA      SODI     ZINC      COPP      SELE     VC
    ## 2   26.840  224.480  341.600  114.6800 1.171200 0.0146400   6.10000  0.488
    ## 4  101.700 1213.620 1450.920 2922.1800 9.017400 0.4407000 130.17600 23.730
    ## 11  46.920  373.320  375.360 1201.5600 2.529600 0.2815200  47.12400  0.204
    ## 13  26.400  252.000  376.800  146.4000 1.128000 0.0192000   8.40000  0.000
    ## 14  31.600  311.260  504.020  646.2200 9.322000 0.1121800  30.65200  0.000
    ## 15  37.440  108.160  119.600  544.9600 0.936000 0.1560000  34.32000  0.000
    ## 18  23.814  435.456   83.349  528.1605 2.645055 0.0263655  11.82195  0.000
    ## 21   7.910  144.640   27.685  175.4325 0.878575 0.0087575   3.92675  0.000
    ## 29  70.000  155.000 1642.000  450.0000 2.390000 0.3980000   8.10000 18.600
    ## 31  58.590  318.990  732.375  764.9250 1.953000 0.1725150  36.78150 35.154
    ## 32  49.560  148.680  531.000  202.9600 3.280400 0.2124000  12.50800 23.128
    ## 33  29.340  102.690   83.130  581.9100 1.149150 0.1638150  17.60400  0.000
    ## 37  52.000  154.000  434.000  454.0000 1.240000 0.0980000   0.40000 11.000
    ## 41  37.800  283.500  537.300  216.0000 1.863000 0.0621000   4.86000  1.620
    ## 48   7.560  109.620  194.040  551.8800 0.659400 0.0726600  13.27200  0.000
    ##          VB1       VB2     NIAC      VB6    FOLA      FA      FF    FDFE
    ## 2  0.0951600 0.4514000  0.22448 0.092720  12.200   0.000  12.200  12.200
    ## 4  0.7458000 1.9390800  8.21058 1.044120 142.380   0.000 142.380 142.380
    ## 11 0.5222400 0.5426400  6.32400 0.199920 126.480  73.440  53.040 177.480
    ## 13 0.0984000 0.4008000  0.19680 0.108000  19.200   0.000  19.200  21.600
    ## 14 0.0679400 0.2765000  8.27604 0.538780  15.800   0.000  15.800  15.800
    ## 15 0.4503200 0.2839200  4.23488 0.079040  62.400  46.800  15.600  95.680
    ## 18 0.0229635 0.3189375  0.06804 0.062937  15.309   0.000  15.309  15.309
    ## 21 0.0076275 0.1059375  0.02260 0.020905   5.085   0.000   5.085   5.085
    ## 29 0.0630000 0.2300000  4.18200 0.723000  75.000   0.000  75.000  75.000
    ## 31 0.2441250 0.3417750 10.28906 1.048110  94.395  26.040  71.610 113.925
    ## 32 0.1416000 0.1793600  2.75176 0.420080  66.080   0.000  66.080  66.080
    ## 33 0.3838650 0.0317850  3.48657 0.220050 136.920 129.585   7.335 229.830
    ## 37 0.1840000 0.1140000  3.34600 0.276000  46.000   0.000  46.000  46.000
    ## 41 0.1107000 0.6480000  0.31320 0.129600  13.500   0.000  13.500  13.500
    ## 48 0.1411200 0.1117200  2.39274 0.165480   0.000   0.000   0.840   0.840
    ##        VB12     VARA     RET      BCAR     ACAR   CRYP    LYCO      LZ
    ## 2  1.293200 134.2000 134.200    9.7600    0.000   0.00    0.00    0.00
    ## 4  4.203600 759.3600 684.780  779.7000  162.720  27.12 4183.26 1715.34
    ## 11 1.387200 124.4400 110.160  165.2400    0.000   0.00 3445.56   53.04
    ## 13 0.936000 436.8000 429.600   76.8000    2.400   2.40    0.00   81.60
    ## 14 3.950000   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ## 15 0.000000   0.0000   0.000    0.0000    0.000   0.00    0.00   67.60
    ## 18 0.705915 225.3825 219.429   72.2925    0.000   0.00    0.00    0.00
    ## 21 0.234475  74.8625  72.885   24.0125    0.000   0.00    0.00    0.00
    ## 29 0.000000   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ## 31 0.260400 439.4250   6.510 4361.7000 1656.795   0.00    0.00  911.40
    ## 32 0.873200 311.5200   0.000 3282.7600  901.520   0.00  250.16 2461.48
    ## 33 0.000000   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ## 37 0.000000  26.0000   0.000  132.0000   46.000 320.00    0.00 1802.00
    ## 41 1.053000 318.6000 313.200   51.3000    0.000   0.00    0.00    0.00
    ## 48 0.151200   0.0000   0.000    0.0000    0.000   0.00    0.00    0.00
    ##        ATOC       VK     CHOLE      SFAT     S040      S060      S080
    ## 2  0.073200   0.4880   19.5200  3.067080 0.187880 0.0976000 0.0488000
    ## 4  7.458000  40.0020 1274.6400 32.645700 0.616980 0.3186600 0.1898400
    ## 11 1.754400  12.6480   55.0800  8.990280 0.299880 0.0571200 0.0795600
    ## 13 1.224000   3.1200  220.8000 24.789600 1.178400 0.6960000 0.4056000
    ## 14 0.695200   3.1600  129.5600  9.965060 0.000000 0.0000000 0.0000000
    ## 15 0.374400   2.8080    0.0000  1.556880 0.000000 0.0000000 0.0031200
    ## 18 0.246645   2.3814   89.3025 17.938746 0.889623 0.4499145 0.2372895
    ## 21 0.081925   0.7910   29.6625  5.958490 0.295495 0.1494425 0.0788175
    ## 29 6.740000  22.1000    0.0000  4.014000 0.000000 0.0000000 0.0000000
    ## 31 3.580500 107.7405  100.9050  3.043425 0.000000 0.0000000 0.0000000
    ## 32 2.006000 117.0560   44.8400  3.844440 0.002360 0.0023600 0.0023600
    ## 33 0.929100   7.5795    0.0000  1.070910 0.000000 0.0000000 0.0000000
    ## 37 0.180000   0.8000    0.0000  0.392000 0.000000 0.0000000 0.0000000
    ## 41 0.810000   0.8100  118.8000 18.333000 0.972000 0.5670000 0.3240000
    ## 48 0.121800   0.0000   17.2200  0.467460 0.000000 0.0016800 0.0000000
    ##       S100      S120     S140      S160     S180      MFAT     M161
    ## 2  0.11956 0.1342000 0.427000  1.361520 0.592920  1.366400 0.065880
    ## 4  0.40002 0.3525600 2.339100 19.485720 8.007180 35.798400 1.823820
    ## 11 0.18972 0.2182800 0.911880  4.753200 2.244000  7.725480 0.397800
    ## 13 0.91200 1.0200000 3.662400 10.003200 4.557600 10.704000 0.864000
    ## 14 0.00000 0.0189600 0.763140  5.612160 2.940380 11.845260 0.966960
    ## 15 0.00000 0.0000000 0.028080  0.858000 0.658320  3.233360 0.005200
    ## 18 0.51030 0.4601205 2.832165  8.337452 3.407954  7.987045 0.853902
    ## 21 0.16950 0.1528325 0.940725  2.769347 1.131978  2.652957 0.283630
    ## 29 0.00100 0.0080000 0.006000  2.830000 1.084000 15.999000 0.043000
    ## 31 0.01953 0.0065100 0.019530  2.125515 0.706335  7.672035 0.192045
    ## 32 0.02360 0.0236000 0.252520  2.409560 1.062000  5.786720 0.323320
    ## 33 0.00000 0.0000000 0.004890  0.772620 0.224940  2.953560 0.017115
    ## 37 0.00000 0.0000000 0.000000  0.368000 0.024000  0.744000 0.000000
    ## 41 0.75600 0.8370000 3.051000  8.262000 3.553200  8.016300 0.556200
    ## 48 0.00000 0.0000000 0.018900  0.305760 0.141120  0.707700 0.044520
    ##         M181     M201    M221      PFAT       P182      P183    P184
    ## 2   1.239520 0.004880 0.00000  0.178120  0.1512800 0.0195200 0.00000
    ## 4  33.188100 0.413580 0.00678 19.621320 16.5906600 1.7492400 0.00000
    ## 11  7.133880 0.085680 0.00204  3.855600  3.1028400 0.3202800 0.05916
    ## 13  9.835200 0.004800 0.00000  1.632000  1.0488000 0.5328000 0.00240
    ## 14 10.083560 0.090060 0.00000  0.718900  0.5624800 0.0695200 0.00000
    ## 15  3.228160 0.000000 0.00000  1.151280  1.0909600 0.0603200 0.00000
    ## 18  6.723202 0.000000 0.00000  0.801171  0.4907385 0.3104325 0.00000
    ## 21  2.233163 0.000000 0.00000  0.266115  0.1630025 0.1031125 0.00000
    ## 29 15.912000 0.044000 0.00000 15.998000 15.8270000 0.1720000 0.00000
    ## 31  7.174020 0.100905 0.00000  7.691565  6.4904700 0.9699900 0.00000
    ## 32  5.413840 0.044840 0.00000  3.131720  2.6125200 0.5026800 0.00000
    ## 33  2.897325 0.036675 0.00000  3.117375  2.6968350 0.4180950 0.00000
    ## 37  0.744000 0.000000 0.00000  1.198000  1.1660000 0.0360000 0.00000
    ## 41  7.460100 0.000000 0.00000  1.220400  0.7425000 0.4725000 0.00000
    ## 48  0.653100 0.010080 0.00000  0.147000  0.1344000 0.0067200 0.00000
    ##        P204     P205     P225    P226   VITD     CHOLN VITE_ADD B12_ADD
    ## 2  0.000000 0.000000 0.000000 0.00000 2.9280  40.01600        0       0
    ## 4  0.657660 0.000000 0.040680 0.17628 8.8140 871.23000        0       0
    ## 11 0.044880 0.000000 0.000000 0.00000 0.0000  44.26800        0       0
    ## 13 0.033600 0.002400 0.000000 0.00960 0.7200  62.40000        0       0
    ## 14 0.063200 0.004740 0.025280 0.00158 0.3160 119.92200        0       0
    ## 15 0.000000 0.000000 0.000000 0.00000 0.0000  19.44800        0       0
    ## 18 0.000000 0.000000 0.000000 0.00000 0.5103  14.03325        0       0
    ## 21 0.000000 0.000000 0.000000 0.00000 0.1695   4.66125        0       0
    ## 29 0.000000 0.000000 0.000000 0.00000 0.0000  12.10000        0       0
    ## 31 0.074865 0.003255 0.009765 0.00651 0.0000  78.12000        0       0
    ## 32 0.009440 0.000000 0.007080 0.00000 0.0000  70.80000        0       0
    ## 33 0.000000 0.000000 0.000000 0.00000 0.0000   4.89000        0       0
    ## 37 0.000000 0.000000 0.000000 0.00000 0.0000  57.80000        0       0
    ## 41 0.000000 0.008100 0.000000 0.00000 0.5400  70.20000        0       0
    ## 48 0.005460 0.000000 0.000000 0.00000 0.2940  26.20800        0       0
    ##    F_TOTAL F_CITMLB F_OTHER F_JUICE V_TOTAL V_DRKGR V_REDOR_TOTAL
    ## 2        0        0       0       0 0.00000 0.00000       0.00000
    ## 4        0        0       0       0 1.08480 0.00000       1.08480
    ## 11       0        0       0       0 0.38760 0.00000       0.16320
    ## 13       0        0       0       0 0.00000 0.00000       0.00000
    ## 14       0        0       0       0 0.00000 0.00000       0.00000
    ## 15       0        0       0       0 0.00000 0.00000       0.00000
    ## 18       0        0       0       0 0.00000 0.00000       0.00000
    ## 21       0        0       0       0 0.00000 0.00000       0.00000
    ## 29       0        0       0       0 1.75000 0.00000       0.00000
    ## 31       0        0       0       0 1.00905 0.29295       0.29295
    ## 32       0        0       0       0 0.89680 0.14160       0.21240
    ## 33       0        0       0       0 0.00000 0.00000       0.00000
    ## 37       0        0       0       0 1.22000 0.00000       0.00000
    ## 41       0        0       0       0 0.00000 0.00000       0.00000
    ## 48       0        0       0       0 0.00000 0.00000       0.00000
    ##    V_REDOR_TOMATO V_REDOR_OTHER V_STARCHY_TOTAL V_STARCHY_POTATO
    ## 2          0.0000       0.00000           0.000            0.000
    ## 4          1.0848       0.00000           0.000            0.000
    ## 11         0.1632       0.00000           0.000            0.000
    ## 13         0.0000       0.00000           0.000            0.000
    ## 14         0.0000       0.00000           0.000            0.000
    ## 15         0.0000       0.00000           0.000            0.000
    ## 18         0.0000       0.00000           0.000            0.000
    ## 21         0.0000       0.00000           0.000            0.000
    ## 29         0.0000       0.00000           1.750            1.750
    ## 31         0.0000       0.29295           0.000            0.000
    ## 32         0.0472       0.16520           0.236            0.236
    ## 33         0.0000       0.00000           0.000            0.000
    ## 37         0.0000       0.00000           1.220            0.000
    ## 41         0.0000       0.00000           0.000            0.000
    ## 48         0.0000       0.00000           0.000            0.000
    ##    V_STARCHY_OTHER V_OTHER V_LEGUMES G_TOTAL G_WHOLE G_REFINED PF_TOTAL
    ## 2             0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 4             0.00 0.00000    0.0000 0.00000  0.0000   0.00000   9.3564
    ## 11            0.00 0.22440    0.0000 3.69240  0.0000   3.69240   0.6324
    ## 13            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.1440
    ## 14            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   5.0876
    ## 15            0.00 0.00000    0.0000 3.67120  0.9776   2.69360   0.0000
    ## 18            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 21            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 29            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 31            0.00 0.42315    0.0000 0.55335  0.0000   0.55335   3.2550
    ## 32            0.00 0.30680    0.0236 0.00000  0.0000   0.00000   1.1564
    ## 33            0.00 0.00000    0.0000 2.88510  0.0000   2.88510   0.0000
    ## 37            1.22 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 41            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   0.0000
    ## 48            0.00 0.00000    0.0000 0.00000  0.0000   0.00000   1.4826
    ##    PF_MPS_TOTAL PF_MEAT PF_CUREDMEAT PF_ORGAN PF_POULT PF_SEAFD_HI
    ## 2        0.0000  0.0000       0.0000        0    0.000           0
    ## 4        3.3222  0.0000       3.3222        0    0.000           0
    ## 11       0.6324  0.0000       0.6324        0    0.000           0
    ## 13       0.0000  0.0000       0.0000        0    0.000           0
    ## 14       5.0876  5.0876       0.0000        0    0.000           0
    ## 15       0.0000  0.0000       0.0000        0    0.000           0
    ## 18       0.0000  0.0000       0.0000        0    0.000           0
    ## 21       0.0000  0.0000       0.0000        0    0.000           0
    ## 29       0.0000  0.0000       0.0000        0    0.000           0
    ## 31       3.2550  0.0000       0.0000        0    3.255           0
    ## 32       1.1564  1.1564       0.0000        0    0.000           0
    ## 33       0.0000  0.0000       0.0000        0    0.000           0
    ## 37       0.0000  0.0000       0.0000        0    0.000           0
    ## 41       0.0000  0.0000       0.0000        0    0.000           0
    ## 48       1.4826  0.0000       1.4826        0    0.000           0
    ##    PF_SEAFD_LOW PF_EGGS PF_SOY PF_NUTSDS PF_LEGUMES  D_TOTAL D_MILK
    ## 2             0  0.0000      0         0      0.000 1.000400 1.0004
    ## 4             0  6.0342      0         0      0.000 1.627200 0.4068
    ## 11            0  0.0000      0         0      0.000 0.652800 0.0000
    ## 13            0  0.1440      0         0      0.000 0.336000 0.3360
    ## 14            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 15            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 18            0  0.0000      0         0      0.000 1.998675 0.0000
    ## 21            0  0.0000      0         0      0.000 0.663875 0.0000
    ## 29            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 31            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 32            0  0.0000      0         0      0.118 0.023600 0.0000
    ## 33            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 37            0  0.0000      0         0      0.000 0.000000 0.0000
    ## 41            0  0.0000      0         0      0.000 0.621000 0.6210
    ## 48            0  0.0000      0         0      0.000 0.000000 0.0000
    ##    D_YOGURT D_CHEESE     OILS SOLID_FATS ADD_SUGARS A_DRINKS FoodComp
    ## 2    0.0000 0.000000  0.00000   3.342800     0.0000        0        1
    ## 4    0.0000 1.220400 20.47560  45.968400     0.0000        0        1
    ## 11   0.0000 0.652800  1.04040  19.278000     0.2448        0        1
    ## 13   0.0000 0.000000  0.00000  37.776000     9.8160        0        1
    ## 14   0.0000 0.000000  0.00000  12.371400     0.0000        0        1
    ## 15   0.0000 0.000000  5.44960   0.000000     0.3536        0        1
    ## 18   0.0000 1.998675  0.00000  25.183305     0.0000        0        1
    ## 21   0.0000 0.663875  0.00000   8.364825     0.0000        0        1
    ## 29   0.0000 0.000000 36.40000   0.000000     0.0000        0        1
    ## 31   0.0000 0.000000 15.39615   0.000000     0.0000        0        1
    ## 32   0.0236 0.000000  6.18320   4.342400     0.0000        0        1
    ## 33   0.0000 0.000000  6.79710   0.000000     0.0000        0        1
    ## 37   0.0000 0.000000  0.00000   0.000000     0.0000        0        1
    ## 41   0.0000 0.000000  0.00000  28.755000    11.2590        0        1
    ## 48   0.0000 0.000000  0.00000   0.000000     0.0000        0        1
    ##                                                                                                             Food_Description
    ## 2                                                                                                 Milk, cow's, fluid, 2% fat
    ## 4                                         Egg omelet or scrambled egg, with cheese, meat, and tomatoes, fat added in cooking
    ## 11                                                                             Pizza with meat and vegetables, regular crust
    ## 13                                                                             Ice cream, rich, flavors other than chocolate
    ## 14                                                                Ground beef, less than 80% lean, cooked (formerly regular)
    ## 15                                                                                          Roll, whole wheat, NS as to 100%
    ## 18                                                                                                           Cheese, Cheddar
    ## 21                                                                                                           Cheese, Cheddar
    ## 29                                                                                           White potato chips, regular cut
    ## 31 Chicken or turkey, rice, and vegetables (including carrots, broccoli, and/or dark-green leafy), soy-based sauce (mixture)
    ## 32                                                                                                                Beef curry
    ## 33                                                                  Rice, white, cooked, fat added in cooking, made with oil
    ## 37                                                                Corn, yellow, cooked, from fresh, fat not added in cooking
    ## 41                                                                          Ice cream, regular, flavors other than chocolate
    ## 48                                                                           Ham, sliced, prepackaged or deli, luncheon meat

Counting factors
================

Sometimes we want to know how many of a specific factor we have in our
data. We can do this a few ways:

e.g. how many counts are there for each FOODSRC?

    table(items$FoodSrce)

    ## 
    ##                                    Fast food or drive-thru restaurant 
    ##                                 17                                  5 
    ##                              Other                    Other cafeteria 
    ##                                  1                                  2 
    ##    Other restaurant, bar or tavern             Other store (any type) 
    ##                                  9                                 15 
    ##                        Other: Gift 
    ##                                  2

The ‘dplyr’ package
===================

[dplyr](https://dplyr.tidyverse.org/) is an R library used for data
manipulation. We’ll briefly cover the following functions:

-   select
-   filter

But these are just a few of many dplyr functions that are helpful for
data manipulation and organization!

First, we need to install and load the dplyr package:

    #install the package. you'll only need to do this once
    install.packages('dplyr')

after it’s installed, you need to load it. you’ll do this EVERYTIME you
want to use it in a single file (not every time you want to use a
specific function though)

    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

dplyr::select
-------------

The `select` function makes it easy to select columns.  
Let’s use it to select the FoodCode and Food\_Description from items,
and assign it to a new df called “tiny\_items”

    ?select()

    tiny_items<- select(items, 
                        c(FoodCode, Food_Description)) #remember the c!
    #select(items, c("FoodCode", "Food_Description")) #you can also use the "" but you don't need it.

dplyr::filter
-------------

The `filter` function is similar to ‘subset’ and makes it easy to select
certain rows from a column given a specific condition.

E.g. Filter tiny\_items to only include FoodCodes greater than 60000000.

    ?filter()

    ## Help on topic 'filter' was found in the following packages:
    ## 
    ##   Package               Library
    ##   dplyr                 /Users/elizabeth.chin/Library/R/3.6/library
    ##   stats                 /Library/Frameworks/R.framework/Versions/3.6/Resources/library
    ## 
    ## 
    ## Using the first match ...

    filter(tiny_items, 
           FoodCode > 60000000) #FoodCode is numeric

    ##    FoodCode
    ## 1  63107010
    ## 2  61210220
    ## 3  92101000
    ## 4  91101010
    ## 5  94100100
    ## 6  91746100
    ## 7  92410310
    ## 8  75506010
    ## 9  75117020
    ## 10 75113080
    ## 11 72116000
    ## 12 75117020
    ## 13 75122100
    ## 14 83112500
    ## 15 93101000
    ## 16 71201015
    ## 17 75113000
    ## 18 92302000
    ## 19 91104200
    ## 20 75205033
    ## 21 75216111
    ## 22 81103080
    ## 23 91745020
    ## 24 63223020
    ## 25 91302010
    ## 26 91101000
    ## 27 83107000
    ##                                                                  Food_Description
    ## 1                                                                     Banana, raw
    ## 2                                    Orange juice, canned, bottled or in a carton
    ## 3                                               Coffee, made from ground, regular
    ## 4                                                Sugar, white, granulated or lump
    ## 5                                                     Water, bottled, unsweetened
    ## 6           M&M's Milk Chocolate Candies (formerly M&M's Plain Chocolate Candies)
    ## 7                                                           Soft drink, cola-type
    ## 8                                                                         Mustard
    ## 9                                                             Onions, mature, raw
    ## 10                                                          Lettuce, arugula, raw
    ## 11                             Endive, chicory, escarole, or romaine lettuce, raw
    ## 12                                                            Onions, mature, raw
    ## 13                                                      Pepper, sweet, green, raw
    ## 14                                                                Creamy dressing
    ## 15                                                                           Beer
    ## 16                                                White potato chips, regular cut
    ## 17                                                                   Lettuce, raw
    ## 18                                                         Tea, leaf, unsweetened
    ## 19                                                                     Sugar, raw
    ## 20 Beans, string, green, cooked, from canned, fat added in cooking W/ BUTTER, NFS
    ## 21                     Corn, yellow, cooked, from fresh, fat not added in cooking
    ## 22                                             Margarine-like spread, tub, salted
    ## 23                                                                     Hard candy
    ## 24                                                              Strawberries, raw
    ## 25                                                                          Honey
    ## 26                                                                     Sugar, NFS
    ## 27                                                            Mayonnaise, regular

Notice that all columns are returned

Filter can also be used on columns of a non-numeric class  
E.g. Filter dataframe tiny\_items to only include rows where the
Food\_Description is “Cheerios”

    class(tiny_items$Food_Description)

    ## [1] "factor"

    filter(tiny_items,
           Food_Description == "Cheerios") #notice the ""

    ##   FoodCode Food_Description
    ## 1 57123000         Cheerios

Here’s an example of two rules

    filter(tiny_items, 
           Food_Description == "Cheerios" | 
             Food_Description == "Banana, raw")

    ##   FoodCode Food_Description
    ## 1 57123000         Cheerios
    ## 2 63107010      Banana, raw

**DIY:** ***1) select the columns: FoodCode, Food\_Description, SUGR,
and TFAT from ‘items’ (in that order) and assign to a new dataframe
called “df”***

    df<-select(items, 
               c(FoodCode, Food_Description, SUGR, TFAT))

    #another way:
    df<-items[,c("FoodCode", "Food_Description", "SUGR", "TFAT")]

***2) filter ‘df’ to only include rows where the values of SUGR are
greater than 4 and the FoodCode is less than or equal to 50000000.
Assign to a new dataframe called ‘df2’***

    df2<- filter(df, 
                 SUGR >4 & 
                   FoodCode <= 50000000)

***3) what are the dimensions of df2? What is the median of TFAT in df2?
What is the median of TFAT in df?***

    dim(df2)

    ## [1] 6 4

    summary(df2$TFAT)

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   2.974   8.661  24.924  31.728  36.585  93.835

    summary(df$TFAT)

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##  0.00000  0.07808  2.20410  8.50229  9.75222 93.83520

Recap
=====

tl;dr

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Function Name</th>
<th>What it does</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>setwd</td>
<td>sets the working directory (tells R where to look for your files, where to save your files)</td>
</tr>
<tr class="even">
<td>read.csv</td>
<td>reads in CSV files from a given location (e.g. your working directory)</td>
</tr>
<tr class="odd">
<td>library</td>
<td>loads a given library. do this before you use a function from the library for the first time in a session.</td>
</tr>
<tr class="even">
<td>str</td>
<td>returns the structure of your data</td>
</tr>
<tr class="odd">
<td>class</td>
<td>returns the class of your data (i.e. tells you what type of data you have)</td>
</tr>
<tr class="even">
<td>names</td>
<td>returns the names of an object. This is the same as ‘colnames’ for a data frame.</td>
</tr>
<tr class="odd">
<td>dim</td>
<td>returns the dimensions of a matrix, array, or data frame</td>
</tr>
<tr class="even">
<td>nrow and ncol</td>
<td>returns the number of rows or columns</td>
</tr>
<tr class="odd">
<td>View</td>
<td>invokes a spreadsheet-like data viewer in a new tab (notice the capital V)</td>
</tr>
<tr class="even">
<td>summary</td>
<td>produces a summary of the object (e.g. mean, median, max)</td>
</tr>
<tr class="odd">
<td>select</td>
<td>from the dplyr package. selects specific columns that can be specified by the column name</td>
</tr>
<tr class="even">
<td>filter</td>
<td>from the dplyr package. returns rows that meet a given rule(s) for a column(s)</td>
</tr>
</tbody>
</table>
