# ------ Problema 1 ------

#librerias
library(readxl)
library(tidyverse)
library(dplyr)
library(xlsx)

#cargar archivos excel
entrega1 <- read_excel("data/01-2018.xlsx")
entrega2 <- read_excel("data/02-2018.xlsx")
entrega3 <- read_excel("data/03-2018.xlsx")
entrega4 <- read_excel("data/04-2018.xlsx")
entrega5 <- read_excel("data/05-2018.xlsx")
entrega6 <- read_excel("data/06-2018.xlsx")
entrega7 <- read_excel("data/07-2018.xlsx")
entrega8 <- read_excel("data/08-2018.xlsx")
entrega9 <- read_excel("data/09-2018.xlsx")
entrega10 <- read_excel("data/10-2018.xlsx")
entrega11 <- read_excel("data/11-2018.xlsx")

#unificar todos los archivos
entregas <- bind_rows(entrega1, entrega2, entrega3, entrega4, entrega5, entrega6, entrega7, entrega8, entrega9, entrega10, entrega11, .id = "FECHA")
view(entregas)

#fecha
entregas$FECHA <- paste(entregas$FECHA, "- 2018")
view(entregas)

#eliminar columnas innecesarias
entregas <- subset(entregas, select = -c(TIPO, ...10) )
view(entregas)

#exportar archivo excel
write.xlsx(entregas, "entragasEmbotelladora.xlsx")



# ------ Problema 2 ------

#crear lista de vectores
listaVectores <- function(n){
  v1 = sample(1:50, size = n, replace = FALSE)
  v2 = sample(1:20, size = n, replace = FALSE)
  v3 = sample(1:80, size = n, replace = FALSE)
  
  vectores <- list(v1, v2, v3)
  return(vectores)
}

vectores <- listaVectores(12)

#encontrar la moda de cada vector
lapply(vectores, mean)


# ------ Problema 3 ------

#librerias
library(readr)

#leer archivo de la sat
textFileSat <- "sat/INE_PARQUE_VEHICULAR_080119.txt"

parqueVehicular <- read_delim(textFileSat, delim = "|")
satVPdf <- data.frame(parqueVehicular)

View(satVPdf)










