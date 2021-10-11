Lab 6
================
Andrea Reyes
10/06/2021

# Regex

#### 1. Generar una expresión regular que sea capaz de detectar las placas de un vehículo particular guatemalteco.

-   La configuración de las placas guatemaltecas es de: 1 letra, 3
    números y 3 letras.

##### Regex: `^[a-zA-Z]{1}[0-9]{3}[a-zA-Z]{3}$`

``` r
regexPlaca <- "^[a-zA-Z]{1}[0-9]{3}[a-zA-Z]{3}$"

#Ejemplos de placas
prueba <- c("A234SDF", "7YUH654", "W345MNB", "Q23WSSS", "S098ABC", "W614SD5", "W333DDD")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexPlaca, prueba)
cat("Las placas correctas son:", prueba[match])
```

    ## Las placas correctas son: A234SDF W345MNB S098ABC W333DDD

#### 2. Genere una expresión regular que valide si un archivo es de tipo .pdf o jpg.

-   Ejemplo1.pdf, prueba2.PDF, respuestas\_del\_examen.jpg, amor.JPG

##### Regex: `^[a-zA-z0-9_-]*.(jpg|JPG|pdf|PDF)$`

``` r
regexArchivo <- "^[a-zA-z0-9_-]*.(jpg|JPG|pdf|PDF)$"

#Ejemplos de nombres de archivos
prueba <- c("Ejemplo1.pdf", "prueba2.PDF", "respuestas_del_examen.jpg", "amor.JPG", "archivo.png", "hola-21.jpg")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexArchivo, prueba)
cat("Las placas correctas son:", prueba[match])
```

    ## Las placas correctas son: Ejemplo1.pdf prueba2.PDF respuestas_del_examen.jpg amor.JPG hola-21.jpg
