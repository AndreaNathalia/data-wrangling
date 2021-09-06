library(tidyverse)
library(highcharter)
library(readr)

df <- read_delim("2010-2019-top.csv", delim = ";", escape_double = TRUE, trim_ws = TRUE)

#ver dataset
View(df)

# base r
glimpse(df)

# renombrar columnas con base r
names(df)[4] <- "top-genre"
names(df)

# renombrar columnas con dplyr
rename(df, top_genre = `top-genre`)

# anidando
head(select(df, aritst, year))

# pipe operator
df %>%
  select(aritst, year) %>%
  head()

# renombrar columnas con dplyr y pipe operator
de %>%
  rename(df, top_genre = `top-genre`)

df %>%
  select(1, 2) %>%
  head() %>%
  View()


# todas las columnas del dataset menos 1
head(df[-1])

#usando dplyr
df %>%
  select(-X1)%>%
  head()

# ver todas excepto una 
head(df[-1])
# deplyr
df %>%
  select(-1) %>% # puede ser -numero o -nombre
  head()

# volver columnas de texto a factores 
df <- mutate_if(df, is.character, as.factor)
glimpse(df)

# filter
df %>% 
  select(artist,title,year) %>%
  filter(year == 2010) %>%
  head() %>%
  View()

# cuantos artistas unicos hay por año ---- group_by
df_agg <- df %>%
  select(year,artist) %>%
  group_by(year) %>%
  summarise(artistas_unicos = n_distinct(artist))

# canciones unicas que tenemos en el dataset completo
df %>%
  summarise(artistas_unicos = n_distinct(artist))

sum(df_agg$artistas_unicos)

# Cuantas canciones aparecen más de una vez
df %>% 
  group_by(title) %>% 
  summarise(canciones_repetidas=n()) %>% 
  filter(canciones_repetidas > 1)

#conteo
df %>%
  group_by(title)%>%
  summarise(freq = n())%>%
  group_by(freq)%>%
  summarise(n())


#cuantas canciones se llaman igual pero son de diferente artista
df %>%
  group_by(artist,title) %>%
  summarise(canciones = ifelse(n()>1,n(),NA)) %>%
  na.omit()


# que canciones de que artistas aparecen más de un año
df %>%
  select(title,artist, year) %>%
  group_by(artist, title) %>%
  summarise(artistas_repetidos = n_distinct(year))%>% 
  filter(artistas_repetidos > 1)


#que artistas han tenido más de una cancion que fue popular en más de un año
df %>%
  select(title,artist, year) %>%
  group_by(artist, title) %>%
  summarise(artistas_repetidos = n_distinct(year))%>% 
  filter(artistas_repetidos > 1) %>%
  group_by(artist)%>%
  summarise(artistas_popular=n())%>%
  filter(artistas_popular>1)


## highcharter
df<-mutate_if(df,is.character, as.factor)
df$title <- iconv(df$title, to = "UTF-8")
df$artist <- iconv(df$artist, to = "UTF-8")


# cuantos artistas distintos tenemos por año
df %>%
  select(artist, year) %>%
  group_by(year)%>%
  summarise(n = n_distinct(artist))%>%
  hchart("column", hcaes(x = year, y = n))%>%
  hc_title(text="Artistas distintos por año")%>%
  hc_subtitle(text= "<i>2019 tuvo la menor variedad, mientras 2015 ha sido el año con 
              más diversidad de artistas<i>")
  


  




