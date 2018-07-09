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
  ),#***********************************************end of Notifications******************************************************
  dashboardSidebar(width=350,
    sidebarMenu(
      menuItem("Home",tabName ="myDashboard",icon=icon("th")),
      menuItem("Word Clouds",tabName ="wordclouds",icon=icon("cloud")),
      menuItem("Sentiment Analysis",tabName ="sentiments",icon=icon("comment")),
      menuItem("Dialogue Charts",tabName ="charts",icon=icon("bar-chart-o"),
               menuSubItem("Episode IV",tabName = "chartepisode4"),
               menuSubItem("Episode V",tabName = "chartepisode5"),
               menuSubItem("Episode VI",tabName = "chartepisode6")),
      menuItem("Characters in the movie",tabName ="characters",icon=icon("users"),
               menuSubItem("Episode IV",tabName = "cepisode4"),
               menuSubItem("Episode V",tabName = "cepisode5"),
               menuSubItem("Episode VI",tabName = "cepisode6")),
      img(id="logo",src="logo2.png")
    )#***********************************************end of sidebar menu******************************************************
  ),
  #begining of the body of the application
  dashboardBody(
    #******************************************beginning of the styles sheet**************************************************
    tags$head(tags$style(
                HTML('
                     #logo{margin-left:100px;position:fixed;margin-top:260px;}
                      #logo2{margin-left:340px;top:-20px;position:relative;}
                      #logo:hover{transform:scale(1.03);}
                      #dashboard{margin-left:230px;color:#343031}
                      #line{color:black;width:600px;}
                      tr{padding:50px;}
                    #black-box{margin-left:220px;width:1200px;}
                     cloud-output{border-radius:5px;}')),
    #************************************************end of the styles sheet**************************************************
              tags$script(src="projectjs1.js")),
    tabItems(
      tabItem(tabName="myDashboard",
              img(" ",src="starwars3.png",id="logo2"),
              h1(id="dashboard","Welcome to ",strong("Recess-Group-24")," project"),
              tags$div(id="black-box",box(title="Group-24 Software Engineer Members!",height=250,status="warning",
                  tableOutput("table1"))),
              verbatimTextOutput(outputId = "first")
    ),#*****************************************end of homepage for the dashboard*********************************************
    
    
    tabItem(tabName="sentiments",
            h1(id="dashboard","Sentiment Panel"),
            tabBox(id="tab1",title="Negative/Positive",width = "600",
                   tabPanel("Episode IV",plotOutput("sentiment1")),
                   tabPanel("Episode V"),
                   tabPanel("Episode VI"))
    ),#*****************************************end of sentiment tabsets information******************************************
    
    
    tabItem(tabName="wordclouds",icon=icon("cloud"),
            h1(id="dashboard","Wordcloud Panel"),
            tabBox(id="tab2",title="Frequency of words",width = "600",
                   tabPanel("Episode IV",height="200px",
                            tags$div(id="cloud-output",
                                     box(h2("Most occurring words in Episode IV"),status="warning",
                                         wordcloud2Output(outputId="cloud1"),width=300)
                   ),tags$div(id="cloud-output",
                              box(h2("Least occurring words in Episode IV"),status="warning",
                                  wordcloud2Output(outputId="cloud1-1"),width=300)
                   ),br(),br()),
                   tabPanel("Episode V",height="200px",
                            tags$div(id="cloud-output",
                                     box(h2("Most occurring words in Episode V"),status="warning",
                                         wordcloud2Output(outputId="cloud2"),width=300)
                            ),tags$div(id="cloud-output",
                                       box(h2("Least occurring words in Episode V"),status="warning",
                                           wordcloud2Output(outputId="cloud2-2"),width=300)
                            )),
                   tabPanel("Episode VI",height="200px",
                            tags$div(id="cloud-output",
                                     box(h2("Most occurring words in Episode VI"),status="warning",
                                         wordcloud2Output(outputId="cloud3"),width=300)
                            ),tags$div(id="cloud-output",
                                       box(h2("Least occurring words in Episode VI"),status="warning",
                                           wordcloud2Output(outputId="cloud3-2"),width=300)
                            ))),br(),br(),br(),br()),
    #******************************************end of word clouds sub-items***************************************************
    
    tabItem(tabName="chartepisode4",
            h1(id="dashboard","Charts Panel"),
            box("chart-1",status="warning",plotlyOutput("chart1"),width="600",height="500",background = "yellow")
    ),tabItem(tabName="chartepisode5",
              h1(id="dashboard","Charts Panel"),
              box("chart-1",status="warning",plotlyOutput("chart2"),width="600",height="500",background = "yellow")
    ),tabItem(tabName="chartepisode6",
              h1(id="dashboard","Charts Panel"),
              box("chart-1",status="warning",plotlyOutput("chart3"),width="600",height="500",background = "yellow")
    ),#*************************************end of dialogue charts sub-items**************************************************
    
    
    tabItem(tabName="cepisode4",
            h1(id="dashboard","Characters' Panel"),
            box("Number of Characters",status="danger",verbatimTextOutput("characters4"),
                h2("Character names"),br(),
                verbatimTextOutput("characterNames4"),
                verbatimTextOutput("information4"),background="yellow")
    ),
    tabItem(tabName="cepisode5",
            h1(id="dashboard","Characters' Panel"),
            box("Number of Characters",status="danger",verbatimTextOutput("characters5"),
                h2("Character names"),br(),
                verbatimTextOutput("characterNames5"),
                verbatimTextOutput("information5"),background="yellow")
    ),
    tabItem(tabName="cepisode6",
            h1(id="dashboard","Characters' Panel"),
            box("Number of Characters",status="danger",verbatimTextOutput("characters6"),
                h2("Character names"),br(),
                verbatimTextOutput("characterNames6"),
                verbatimTextOutput("information6"),background="yellow")
    )#*******************************************end of characters sub-items**************************************************
  )#***************************************************end of tab items*******************************************************
)#*************************************************end of dashboard body******************************************************
))
#end of the user interface
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
