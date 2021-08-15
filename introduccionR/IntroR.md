Introducción a R
================
Andrea Reyes
8/9/2021

## Librerías

Instalar librerías:

``` r
#install.packages("dplyr")
#install.packages("RMySQL")
#install.packages("lubridate")
#install.packages("openxlsx")
#install.packages("tidyverse")
#install.packages("stringr")
#install.packages("readr")
```

Cargar librerías:

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
#Folder / location
getwd()
```

    ## [1] "/Users/andreareyes/Desktop/Data Wrangling/data-wrangling/introduccionR"

## Tipos y estructuras de datos

Strings:

``` r
string <- "This is a string"
class(string)
```

    ## [1] "character"

``` r
typeof(string)
```

    ## [1] "character"

``` r
length(string) #elementos
```

    ## [1] 1

``` r
nchar(string) #caracteres
```

    ## [1] 16

Double:

``` r
number <- 2344
class(number)
```

    ## [1] "numeric"

``` r
typeof(number)
```

    ## [1] "double"

``` r
length(number)
```

    ## [1] 1

Integer:

``` r
integer <- 3L #se agrega la L para declarar que es int
class(integer)
```

    ## [1] "integer"

``` r
typeof(integer)
```

    ## [1] "integer"

Logical:

``` r
logical <- FALSE #F=0 ; T=1
class(logical)
```

    ## [1] "logical"

``` r
typeof(logical)
```

    ## [1] "logical"

Vectores:

-   Coleccion de elementos de un mismo tipo de dato; es dinamico

``` r
vector <- c("string", "this", "is")
length(vector)
```

    ## [1] 3

``` r
vector[2] #acceder 
```

    ## [1] "this"

Factores:

-   El factor tiene niveles

``` r
vector_2 <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Tue", "Wed", "Fri", "Sat", "Sun","Wed", "Thu","Wed", "Thu")
factor <- factor(vector_2)
```

Factores ordenados:

``` r
factor_2 <- ordered(factor, levels=c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))
```

Data frame:

(Tabla)

``` r
df <- data.frame(
  col1 = c("this", "is", "a", "vector", "of", "strings"),
  col2 = 1:6,
  col3 = letters[1:6],
  stringsAsFactors = FALSE
)
  
str(df) #structure
```

    ## 'data.frame':    6 obs. of  3 variables:
    ##  $ col1: chr  "this" "is" "a" "vector" ...
    ##  $ col2: int  1 2 3 4 5 6
    ##  $ col3: chr  "a" "b" "c" "d" ...

``` r
names(df) #nombres de las columnas
```

    ## [1] "col1" "col2" "col3"

``` r
names(df) <- c("column1", "column2", "column3") #cambiar el nombre de las columnas
colnames(df)
```

    ## [1] "column1" "column2" "column3"

``` r
head(df)
```

    ##   column1 column2 column3
    ## 1    this       1       a
    ## 2      is       2       b
    ## 3       a       3       c
    ## 4  vector       4       d
    ## 5      of       5       e
    ## 6 strings       6       f

``` r
tail(df)
```

    ##   column1 column2 column3
    ## 1    this       1       a
    ## 2      is       2       b
    ## 3       a       3       c
    ## 4  vector       4       d
    ## 5      of       5       e
    ## 6 strings       6       f

Dimensiones:

``` r
nrow(df)
```

    ## [1] 6

``` r
ncol(df)
```

    ## [1] 3

## Nuevas columnas

Acceder a una columna:

``` r
df$column1 # $ se usa para acceder a algo
```

    ## [1] "this"    "is"      "a"       "vector"  "of"      "strings"

``` r
df[4,3] #acceder a la fila 4, columna 3
```

    ## [1] "d"

Crear/agregar una nueva columna:

(indexing)

``` r
df$column4 <- 11:16 #tiene que tener la misma cantidad de filas que el dataframe original
df[,3]
```

    ## [1] "a" "b" "c" "d" "e" "f"

Agregar filas:

``` r
new_elements <- c("new", 7, "g", "17")
rbind(df, new_elements)
```

    ##   column1 column2 column3 column4
    ## 1    this       1       a      11
    ## 2      is       2       b      12
    ## 3       a       3       c      13
    ## 4  vector       4       d      14
    ## 5      of       5       e      15
    ## 6 strings       6       f      16
    ## 7     new       7       g      17

``` r
#df_copy$col1 <- factor(df_copy$col1) #cambiar un tipo de dato
#rbind(df_copy, c("new", 7, "g"))
```

## Funciones importantes

``` r
is.na(df) ##missing data - filtrar (filas/columnas vacias)
```

    ##      column1 column2 column3 column4
    ## [1,]   FALSE   FALSE   FALSE   FALSE
    ## [2,]   FALSE   FALSE   FALSE   FALSE
    ## [3,]   FALSE   FALSE   FALSE   FALSE
    ## [4,]   FALSE   FALSE   FALSE   FALSE
    ## [5,]   FALSE   FALSE   FALSE   FALSE
    ## [6,]   FALSE   FALSE   FALSE   FALSE

``` r
# colSums(df) # sumar columnas (total); ERROR -> must be numeric

df[, "column2"] #filtrar filas o culumnas
```

    ## [1] 1 2 3 4 5 6

``` r
df[, 2]
```

    ## [1] 1 2 3 4 5 6

``` r
sum(df[, 2])
```

    ## [1] 21

``` r
df[, c("column2", "column4")]
```

    ##   column2 column4
    ## 1       1      11
    ## 2       2      12
    ## 3       3      13
    ## 4       4      14
    ## 5       5      15
    ## 6       6      16

``` r
colSums(df[, c("column2", "column4")])
```

    ## column2 column4 
    ##      21      81

``` r
df <- rbind(df, c(NA, 7, "g", 17))

v <- 1:7
v[is.na(df$column1)]
```

    ## [1] 7

``` r
is.na(df$column1) # vector tipo logico (T/F)
```

    ## [1] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE

``` r
logico <- v <= 4 # true cuando un elemento del vector v sea menor o igual a 4

df[!is.na(df$column1),] # ! = not
```

    ##   column1 column2 column3 column4
    ## 1    this       1       a      11
    ## 2      is       2       b      12
    ## 3       a       3       c      13
    ## 4  vector       4       d      14
    ## 5      of       5       e      15
    ## 6 strings       6       f      16

``` r
df[logico,] 
```

    ##   column1 column2 column3 column4
    ## 1    this       1       a      11
    ## 2      is       2       b      12
    ## 3       a       3       c      13
    ## 4  vector       4       d      14

## Crear una nueva función en R

``` r
find_sample <- function(x, s){
  for_index <- sample(1:nrow(x), size = s, replace = FALSE)
  new_df <- x[for_index,]
  
  return(new_df)
}

data <- data_frame(
  a = 1:10,
  b = sample(c("GT", "US", "CA"), size = 10, replace = TRUE)
)
```

    ## Warning: `data_frame()` was deprecated in tibble 1.1.0.
    ## Please use `tibble()` instead.

``` r
find_sample(x = data, s = 4)
```

    ## # A tibble: 4 × 2
    ##       a b    
    ##   <int> <chr>
    ## 1     8 GT   
    ## 2     2 GT   
    ## 3     1 GT   
    ## 4     5 GT

``` r
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
```

    ##    a b
    ## 1  c 7
    ## 2  m 1
    ## 3  w 3
    ## 4  j 5
    ## 5  r 4
    ## 6  w 4
    ## 7  k 7
    ## 8  e 8
    ## 9  l 9
    ## 10 z 6

``` r
lista <- lapply(1:400, generate_df)
```
