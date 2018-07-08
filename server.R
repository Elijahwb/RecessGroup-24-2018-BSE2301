library(shiny)
library(shinydashboard)

shinyServer(
  function(input,output){
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
    output$first <-renderText(
      {paste("is this working??")}
      )
  }
)
