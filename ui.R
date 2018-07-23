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
                 taskItem(value = 80, color = "yellow", "Project deployment"),
                 taskItem(value = 75, color = "red","Overall project")
                )#end of tasks drop down
  ),#***********************************************end of Notifications******************************************************
  dashboardSidebar(width=350,
    sidebarMenu(
      menuItem("Home",tabName ="myDashboard",icon=icon("th")),
      menuItem("Word Clouds",tabName ="wordclouds",icon=icon("cloud")),
      menuItem("Sentiment Analysis",tabName ="sentiments",icon=icon("comment"),
               menuSubItem("Sentiment",tabName = "sentiTrend"),
               menuSubItem("Top Sentiment Terms",tabName = "sentiterms"),
               menuSubItem("Frequent words for each character",tabName = "frequent"),
               menuSubItem("Top 10 cahracters",tabName = "top10"),
               menuSubItem("Most relevant words",tabName = "relevant"),
               menuSubItem("Negative/Positive words",tabName = "negativePositive")),
      menuItem("Dialogue Charts",tabName ="charts",icon=icon("bar-chart-o"),
               menuSubItem("Episode IV",tabName = "chartepisode4"),
               menuSubItem("Episode V",tabName = "chartepisode5"),
               menuSubItem("Episode VI",tabName = "chartepisode6"),
               menuSubItem("All the three episodes",tabName = "trilogychart")),
      menuItem("Characters in the movie",tabName ="characters",icon=icon("users"),
               menuSubItem("Episode IV",tabName = "cepisode4"),
               menuSubItem("Episode V",tabName = "cepisode5"),
               menuSubItem("Episode VI",tabName = "cepisode6"),
               menuSubItem("Episodes IV,V & VI",tabName = "trilogy")),
      img(id="logo",src="logo6.png")
    )#***********************************************end of sidebar menu******************************************************
  ),
  #begining of the body of the application
  dashboardBody(
    #******************************************beginning of the styles sheet**************************************************
    tags$head(tags$style(
                HTML('
                     #logo{margin-left:80px;position:fixed;margin-top:170px;}
                      #logo2{margin-left:340px;top:-105px;position:relative;}
                      #logo:hover{transform:scale(1.03);}
                      #header1{margin-left:230px;color:#343031;margin-top:-70px;position:relative;}
                      #header2{margin-left:330px;color:#00a65a;margin-top:-50px;position:relative;}
                      #header3{margin-left:330px;color:#2c88bd;margin-top:-50px;position:relative;}
                      #header4{margin-left:330px;color:#2c88bd;margin-top:-50px;position:relative;}
                      #header5{margin-left:330px;color:#00a65a;margin-top:50px;position:relative;}
                      #line{color:black;width:600px;}
                      tr{padding:50px;}
                    #black-box{margin-left:220px;width:1200px;margin-top:-10px;position:relative;}
                     #cloud-output{border-radius:5px;}
                     #gpIcon{margin-left:900px;margin-top:-42px;}
                     #center{margin-left:260px;position:relative;width:100%;}
                     #centerbig{margin-left:60px;position:relative;width:180%;}')),
    #************************************************end of the styles sheet**************************************************
              tags$script(src="projectjs1.js")),
    tags$img(id="gpIcon",src="logo2-6.png"),
    tabItems(
      tabItem(tabName="myDashboard",
              img(" ",src="starwars3.png",id="logo2"),
              h1(id="header1","Welcome to ",strong("Recess-Group-24")," project"),
              tags$div(id="black-box",box(title="Group-24 Software Engineer Members!",height=250,status="warning",
                  tableOutput("table1"))),
              verbatimTextOutput(outputId = "first")
    ),#*****************************************end of homepage for the dashboard*********************************************
    
    
    tabItem(tabName="negativePositive",
            h1(id="header2","Sentiment Panel"),
            box("chart-2",status="warning",plotOutput("chart15"),width="600",height="500",background = "yellow")
    ),
    tabItem(tabName="sentiTrend",
            h1(id="header2","Sentiment Panel"),
            box("chart-2",status="warning",plotlyOutput("chart9"),width="600",height="500",background = "yellow")
    ),
    tabItem(tabName="sentiterms",
            h1(id="header2","Sentiment Panel"),
            box("chart-2",status="warning",plotOutput("chart10"),width="600",height="500",background = "yellow")
    ),
    tabItem(tabName="frequent",
            h1(id="header2","Sentiment Panel"),
            box("chart-2",status="warning",plotOutput("chart11"),width="600",height="500",background = "yellow")
    ),
    tabItem(tabName="top10",
            h1(id="header2","Sentiment Panel"),
            box("chart-2",status="warning",plotOutput("chart12"),width="600",height="500",background = "yellow")
    ),
    tabItem(tabName="relevant",
            h1(id="header2","Sentiment Panel"),
            box("chart-2",status="warning",plotOutput("chart13"),width="600",height="500",background = "yellow")
    ),
    tabItem(tabName="summary",
            h1(id="header2","Sentiment Panel"),
            box("chart-2",status="warning",plotOutput("chart14"),width="600",height="500",background = "yellow")
    ),
    #*****************************************end of sentiment tabsets information******************************************
    
    
    tabItem(tabName="wordclouds",icon=icon("cloud"),
            h1(id="header3","Wordcloud Panel"),
            tabBox(id="tab2",title="Frequency of words",width = "600",
                   tabPanel("Episode IV",height="200px",
                            tags$div(id="cloud-output",
                                     box(h2("Frequency of occurring words in Episode IV"),status="warning",
                                         wordcloud2Output(outputId="cloud01"),width=300)
                   ),br(),br()),
                   tabPanel("Episode V",height="200px",
                            tags$div(id="cloud-output",
                                     box(h2("Frequency of occurring words in Episode V"),status="warning",
                                         wordcloud2Output(outputId="cloud02"),width=300)
                            )),
                   tabPanel("Episode VI",height="200px",
                            tags$div(id="cloud-output",
                                     box(h2("Frequency of occurring words in Episode VI"),status="warning",
                                         wordcloud2Output(outputId="cloud03"),width=300)
                            )),
                   tabPanel("Episodes V,IV & VI",height="200px",
                            tags$div(id="cloud-output",
                                     box(h2("Frequency of occurring words in all the episodes"),status="warning",
                                         wordcloud2Output(outputId="cloud04"),width=300)
                            ))),br(),br(),br(),br()),
    #******************************************end of word clouds sub-items***************************************************
    
    tabItem(tabName="chartepisode4",
            h1(id="header4","Charts Panel"),
            tabBox(id="tab2",title="Frequency of words",width = "600",
                   tabPanel("Dialogues",height="200px",
                            tags$div(id="cloud-output",
                                     box("chart-1",status="warning",plotlyOutput("chart1"),width="600",height="500",background = "yellow")
                            ),br(),br()),
                   tabPanel("Bigrams",height="200px",
                            tags$div(id="cloud-output",
                                     box("chart-2",status="warning",plotlyOutput("chart2"),width="600",height="500",background = "yellow")
                            )))
    ),tabItem(tabName="chartepisode5",
              h1(id="header4","Charts Panel"),
              tabBox(id="tab2",title="Frequency of words",width = "600",
                     tabPanel("Dialogues",height="200px",
                              tags$div(id="cloud-output",
                                       box("chart-3",status="warning",plotlyOutput("chart3"),width="600",height="500",background = "yellow")
                              ),br(),br()),
                     tabPanel("Bigrams",height="200px",
                              tags$div(id="cloud-output",
                                       box("chart-4",status="warning",plotlyOutput("chart4"),width="600",height="500",background = "yellow")
                              )))
    ),tabItem(tabName="chartepisode6",
              h1(id="header4","Charts Panel"),
              tabBox(id="tab2",title="Frequency of words",width = "600",
                     tabPanel("Dialogues",height="200px",
                              tags$div(id="cloud-output",
                                       box("chart-5",status="warning",plotlyOutput("chart5"),width="600",height="500",background = "yellow")
                              ),br(),br()),
                     tabPanel("Bigrams",height="200px",
                              tags$div(id="cloud-output",
                                       box("chart-6",status="warning",plotlyOutput("chart6"),width="600",height="500",background = "yellow")
                              )))
    ),
    tabItem(tabName="trilogychart",
            h1(id="header4","Charts Panel"),
            tabBox(id="tab2",title="Frequency of words",width = "600",
                   tabPanel("Dialogues",height="200px",
                            tags$div(id="cloud-output",
                                     box("chart-5",status="warning",plotlyOutput("chart7"),width="600",height="500",background = "yellow")
                            ),br(),br()),
                   tabPanel("Bigrams",height="200px",
                            tags$div(id="cloud-output",
                                     box("chart-6",status="warning",plotlyOutput("chart8"),width="600",height="500",background = "yellow")
                            )))
    ),
    #*************************************end of dialogue charts sub-items**************************************************
    
    
    tabItem(tabName="cepisode4",
            h1(id="header5","Characters' Panel"),
            tags$div(id="center",box("Number of Characters in Episode IV",status="danger",
                verbatimTextOutput("characters4"),
                h5("Number of dialogues"),br(),
                verbatimTextOutput("characterNames4_2"),
                h4("Character names"),br(),
                verbatimTextOutput("characterNames4"),
                verbatimTextOutput("information4"),background="yellow"))
    ),
    tabItem(tabName="cepisode5",
            h1(id="header5","Characters' Panel"),
            tags$div(id="center",box("Number of Characters in Episode V",status="danger",
                verbatimTextOutput("characters5"),
                h5("Number of dialogues"),br(),
                verbatimTextOutput("characterNames5_2"),
                h4("Character names"),br(),
                verbatimTextOutput("characterNames5"),
                verbatimTextOutput("information5"),background="yellow"))
    ),
    tabItem(tabName="cepisode6",
            h1(id="header5","Characters' Panel"),
            tags$div(id="center",box("Number of Characters in Episode VI",status="danger",
                verbatimTextOutput("characters6"),
                h5("Number of dialogues"),br(),
                verbatimTextOutput("characterNames6_2"),
                h4("Character names"),br(),
                verbatimTextOutput("characterNames6"),
                verbatimTextOutput("information6"),background="yellow"))
    ),
    tabItem(tabName="trilogy",
            h1(id="header5","Characters' Panel"),
            tags$div(id="centerbig",box("Number of Characters in all the three episodes",status="danger",
                                     verbatimTextOutput("characters7"),
                                     h5("Number of dialogues"),br(),
                                     verbatimTextOutput("characterNames7_2"),
                                     h4("Character names"),br(),
                                     verbatimTextOutput("characterNames7"),
                                     verbatimTextOutput("information7"),background="yellow"))
    )
    #*******************************************end of characters sub-items**************************************************
  )#***************************************************end of tab items*******************************************************
)#*************************************************end of dashboard body******************************************************
))
#end of the user interface
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
