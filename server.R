#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
shinyServer(
  function(input,output,session){
   
    output$table1<-renderTable({head(members)})
    # Text transformations
    cleanCorpus <- function(corpus){
      
      corpus.tmp <- tm_map(corpus, removePunctuation)
      corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
      corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
      v_stopwords <- c(stopwords("english"), c("thats","weve","hes","theres","ive","im",
                                               "will","can","cant","dont","youve","us",
                                               "youre","youll","theyre","whats","didnt"))
      corpus.tmp <- tm_map(corpus.tmp, removeWords, v_stopwords)
      corpus.tmp <- tm_map(corpus.tmp, removeNumbers)
      return(corpus.tmp)
      
    }
    
    # Most frequent terms 
    frequentTerms <- function(text){
      
      s.cor <- Corpus(VectorSource(text))
      s.cor.cl <- cleanCorpus(s.cor)
      s.tdm <- TermDocumentMatrix(s.cor.cl)
      s.tdm <- removeSparseTerms(s.tdm, 0.999)
      m <- as.matrix(s.tdm)
      word_freqs <- sort(rowSums(m), decreasing=TRUE)
      dm <- data.frame(word=names(word_freqs), freq=word_freqs)
      return(dm)
      
    }
    
    # Define bigram tokenizer 
    tokenizer  <- function(x){
      
      NGramTokenizer(x, Weka_control(min=2, max=2))
      
    }
    
    # Most frequent bigrams 
    frequentBigrams <- function(text){
      
      s.cor <- VCorpus(VectorSource(text))
      s.cor.cl <- cleanCorpus(s.cor)
      s.tdm <- TermDocumentMatrix(s.cor.cl, control=list(tokenize=tokenizer))
      s.tdm <- removeSparseTerms(s.tdm, 0.999)
      m <- as.matrix(s.tdm)
      word_freqs <- sort(rowSums(m), decreasing=TRUE)
      dm <- data.frame(word=names(word_freqs), freq=word_freqs)
      return(dm)
      
    }
    colour1<-colorRampPalette(brewer.pal(9,"Oranges"))(20)
    colour2<-colorRampPalette(brewer.pal(9,"Greens"))(20)
    colour3<-colorRampPalette(brewer.pal(9,"YlOrRd"))(20)
    colour4<-colorRampPalette(brewer.pal(9,"RdYlBu"))(20)
    colour5<-colorRampPalette(brewer.pal(9,"RdBu"))(20)
    colour6<-colorRampPalette(brewer.pal(9,"Blues"))(20)
#:::::::::::::::::::::::::::::::::::::::::::::::END OF GLOBAL FUNCTIONS & OBJECTS::::::::::::::::::::::::::::::::::::::::::::
    
    # Top 20 characters with more dialogues 
    top.ep4.chars <- as.data.frame(sort(table(ep4$character), decreasing=TRUE))[1:20,]
    
    # Visualization 
    plot1<-ggplot(data=top.ep4.chars, aes(x=Var1, y=Freq)) +
      geom_bar(stat="identity", colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Character", y="Number of dialogues")
    output$chart1<-renderPlotly({ggplotly(plot1)})
    
    # Most frequent bigrams
    ep4.bigrams <- frequentBigrams(ep4$dialogue)[1:20,]
    plot2<-ggplot(data=ep4.bigrams, aes(x=reorder(word, -freq), y=freq)) +  
      geom_bar(stat="identity", fill=colour2, colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Bigram", y="Frequency")
    output$chart2<-renderPlotly({ggplotly(plot2)})
    # Wordcloud for Episode IV
    output$cloud01<-renderWordcloud2(wordcloud2(frequentTerms(ep4$dialogue), size=0.5,shape = "triangle"))
    
    ep4characters<-length(levels(ep6$character))
    ep4character<-levels(ep4$character)
    ep4dialogues<-length(ep4$dialogue)
    output$characterNames4_2<-renderText({ep4dialogues})
    output$characters4<-renderText({ep4characters})
    output$characterNames4<-renderText({ep4character})
    
    
#::::::::::::::::::::::::::::::::::::::::::::::::END OF EPISODE IV CONTENTS:::::::::::::::::::::::::::::::::::::::::::::::::
    
    length(ep5$dialogue)
    
    # How many characters?
    length(levels(ep5$character))
    
    # Top 20 characters with more dialogues 
    top.ep5.chars <- as.data.frame(sort(table(ep5$character), decreasing=TRUE))[1:20,]
    
    # Visualization 
    plot3<-ggplot(data=top.ep5.chars, aes(x=Var1, y=Freq)) +
      geom_bar(stat="identity", fill=colour3, colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Character", y="Number of dialogues")
    output$chart3<-renderPlotly({ggplotly(plot3)})
    
    # Most frequent bigrams
    ep5.bigrams <- frequentBigrams(ep5$dialogue)[1:20,]
    plot4<-ggplot(data=ep5.bigrams, aes(x=reorder(word, -freq), y=freq)) +  
      geom_bar(stat="identity", fill=colour4, colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Bigram", y="Frequency")
    output$chart4<-renderPlotly({ggplotly(plot4)})
    # Wordcloud for Episode V
    output$cloud02<-renderWordcloud2(wordcloud2(frequentTerms(ep5$dialogue), size=0.5,shape="diamond"))
    
    ep5characters<-length(levels(ep5$character))
    ep5character<-levels(ep5$character)
    output$characters5<-renderText({ep5characters})
    output$characterNames5<-renderText({ep5character})
    ep5dialogues<-length(ep5$dialogue)
    output$characterNames5_2<-renderText({ep5dialogues})
  
#::::::::::::::::::::::::::::::::::::::::::::::::END OF EPISODE V CONTENTS:::::::::::::::::::::::::::::::::::::::::::::::::
    
    # How many dialogues?
    length(ep6$dialogue)
    
    # How many characters?
    length(levels(ep6$character))
    
    # Top 20 characters with more dialogues
    top.ep6.chars <- as.data.frame(sort(table(ep6$character), decreasing=TRUE))[1:20,]
    
    # Visualization 
    plot5<-ggplot(data=top.ep6.chars, aes(x=Var1, y=Freq)) +
      geom_bar(stat="identity", fill=colour5, colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Character", y="Number of dialogues")
    output$chart5<-renderPlotly({ggplotly(plot5)})
    
    
    
    # Most frequent bigrams
    ep6.bigrams <- frequentBigrams(ep6$dialogue)[1:20,]
    plot6<-ggplot(data=ep6.bigrams, aes(x=reorder(word, -freq), y=freq)) +  
      geom_bar(stat="identity", fill=colour6, colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Bigram", y="Frequency")
    output$chart6<-renderPlotly({ggplotly(plot6)})
    # Wordcloud for Episode VI
    output$cloud03<-renderWordcloud2(wordcloud2(frequentTerms(ep6$dialogue), size=0.5,shape="circle"))
   
    
    ep6characters<-length(levels(ep6$character))
    ep6character<-levels(ep6$character)
    output$characters6<-renderText({ep6characters})
    output$characterNames6<-renderText({ep6character})
    ep6dialogues<-length(ep6$dialogue)
    output$characterNames6_2<-renderText({ep6dialogues})
    
#::::::::::::::::::::::::::::::::::::::::::::::::END OF EPISODE VI CONTENTS:::::::::::::::::::::::::::::::::::::::::::::::::
    
    # The Original Trilogy dialogues 
    trilogy <- rbind(ep4, ep5, ep6)
    
    tricharacters<-length(levels(trilogy$character))
    tricharacter<-levels(trilogy$character)
    output$characters7<-renderText({tricharacters})
    output$characterNames7<-renderText({tricharacter})
    tridialogues<-length(trilogy$dialogue)
    output$characterNames7_2<-renderText({tridialogues})
    
    # Top 20 characters with more dialogues 
    top.trilogy.chars <- as.data.frame(sort(table(trilogy$character), decreasing=TRUE))[1:20,]
    
    # Visualization 
    plot7<-ggplot(data=top.trilogy.chars, aes(x=Var1, y=Freq)) +
      geom_bar(stat="identity", fill="#56B4E9", colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Character", y="Number of dialogues")
    output$chart7<-renderPlotly({ggplotly(plot7)})
    # Wordcloud for The Original Trilogy
    output$cloud04<-renderWordcloud2(wordcloud2(frequentTerms(trilogy$dialogue), size=0.4))
    
    
    # Most frequent bigrams
    trilogy.bigrams <- frequentBigrams(trilogy$dialogue)[1:20,]
    plot8<-ggplot(data=trilogy.bigrams, aes(x=reorder(word, -freq), y=freq)) +  
      geom_bar(stat="identity", fill="chocolate2", colour="black") +
      theme(axis.text.x=element_text(angle=45, hjust=1)) +
      labs(x="Bigram", y="Frequency")
    output$chart8<-renderPlotly({ggplotly(plot8)})
    
    
    #SENTIMENT ANALYSIS
    # Transform the text to a tidy data structure with one token per row
    tokens <- trilogy %>%  
      mutate(dialogue=as.character(trilogy$dialogue)) %>%
      unnest_tokens(word, dialogue)
    
    # Positive and negative words
    output$chart15<-renderPlot({tokens %>%
        inner_join(get_sentiments("bing")) %>%
        count(word, sentiment, sort=TRUE) %>%
        acast(word ~ sentiment, value.var="n", fill=0) %>%
        comparison.cloud(colors=c("#ec125c", "#029a55"), max.words=100000)})
    
    # Sentiments and frequency associated with each word  
    sentiments <- tokens %>% 
      inner_join(get_sentiments("nrc")) %>%
      count(word, sentiment, sort=TRUE) 
    
    # Frequency of each sentiment
    plot9<-ggplot(data=sentiments, aes(x=reorder(sentiment, -n, sum), y=n)) + 
      geom_bar(stat="identity", aes(fill=sentiment), show.legend=FALSE) +
      labs(x="Sentiment", y="Frequency")
    output$chart9<-renderPlotly({ggplotly(plot9)})
    
    # Top 10 terms for each sentiment
    p10<-sentiments %>%
      group_by(sentiment) %>%
      arrange(desc(n)) %>%
      slice(1:10) 
    
  output$chart10<-renderPlot({ggplot(p10,aes(x=reorder(word, n), y=n)) +
      geom_col(aes(fill=sentiment), show.legend=FALSE) +
      facet_wrap(~sentiment, scales="free_y") +
      labs(y="Frequency", x="Terms") +
      coord_flip()})
  
  # Stopwords
  mystopwords <- data_frame(word=c(stopwords("english"), 
                                   c("thats","weve","hes","theres","ive","im",
                                     "will","can","cant","dont","youve","us",
                                     "youre","youll","theyre","whats","didnt")))
  
  # Tokens without stopwords
  top.chars.tokens <- trilogy %>%
    mutate(dialogue=as.character(trilogy$dialogue)) %>%
    filter(character %in% c("LUKE","HAN","THREEPIO","LEIA","VADER",
                            "BEN","LANDO","YODA","EMPEROR","RED LEADER")) %>%
    unnest_tokens(word, dialogue) %>%
    anti_join(mystopwords, by="word")
  
  # Most frequent words for each character
  p11<-top.chars.tokens %>%
    count(character, word) %>%
    group_by(character) %>% 
    arrange(desc(n)) %>%
    slice(1:10) %>%
    ungroup() %>%
    mutate(word2=factor(paste(word, character, sep="__"), 
                        levels=rev(paste(word, character, sep="__"))))
  output$chart11<-renderPlot(ggplot(p11,aes(x=word2, y=n)) +
                               geom_col(aes(fill=character), show.legend=FALSE) +
                               facet_wrap(~character, scales="free_y") +
                               labs(x="Sentiment", y="Frequency") +
                               scale_x_discrete(labels=function(x) gsub("__.+$", "", x)) +
                               coord_flip())
    
  
  #7.2 Analysis by character
  # Sentiment analysis for the Top 10 characters with more dialogues
  p12<-tokens %>%
    filter(character %in% c("LUKE","HAN","THREEPIO","LEIA","VADER",
                            "BEN","LANDO","YODA","EMPEROR","RED LEADER")) %>%
    inner_join(get_sentiments("nrc")) %>%
    count(character, sentiment, sort=TRUE)
    output$chart12<-renderPlot(ggplot(p12,aes(x=sentiment, y=n)) +
                                 geom_col(aes(fill=sentiment), show.legend=FALSE) +
                                 facet_wrap(~character, scales="free_x") +
                                 labs(x="Sentiment", y="Frequency") +
                                 coord_flip())
    
    # Most relevant words for each character
    p13<-top.chars.tokens %>%
      count(character, word) %>%
      bind_tf_idf(word, character, n) %>%
      group_by(character) %>% 
      arrange(desc(tf_idf)) %>%
      slice(1:10) %>%
      ungroup() %>%
      mutate(word2=factor(paste(word, character, sep="__"), 
                          levels=rev(paste(word, character, sep="__"))))
      output$chart13<-renderPlot(ggplot(p13,aes(x=word2, y=tf_idf)) +
                                   geom_col(aes(fill=character), show.legend=FALSE) +
                                   facet_wrap(~character, scales="free_y") +
                                   theme(axis.text.x=element_text(angle=45, hjust=1)) +
                                   labs(y="tf-idf", x="Sentiment") +
                                   scale_x_discrete(labels=function(x) gsub("__.+$", "", x)) +
                                   coord_flip())
      
  #::::::::::::::::::::::::::::::::::::::::::::::::END OF TRIOLOGY CONTENTS:::::::::::::::::::::::::::::::::::::::::::::::::
  }
)
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::