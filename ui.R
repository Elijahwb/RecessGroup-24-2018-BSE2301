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

shinyUI(dashboardPage(skin = "green",
  
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
              box(title="Group-24 Software Egineer Members!",width=500,height=490,status="success",
                  tableOutput("table1")),
              verbatimTextOutput(outputId = "first")
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
))
#end of the user interface
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
