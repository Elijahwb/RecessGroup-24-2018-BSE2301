#user interface libraries
library(shiny)
library(shinydashboard)
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

shinyUI(dashboardPage(skin = "yellow",
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
      img(id="logo",src="logo2.png")
    )#end of sidebar menu
  ),
  #begining of the body of the application
  dashboardBody(
    tags$head(tags$style(
                HTML('
                     #logo{margin-left:100px;position:fixed;margin-top:260px;}
                      #logo2{margin-left:410px;top:-20px;position:relative;}
                      #logo:hover{transform:scale(1.03);}
                      #dashboard{margin-left:300px;color:#343031}
                      #line{color:black;width:600px;}
                      tr{padding:50px;}
                    #black-box{margin-left:290px;width:1200px;}
                     cloud-output{border-radius:5px;}')),
              tags$script(src="projectjs1.js")),
    tabItems(
      tabItem(tabName="myDashboard",
              img(" ",src="starwars2.png",id="logo2"),
              h1(id="dashboard","Welcome to ",strong("Recess-Group-24")," project"),
              tags$div(id="black-box",box(title="Group-24 Software Engineer Members!",height=300,status="success",
                  tableOutput("table1"))),
              verbatimTextOutput(outputId = "first")
    ),#end of the first dashboard tab information
    
    
    tabItem(tabName="sentiments",
            h1(id="dashboard","Sentiment Panel"),
            box("Negative",status="info",plotOutput("senti1"),background="yellow")
    ),#end of sentiments sub menu
    
    
    tabItem(tabName="wordclouds",icon=icon("cloud"),
            h1(id="dashboard","Wordcloud Panel"),
            tags$div(id="cloud-output",box("Word cloud for Episode",status="warning",wordcloud2Output(outputId="cloud"),width=500,height=490)
            )),#end of wordclouds sub menu
    
    
    tabItem(tabName="charts",
            h1(id="dashboard","Charts Panel"),
            box("chart-1",status="warning",plotlyOutput("chart1"),width="600",height="500",background = "yellow")
    ),#end of charts sub menu
    
    
    tabItem(tabName="characters",
            h1(id="dashboard","Characters' Panel"),
            box("Number of Characters",status="danger",verbatimTextOutput("characters"),
                h2("Character names"),br(),
                verbatimTextOutput("characterNames"),background="yellow")
    )#end of charts sub menu
  )#end of the body of the application
)
))
#end of the user interface
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
