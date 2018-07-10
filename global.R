#user interface libraries
library(shiny)
library(shinydashboard)
#analysis libraries
library(DT)
library(plotly)
library(wordcloud2)
library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(dplyr)
library(tidytext)
library(tidyr)
library(tm)
library(wordcloud)
library(reshape2)
library(stringr)

#load the datasets that are going to be used
members<-read.table('C:/Users/brand/OneDrive/Desktop/Recess Project Git/RecessGroup-24-2018-BSE2301/datasets/names.csv',sep=",",header=TRUE )
ep4<-read.table('C:/Users/brand/OneDrive/Desktop/text mining/corpus/SW_EpisodeIV.txt')
ep5<-read.table('C:/Users/brand/OneDrive/Desktop/text mining/corpus/SW_EpisodeV.txt')
ep6<-read.table('C:/Users/brand/OneDrive/Desktop/text mining/corpus/SW_EpisodeVI.txt')
#end of the loading of the datasets that are needed
