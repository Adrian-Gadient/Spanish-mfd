# Authors:
# Adrian Bruegger, Stefan Borer

# clean slate
rm(list = ls())

# make locale well defined
Sys.setlocale("LC_ALL", "C")

# treat all factors as strings
options(stringsAsFactors = F)

# load packages (and install if not yet available)
if (!require("pacman")) install.packages("pacman")
pacman::p_load("tidyverse", "quanteda", "lubridate", "readtext")
pacman::p_load_gh("kbenoit/quanteda.dictionaries", dependencies = TRUE)

# create dataframe with some sample text (works with .txt, .csv, XML, API/JSON)

sampletexts <- readtext(paste0("*texts/*.txt"),
                    docvarsfrom = "filenames", # indicates that the meta information is coming from the file names
                    dvsep = "_", # indicates the separator that separates the information
                    docvarnames = c("source","language")) # indicates the name of the meta variables
str(sampletexts)


#create corpus object
sample_corpus <- corpus(sampletexts) # build a new corpus from the texts


# load Moral Foundations dictionary in Spanish
dict_ES <- dictionary(file = "dicts/dict_es_final.dic",
                          format = "LIWC")
# english version
dict_EN <- dictionary(file = "dicts/mfd2.0.dic",
                     format = "LIWC")



# analysis based on liwc approach using Spanish dictionary 
dict_analysis_ES <- liwcalike(sample_corpus, dictionary = dict_ES)


# analysis based on liwc approach using Spanish dictionary 
dict_analysis_EN <- liwcalike(sample_corpus, dictionary = dict_EN)
