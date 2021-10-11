# Librerias
library(readr)
library(dplyr)

# Cargar dataset
df <- read_delim("c1.csv", delim = ",", escape_double = TRUE, trim_ws = TRUE)

# Ver dataset
View(df)

#id = postes
#que tipo de vehículo se usó para la verificacion (cod)
# origen = de donde dale el vehículo
# intervalos de numeros (ultimas columnas) = distancia del origen al poste (minutos o km)
# no se analiza ingreso por energía electrica sino por mantenimiento 

#directo = costo directo del mantenimiento ()
#fijo = costo ajeno al mantenimiento (independeintemente del negocio, se pagan)
# height = 