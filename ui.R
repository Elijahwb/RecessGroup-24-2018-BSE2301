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
      menuItem("Charts",tabName ="charts",icon=icon("bar-chart-o"),
               menuSubItem("Episode IV",tabName = "chartepisode4"),
               menuSubItem("Episode V",tabName = "chartepisode5"),
               menuSubItem("Episode VII",tabName = "chartepisode6")),
      menuItem("Characters in the movie",tabName ="characters",icon=icon("users"),
               menuSubItem("Episode IV",tabName = "cepisode4"),
               menuSubItem("Episode V",tabName = "cepisode5"),
               menuSubItem("Episode VII",tabName = "cepisode6")),
      img(id="logo",src="logo2.png")
    )#end of sidebar menu
  ),
  #begining of the body of the application
  dashboardBody(
    tags$head(tags$style(
                HTML('
                     #logo{margin-left:100px;position:fixed;margin-top:260px;}
                      #logo2{margin-left:340px;top:-20px;position:relative;}
                      #logo:hover{transform:scale(1.03);}
                      #dashboard{margin-left:230px;color:#343031}
                      #line{color:black;width:600px;}
                      tr{padding:50px;}
                    #black-box{margin-left:220px;width:1200px;}
                    #tab1,#tab2{width:900px;}
                     cloud-output{border-radius:5px;}')),
              tags$script(src="projectjs1.js")),
    tabItems(
      tabItem(tabName="myDashboard",
              img(" ",src="starwars3.png",id="logo2"),
              h1(id="dashboard","Welcome to ",strong("Recess-Group-24")," project"),
              tags$div(id="black-box",box(title="Group-24 Software Engineer Members!",height=250,status="warning",
                  tableOutput("table1"))),
              verbatimTextOutput(outputId = "first")
    ),#end of the first dashboard tab information
    
    
    tabItem(tabName="sentiments",
            h1(id="dashboard","Sentiment Panel"),
            tabBox(id="tab1",title="Negative",
                   tabPanel("Episode IV",plotOutput("sentiment1")),
                   tabPanel("Episode V"),
                   tabPanel("Episode VI"))
    ),#end of sentiments sub menu
    
    
    tabItem(tabName="wordclouds",icon=icon("cloud"),
            h1(id="dashboard","Wordcloud Panel"),
            tabBox(id="tab2",title="Negative",
                   tabPanel("Episode IV",height="200px",
                            tags$div(id="cloud-output",
                                     box("Word cloud for Episode",status="warning",
                                         wordcloud2Output(outputId="cloud"),width=300)
                   )),
                   tabPanel("Episode V"),
                   tabPanel("Episode VI"))),
    
    
    tabItem(tabName="chartepisode4",
            h1(id="dashboard","Charts Panel"),
            box("chart-1",status="warning",plotlyOutput("chart1"),width="600",height="500",background = "yellow")
    ),#end of charts sub menu
    
    
    tabItem(tabName="cepisode4",
            h1(id="dashboard","Characters' Panel"),
            box("Number of Characters",status="danger",verbatimTextOutput("characters"),
                h2("Character names"),br(),
                verbatimTextOutput("characterNames"),
                verbatimTextOutput("information"),background="yellow")
    )#end of charts sub menu
  )#end of the body of the application
)
))
#end of the user interface
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
