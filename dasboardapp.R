#user interface libraries
library(shiny)
library(shinydashboard)
#analysis libraries
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
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ui <-dashboardPage(skin = "green",
  
  dashboardHeader(title = "Recess-Group-24 System Functions", titleWidth = 450,
    dropdownMenu(type = "messages",
                 messageItem(from = "Recess-Group-24",message="Thank you for logging into our system."),
                 messageItem(from = "New user",message="No registration is needed.",icon = icon("thumbs-up"),time = "12:00"),
                 messageItem(from = "Support",message="The new Server is ready",icon = icon("server"),time = "2018-07-07")
                 ),#end of messages drop down
    dropdownMenu(type = "tasks",
                 badgeStatus = "success",
                 taskItem(value = 85, color = "green","Documentation of the Project"),
                 taskItem(value = 75, color = "yellow", "Project deployment"),
                 taskItem(value = 80, color = "red","Overall project")
                )#end of tasks drop down
  ),
  dashboardSidebar(tags$head(tags$script(src="projectjs1.js")),
    sidebarMenu(
      menuItem("Dashboard",tabName ="myDashboard",icon=icon("dashboard")),
      menuItem("Sentiment Analysis",tabName ="sentiment",icon=icon("comment")),
      menuItem("Word Clouds",tabName ="wordclouds",icon=icon("cloud")),
      menuItem("Charts",tabName ="charts",icon=icon("bar-chart-o")),
      menuItem("Characters in the movie",tabName ="characters",icon=icon("users")),
      img(src="group24-3.png","",width='180',height='40',id="logo")
    )#end of sidebar menu
  ),
  #begining of the body of the application
  dashboardBody(
    h1("Welcome to the ",strong("Recess Group 24")," System!"),
    
    box(title="Word Cloud",status="info",plotOutput(outputId ="wordcloud"))
  )#end of the body of the application
)
#end of the user interface
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

server <-function(input, output,session){
  #load the datasets that are going to be used
  ep4<-read.table('C:/Users/brand/OneDrive/Desktop/text mining/corpus/SW_EpisodeIV.txt')
  ep5<-read.table('C:/Users/brand/OneDrive/Desktop/text mining/corpus/SW_EpisodeV.txt')
  ep6<-read.table('C:/Users/brand/OneDrive/Desktop/text mining/corpus/SW_EpisodeVI.txt')
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
  #end of the function
  #pal <-brewer.pal(9,"Dark2")
  #creating a word cloud
  df<-createterms(ep4$dialogue)
  
  
  
  #figPath = system.file("examples/a.png",package = "wordcloud2")
  
  #output$my_wc  = renderWordcloud2(wordcloud2(df,size=1,color="random-dark",shape ="diamond", minSize = 0, gridSize = 0,fontFamily = 'Segoe UI' ))
  output$wordcloud <-renderPlot(wordcloud2(df,size=1,color="random-dark",shape ="diamond",fontFamily = 'Segoe UI' ))
  #my_wc2_clicked_word<-"this is Elijah."
}
#end of server script of the project
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
shinyApp(ui = ui, server = server)