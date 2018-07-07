library(shiny)
library(shinydashboard)

ui <-dashboardPage(skin = "purple",
  
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
    h1("Welcome to the ",strong("Recess Group 24")," System!")
  )#end of the body of the application
)
#end of the user interface

server <-function(input, output){}

shinyApp(ui = ui, server = server)