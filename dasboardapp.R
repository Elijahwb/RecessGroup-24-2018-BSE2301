library(shiny)
library(shinydashboard)

ui <-dashboardPage(skin = "green",
  dashboardHeader(title = "Recess-Group-24 System Functions", titleWidth = 450,
    dropdownMenu(type = "messages",
                 messageItem(from = "Recess-Group-24",message="Thank you for logging into our system."),
                 messageItem(from = "New user",message="how do you register?",icon = icon("question"),time = "12:00"),
                 messageItem(from = "Support",message="The new Server is ready",icon = icon("life-ring"),time = "2018-07-07"))
  ),
  dashboardSidebar(),
  dashboardBody()
)

server <-function(input, output){}

shinyApp(ui = ui, server = server)