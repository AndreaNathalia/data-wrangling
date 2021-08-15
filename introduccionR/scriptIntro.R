##Instalar librerias
install.packages("dplyr")
install.packages("RMySQL")
install.packages("lubridate")
install.packages("openxlsx")
install.packages("tidyverse")
install.packages("stringr")
install.packages("readr")

#Cargar librerias
library(dplyr)

#Folder / location
getwd()

# Data types and structures

#Strings:
string <- "This is a string"
class(string)
typeof(string)
length(string) #elementos
nchar(string) #caracteres

#double
number <- 2344
class(number)
typeof(number)
length(number)

#integer
integer <- 3L #se agrega la L para declarar que es int
class(integer)
typeof(integer)

#Logical
logical <- FALSE #F=0 - T=1
class(logical)
typeof(logical)


#Vectores (coleccion de elementos de un mismo tipo de dato; es dinamico)
vector <- c("string", "this", "is")
length(vector)
vector[2] #acceder 


#Factores (el factor tiene niveles)
vector_2 <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Tue", "Wed", "Fri", "Sat", "Sun","Wed", "Thu","Wed", "Thu")
factor <- factor(vector_2)

#ordered factors
factor_2 <- ordered(factor, levels=c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))


#Data frame (tabla)
df <- data.frame(
  col1 = c("this", "is", "a", "vector", "of", "strings"),
  col2 = 1:6,
  col3 = letters[1:6],
  stringsAsFactors = FALSE
)

View(df)

str(df) #structure
names(df) #nombres de las columnas
names(df) <- c("column1", "column2", "column3") #cambiar el nombre de las columnas
colnames(df)
head(df)
tail(df)

#dimensions
nrow(df)
ncol(df)


#new columns
#acceder a una columna:
df$column1 # $ se usa para acceder a algo
df[4,3] #acceder a la fila 4, columna 3

#crear/agregar una nueva columna: (indexing)
df$column4 <- 11:16 #tiene que tener la misma cantidad de filas que el dataframe original
df[,3]


#agregar filas
new_elements <- c("new", 7, "g", "17")
rbind(df, new_elements)

df_copy$col1 <- factor(df_copy$col1) #cambiar un tipo de dato

rbind(df_copy, c("new", 7, "g"))


# Funciones importantes
is.na(df) ##missing data - filtrar (filas/columnas vacias)

colSums(df) # sumar columnas (total) must be numeric

df[, "column2"] #filtrar filas o culumnas
df[, 2]
sum(df[, 2])

df[, c("column2", "column4")]
colSums(df[, c("column2", "column4")])

df <- rbind(df, c(NA, 7, "g", 17))

v <- 1:7
v[is.na(df$column1)]
is.na(df$column1) # vector tipo logico (T/F)

logico <- v <= 4 # true cuando un elemento del vector v sea menor o igual a 4

df[!is.na(df$column1),] # ! = not

df[logico,] 


# Crear una nueva función en R
find_sample <- function(x, s){
  for_index <- sample(1:nrow(x), size = s, replace = FALSE)
  new_df <- x[for_index,]
  
  return(new_df)
}

data <- data_frame(
  a = 1:10,
  b = sample(c("GT", "US", "CA"), size = 10, replace = TRUE)
)

find_sample(x = data, s = 4)


##apply
generate_df <- function(x){
  return(
    data.frame(
      a = sample(letters, size = 10, replace = TRUE),
      b = sample(1:10, size = 10, replace = TRUE)
    )
  )
}
generate_df()

lista <- lapply(1:400, generate_df)







