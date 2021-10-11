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

#### 2. Generar una expresión regular que valide si un archivo es de tipo .pdf o jpg.

-   Ejemplo1.pdf, prueba2.PDF, respuestas\_del\_examen.jpg, amor.JPG

##### Regex: `^[a-zA-z0-9_-]*.(jpg|JPG|pdf|PDF)$`

``` r
regexArchivo <- "^[a-zA-z0-9_-]*.(jpg|JPG|pdf|PDF)$"

#Ejemplos de nombres de archivos
prueba <- c("Ejemplo1.pdf", "prueba2.PDF", "respuestas_del_examen.jpg", "amor.JPG", "archivo.png", "hola-21.jpg", "ArchivoPrueba.PNG", "regex")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexArchivo, prueba)
cat("Los tipos correctos de archivo son:", prueba[match])
```

    ## Los tipos correctos de archivo son: Ejemplo1.pdf prueba2.PDF respuestas_del_examen.jpg amor.JPG hola-21.jpg

#### 3. Genere una expresión regular para validar contraseñas de correo.

-   Una contraseña de correo debe contener por lo menos 8 caracteres,
    una letra mayúscula y un carácter especial.

##### Regex: `^(?=.*[A-Z])(?=.*[!@#$&*]).{8,}$`

``` r
regexPassword <- "^(?=.*[A-Z])(?=.*[!@#$&*]).{8,}$"

#Ejemplos de contraseñas
prueba <- c("Andreanathalia&", "Con#123df", "pwd$fcwsdD", "pfg#g456csw", "dgfE#dsddswd", "P34hfnsc")
```

#### 4. Cree una expresión regular para validar un numero de carnet de la Universidad Galileo.

-   Por ejemplo: 19002324  
-   Los primeros dos dígitos representan el año en el que el alumno se
    inscribió los cuales pueden variar desde el 01 (año 2001) hasta el
    30 (año 2030).
-   Los siguientes dos dígitos son cero (00) los cuales van por default
    y
-   los últimos cuatro dígitos son un número que va desde el 1110 hasta
    el 8970.

##### Regex: `^(([1-3][0-9])|(0[1-9]))00((11[1-9][0-9])|(1[2-9][0-9][0-9])|([2-7][0-9][0-9][0-9])|(8[0-8][0-9][0-9])|(89[0-6][0-9])|(8970))$`

``` r
regexCarnet <- "^(([1-3][0-9])|(0[1-9]))00((11[1-9][0-9])|(1[2-9][0-9][0-9])|([2-7][0-9][0-9][0-9])|(8[0-8][0-9][0-9])|(89[0-6][0-9])|(8970))$"

#Ejemplos de carnets
prueba <- c("19002324", "120A1150", "01001110", "05671120", "30008970", "40001115")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexCarnet, prueba)
cat("Los carnets correctos son:", prueba[match])
```

    ## Los carnets correctos son: 19002324 01001110 30008970

#### 5. Cree una expresión regular que encuentre todas las palabras de la primera línea, pero ninguna de la segunda.

-   pit, spot, spate, slap two, respite
-   pt, Pot, peat, part

##### Regex: `^((pit)|(spot)|(spate)|(slap two)|(respite))$`

``` r
regexPalabras <- "^((pit)|(spot)|(spate)|(slap two)|(respite))$"

#Ejemplos de palabras
prueba <- c("pit", "spot", "spate", "slap two", "respite", "pt", "Pot", "peat", "part")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexPalabras, prueba)
cat("Las palabras correctas son:", prueba[match])
```

    ## Las palabras correctas son: pit spot spate slap two respite

#### 6. Cree una expresión regular para obtener los números telefónicos de Guatemala.

-   Estos pueden contener al inicio +502 o 502,

-   Pueden estar separados por un espacio en blanco o un guión o juntos.

-   Notar que los números telefónicos pueden empezar únicamente con
    4,5,6 o 2.

-   +50254821151, 4210-7640, 52018150, 2434 6854, 11234569, 50211234578

##### Regex: `((\\+)?502( |-)?)?([0-9]{4})( |-)?([0-9]{4})`

``` r
regexNumeros <- "((\\+)?502( |-)?)?([0-9]{4})( |-)?([0-9]{4})"

#Ejemplos de numeros
prueba <- c("+50254821151", "4210-7640", "52018150", "2434 6854", "11234569", "50211234578")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexNumeros, prueba)
cat("Los números correctos son:", prueba[match])
```

    ## Los números correctos son: +50254821151 4210-7640 52018150 2434 6854 11234569 50211234578

#### 7. Genere una expresión regular que sea capaz de obtener correos de la UFM.

##### Regex: `^([a-zA-Z0-9]+)@ufm([\\.])edu$`

``` r
regexUfm <- "^([a-zA-Z0-9]+)@ufm([\\.])edu$"

#Ejemplos de correos UFM
prueba <- c("andreareyes@ufm.edu", "andrea@gmail.com", "andrear@ufm.com", "andrea2019@ufm.edu", "andreaufm.edu", "andrea@ufm.ed")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexUfm, prueba)
cat("Los correos ufm correctos son:", prueba[match])
```

    ## Los correos ufm correctos son: andreareyes@ufm.edu andrea2019@ufm.edu

#### 8. En el mundo distópico de Eurasia, Big Brother le asigna un identificador único a cada ciudadano. Genere una expresión regular que valide las identificaciones.

-   Composición del id:

1.  El id inicia con 0 a 3 letras minúsculas (puede tener 0 letras
    minúsculas hasta tres letras minúsculas)
2.  Luego es seguido por una cadena de dígitos que puede ser de 2 a 9
    dígitos respectivamente.
3.  Inmediatamente después de la cadena de dígitos, se encuentra por lo
    menos tres letras mayúsculas.
4.  Ej: abc012333ABCDEEEE

##### Regex: `^([a-z]{0,3})([0-9]{2,9})([A-Z]{3,})$`

``` r
regexId <- "^([a-z]{0,3})([0-9]{2,9})([A-Z]{3,})$"

#Ejemplos de identificadores
prueba <- c("abc012333ABCDEEEE", "wer34BNH", "e234567890KKKKD", "3456EFT", "HJ2mnk")

#Comprobar regex (cuales de la lista de ejemplos hacen match con la regex)
match <- grep(regexId, prueba)
cat("Las identificaciones correctas son:", prueba[match])
```

    ## Las identificaciones correctas son: abc012333ABCDEEEE wer34BNH e234567890KKKKD 3456EFT
