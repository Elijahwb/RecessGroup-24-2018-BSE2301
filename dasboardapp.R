rm(list=ls())
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
library(datasets)
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ui <-dashboardPage(skin = "green",
  
  dashboardHeader(title = "STAR-WARS Dashboard",titleWidth=350, 
    dropdownMenu(type = "messages",
                 messageItem(from = "Recess-Group-24",message="Thank you for logging into our system."),
                 messageItem(from = "New user",message="No registration is needed.",icon = icon("thumbs-up"),time = "12:00"),
                 messageItem(from = "Support",message="The new Server is ready",icon = icon("server"),time = "2018-07-07")
                 ),#end of messages drop down
    dropdownMenu(type = "tasks",
                 badgeStatus = "success",
                 taskItem(value = 85, color = "green","Documentation of the Project"),
                 taskItem(value = 45, color = "yellow", "Project deployment"),
                 taskItem(value = 75, color = "red","Overall project")
                )#end of tasks drop down
  ),
  dashboardSidebar(width=350,
    sidebarMenu(
      menuItem("Home",tabName ="myDashboard",icon=icon("th")),
      menuItem("Sentiment Analysis",tabName ="sentiments",icon=icon("comment")),
      menuItem("Word Clouds",tabName ="wordclouds",icon=icon("cloud")),
      menuItem("Charts",tabName ="charts",icon=icon("bar-chart-o")),
      menuItem("Characters in the movie",tabName ="characters",icon=icon("users")),
      img(" ",src="logo2.png",id="logo")
    )#end of sidebar menu
  ),
  #begining of the body of the application
  dashboardBody(
    tags$head(tags$style(
                HTML('
                     #logo{margin-left:100px;position:absolute;margin-top:260px;}
                      #logo:hover{transform:scale(1.03);}
                      #dashboard{margin-left:300px;color:#343031}
                      #line{color:black;width:600px;}
                      tr{padding:50px;}'))),
    tabItems(
      tabItem(tabName="myDashboard",
              h1(id="dashboard","Welcome to ",strong("Recess-Group-24")," project"),
              box(title="Group-24 Software Egineer Members!",width=500,height=490,
                  DT::dataTableOutput("table1"))
    ),#end of the first dashboard tab information
    tabItem(tabName="sentiments",
            h2("Sentiments"),
            box("Negative",status="info",plotOutput("cloud"))
    ),#end of sentiments sub menu
    tabItem(tabName="wordclouds",
            box("Word cloud for Episode",status="success",wordcloud2Output(outputId="cloud"))
            ),#end of wordclouds sub menu
    tabItem(tabName="charts",
            h2("Charts Panel"),
            box("chart-1",status="warning",plotOutput("cloud"))
    ),#end of charts sub menu
    tabItem(tabName="characters",
            h2("characters Panel"),
            box("Number of Characters",status="danger",plotOutput("cloud"))
    )#end of charts sub menu
  )#end of the body of the application
)
)
#end of the user interface
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

server <-function(input, output,session){
  #load the datasets that are going to be used
  members<-read.table('C:/Users/brand/OneDrive/Desktop/Recess Project Git/RecessGroup-24-2018-BSE2301/datasets/names.csv',sep=",",header=TRUE )
  ep4<-read.table('C:/Users/brand/OneDrive/Desktop/Recess Project Git/RecessGroup-24-2018-BSE2301/datasets/SW_EpisodeIV.txt')
  ep5<-read.table('C:/Users/brand/OneDrive/Desktop/Recess Project Git/RecessGroup-24-2018-BSE2301/datasets/SW_EpisodeV.txt')
  ep6<-read.table('C:/Users/brand/OneDrive/Desktop/Recess Project Git/RecessGroup-24-2018-BSE2301/datasets/SW_EpisodeVI.txt')
  #end of the loading of the datasets that are needed
  
  #creating a vector of words which are stopwords
  stop_words<-c(stopwords("english"),c("thats","weve","hes","theres","ive","will","can","cant","dont","youve","youre","youll","theyre","whats","didnt","us"))
  
  #creating  clean corpus function
  cleancorpus<- function(corpus){
    
    #removes punctuation
    corpus <- tm_map(corpus,removePunctuation)
    
    #removes whitespaces
    corpus <- tm_map(corpus,stripWhitespace)
    
    #converts all strings to lowercase
    corpus <- tm_map(corpus,content_transformer(tolower))
    
    #removes stopwords
    corpus <- tm_map(corpus,removeWords,stop_words)
    
    #removes numbers
    corpus <- tm_map(corpus,removeNumbers)
    
    #returns clean corpus
    return(corpus)
  }
  #end of the function that returns a clean corpus
  
  
  createterms <- function(text){
    #creating createterms function , it takes text column as input and gives a dataframe with term and term frequency as outut  
    
    #creating a corpus from the text column 
    df_corp <- VCorpus(VectorSource(text))  
    
    #Cleaning the corpus using the cleancorpus function
    df_corp_clean <- cleancorpus(df_corp)
    
    #Creating a  term document matrix
    df_tdm <- TermDocumentMatrix(df_corp_clean)
    
    #Removing sparse terms from the TermDocumentMatrix
    df_tdm <- removeSparseTerms(df_tdm,sparse = 0.99)
    
    #Converting the TermDocumentMatrix to a Matrix in R
    df_m <- as.matrix(df_tdm)
    
    #convering matrix to data frame with terms and term frequency  
    word_freq = sort(rowSums(df_m), decreasing=T)
    
    df <- data.frame(word = names(word_freq),freq = word_freq)
    
    
    #return the dataframe 
    return(df)
  }
  
  df<-createterms(ep4$dialogue)
  
  output$cloud <-renderWordcloud2(wordcloud2(df,size=1,color="random-dark",fontFamily = 'Segoe UI' ))
  output$table1<-DT::renderDataTable({DT=members})
  
}
#end of server script of the project
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
shinyApp(ui = ui, server = server)