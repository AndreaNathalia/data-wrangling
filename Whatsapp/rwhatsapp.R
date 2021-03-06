library(lubridate)
library(rwhatsapp)
library(tidytext)
library(tidyverse)
library(tidyr)
library(ggimage)
library(stopwords)
library(ggplot2)
library(igraph)
library(ggraph)
chat <- rwa_read("_chat.txt")
View(chat)
url_regex <- '(http|https)[^([:blank:]|\\"|<|&|#\n\r)]+'

emoji_data <- rwhatsapp::emojis %>% # data built into package
  mutate(hex_runes1 = gsub("\\s[[:alnum:]]+", "", hex_runes)) %>% # ignore combined emojis
  mutate(emoji_url = paste0("https://abs.twimg.com/emoji/v2/72x72/", 
                            tolower(hex_runes1), ".png"))

##############Emojis###############

chat %>%
  unnest(emoji) %>%
  count(author, emoji, sort = TRUE) %>%
  group_by(author) %>%
  top_n(n = 6, n) %>%
  left_join(emoji_data, by = "emoji") %>% 
  ggplot(aes(x = reorder(emoji, n), y = n, fill = author)) +
  geom_col(show.legend = FALSE) +
  ylab("") +
  xlab("") +
  coord_flip() +
  geom_image(aes(y = n + 20, image = emoji_url)) +
  facet_wrap(~author, ncol = 2, scales = "free_y") +
  ggtitle("Emojis utilizados") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

######remove stopwords##########
to_remove <- c(stopwords(language = "en"),
               stopwords(language = "es"),
               c(1:1000),
               c("imagen","sticker","image","omitida","omitted","jajaja","jajajaja"),
               url_regex)



#### palabras sin stopwords
chat %>%
  unnest_tokens(input = text,
                output = word) %>%
  filter(!word %in% to_remove) %>%
  count(author, word, sort = TRUE) %>%
  group_by(author) %>%
  top_n(n = 6, n) %>%
  ggplot(aes(x = reorder_within(word, n, author), y = n, fill = author)) +
  geom_col(show.legend = FALSE) +
  ylab("") +
  xlab("") +
  coord_flip() +
  facet_wrap(~author, ncol = 2, scales = "free_y") +
  scale_x_reordered() +
  ggtitle("Most often used words without stopwords")

#####palabras por dia
chat %>%
  mutate(day = date(time)) %>%
  count(day) %>%
  ggplot(aes(x = day, y = n)) +
  geom_bar(stat = "identity") +
  ylab("") + xlab("") +
  ggtitle("Mensajes por día")

#####numero de mensajes
chat %>%
  mutate(day = date(time)) %>%
  count(author) %>%
  ggplot(aes(x = reorder(author, n), y = n)) +
  geom_bar(stat = "identity") +
  ylab("") + xlab("") +
  coord_flip() +
  ggtitle("Cantidad de mensajes")

######tf-idf
chat %>%
  unnest_tokens(input = text,
                output = word) %>%
  select(word, author) %>%
  filter(!word %in% to_remove) %>%
  mutate(word = gsub(".com", "", word)) %>%
  mutate(word = gsub("^gag", "9gag", word)) %>%
  count(author, word, sort = TRUE) %>%
  bind_tf_idf(term = word, document = author, n = n) %>%
  filter(n > 10) %>%
  group_by(author) %>%
  top_n(n = 6, tf_idf) %>%
  ggplot(aes(x = reorder_within(word, n, author), y = n, fill = author)) +
  geom_col(show.legend = FALSE) +
  ylab("") +
  xlab("") +
  coord_flip() +
  facet_wrap(~author, ncol = 2, scales = "free_y") +
  scale_x_reordered() +
  ggtitle("Important words using tf–idf by author")


#######Palabras mas frecuentes######
chat %>%
  unnest_tokens(input = text,
                output = word) %>%
  select(word, author) %>%
  filter(!word %in% to_remove) %>%
  mutate(word = gsub(".com", "", word)) %>%
  mutate(word = gsub("^gag", "9gag", word)) %>%
  count(author, word, sort = TRUE) %>%
  bind_tf_idf(term = word, document = author, n = n) %>%
  filter(n > 10) %>%
  group_by(author) %>%
  top_n(n = 6, tf_idf) %>%
  ggplot(aes(x = reorder_within(word, n, author), y = n, fill = author)) +
  geom_col(show.legend = FALSE) +
  ylab("") +
  xlab("") +
  coord_flip() +
  facet_wrap(~author, ncol = 2, scales = "free_y") +
  scale_x_reordered() +
  ggtitle("Important words using tf–idf by author")

#######Diversidad lexica###########
chat %>%
  unnest_tokens(input = text,
                output = word) %>%
  filter(!word %in% to_remove) %>%
  group_by(author) %>%
  summarise(lex_diversity = n_distinct(word)) %>%
  arrange(desc(lex_diversity)) %>%
  ggplot(aes(x = reorder(author, lex_diversity),
             y = lex_diversity,
             fill = author)) +
  geom_col(show.legend = FALSE) +
  scale_y_continuous(expand = (mult = c(0, 0, 0, 500))) +
  geom_text(aes(label = scales::comma(lex_diversity)), hjust = -0.1) +
  ylab("Palabras unicas") +
  xlab("") +
  ggtitle("Diversidad de palabras") +
  coord_flip()


#######Palabras unicas por usuario#######

o_words <- chat %>%
  unnest_tokens(input = text,
                output = word) %>%
  filter(author != unique(chat$author)[2]) %>% 
  count(word, sort = TRUE) 


#o_words %>% View()

chat %>%
  unnest_tokens(input = text,
                output = word) %>%
  filter(author == unique(chat$author)[2]) %>% 
  filter(!word %in% to_remove) %>% 
  count(word, sort = TRUE) %>% 
  filter(!word %in% o_words$word) %>% # only select words nobody else uses
  top_n(n = 6, n) %>%
  ggplot(aes(x = reorder(word, n), y = n)) +
  geom_col(show.legend = FALSE) +
  ylab("") + xlab("") +
  coord_flip() +
  ggtitle(paste("Unique words of", unique(chat$author)[2]))


######mensajes por dia filtrando######
library("ggplot2"); theme_set(theme_minimal())
library("lubridate")

chat  %>% 
  mutate(day  = date(time)) %>% 
  filter(str_detect(chat$text,"vos")) %>% 
  group_by(author) %>% 
  count(day) %>%  
  ggplot(aes(x = day, y = n, color = author)) +
  geom_line(stat = "identity") +
  ylab("") + xlab("") +
  ggtitle("Frecuencia de mensajes  por dia")


#####bigramas#####

paired_words <- chat %>% 
  filter(author==unique(chat$author)[2]) %>% 
  select(text) %>% 
  unnest_tokens(paired_words,text, token = "ngrams", n =2)


paired_separated_words <- paired_words %>%
  separate(paired_words, c("word1", "word2"), sep = " ")

paired_separated_words_filtered <- paired_separated_words %>%
  filter(!word1 %in% to_remove) %>%
  filter(!word2 %in% to_remove)

# new bigram counts:
paired_words_counts <- paired_separated_words_filtered %>%
  count(word1, word2, sort = TRUE)

View(paired_words_counts)



paired_words_counts %>%  filter(n >= 50) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
  geom_node_point(color = "darkslategray4", size = 3) +
  geom_node_text(aes(label = name), vjust = 1.8, size = 3) +
  labs(title = "Word Network",
       subtitle = "Whatsapp Chats ",
       x = "", y = "")

#### mensajes por hora y frecuencia de dia
diasemana <- c("domingo","lunes","martes","miércoles","jueves","viernes","sábado","domingo")
names(diasemana) <- 1:7# MENSAJES POR HORA DEL DÍA
chat %>% 
  mutate( day = date(time), 
          wday.num = wday(day),
          wday.name = weekdays(day),
          hour = hour(time)) %>% 
  count(wday.num, wday.name,hour) %>% 
  ggplot(aes(x = hour, y = n)) +
  geom_bar(stat = "identity") +
  ylab("Número de mensajes") + xlab("Horario") +
  ggtitle("Número de mensajes por hora del día") +
  facet_wrap(~wday.num, ncol=7, labeller = labeller(wday.num=diasemana))+
  theme_minimal() +
  theme( legend.title = element_blank(), 
         legend.position = "bottom",
         panel.spacing.x=unit(0.0, "lines"))

