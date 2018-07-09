#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
shinyServer(
  function(input,output,session){
   
    output$table1<-renderTable({head(members)})
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
    output$cloud1<-renderWordcloud2(wordcloud2(df,color="random-dark",shape ="circle", minSize = 0, gridSize = 0,
                                              fontFamily = 'Segoe UI' ))
    
    #converting columns to character
    ep4$character <- as.character(ep4$character)
    ep4$dialogue <- as.character(ep4$dialogue)
    
    p<-ep4%>%
      group_by(character)%>%
      count()%>%
      ungroup()%>%
      arrange(desc(n))%>%
      top_n(15,n)
    plot<-ggplot(p,aes(reorder(character,n),n,fill=character))+
      geom_col(show.legend = F)+
      #coord_flip()+
      labs(x="Character Name" , y="Number of dialogues" , title ="Number of dialogues for each character in Episode 4")

    output$chart1<-renderPlotly({ggplotly(plot)})
    
    ep4characters<-length(unique(ep4$character))
    ep4character<-unique(ep4$character)
    output$characters4<-renderText({ep4characters})
    output$characterNames4<-renderText({ep4character})
    
#::::::::::::::::::::::::::::::::::::::::::::::::END OF EPISODE IV CONTENTS:::::::::::::::::::::::::::::::::::::::::::::::::
    
    df_ep5<-createterms(ep5$dialogue)
    output$cloud2<-renderWordcloud2(wordcloud2(df_ep5,color="random-dark",shape ="circle", minSize = 0, gridSize = 0,
                                               fontFamily = 'Segoe UI' ))
    
    #converting columns to character
    ep5$character <- as.character(ep5$character)
    ep5$dialogue <- as.character(ep5$dialogue)
    
    p1<-ep5%>%
      group_by(character)%>%
      count()%>%
      ungroup()%>%
      arrange(desc(n))%>%
      top_n(20,n)
    plot1<-ggplot(p1,aes(reorder(character,n),n,fill=character))+
      geom_col(show.legend = F)+
      #coord_flip()+
      labs(x="Character Name" , y="Number of dialogues" , title ="Number of dialogues for each character in Episode 5")

    output$chart2<-renderPlotly({ggplotly(plot1)})
    
    ep5characters<-length(unique(ep5$character))
    ep5character<-unique(ep5$character)
    output$characters5<-renderText({ep5characters})
    output$characterNames5<-renderText({ep5character})
  
#::::::::::::::::::::::::::::::::::::::::::::::::END OF EPISODE V CONTENTS:::::::::::::::::::::::::::::::::::::::::::::::::
    df_ep6<-createterms(ep6$dialogue)
    output$cloud3<-renderWordcloud2(wordcloud2(df_ep6,color="random-dark",shape ="circle", minSize = 0, gridSize = 0,
                                               fontFamily = 'Segoe UI' ))
    
    #converting columns to character
    ep6$character <- as.character(ep6$character)
    ep6$dialogue <- as.character(ep6$dialogue)
    
    p2<-ep6%>%
      group_by(character)%>%
      count()%>%
      ungroup()%>%
      arrange(desc(n))%>%
      top_n(20,n)
    plot2<-ggplot(p2,aes(reorder(character,n),n,fill=character))+
      geom_col(show.legend = F)+
      #coord_flip()+
      labs(x="Character Name" , y="Number of dialogues" , title ="Number of dialogues for each character in Episode 6")
    
    output$chart3<-renderPlotly({ggplotly(plot2)})
    
    ep6characters<-length(unique(ep6$character))
    ep6character<-unique(ep6$character)
    output$characters6<-renderText({ep6characters})
    output$characterNames6<-renderText({ep6character})
    
#::::::::::::::::::::::::::::::::::::::::::::::::END OF EPISODE VI CONTENTS:::::::::::::::::::::::::::::::::::::::::::::::::
  }
)
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::