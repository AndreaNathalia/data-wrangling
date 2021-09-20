dw-2020-parcial-1
================
Tepi
9/3/2020

# Examen parcial

Indicaciones generales:

-   Usted tiene el período de la clase para resolver el examen parcial.

-   La entrega del parcial, al igual que las tareas, es por medio de su
    cuenta de github, pegando el link en el portal de MiU.

-   Pueden hacer uso del material del curso e internet (stackoverflow,
    etc.). Sin embargo, si encontramos algún indicio de copia, se
    anulará el exámen para los estudiantes involucrados. Por lo tanto,
    aconsejamos no compartir las agregaciones que generen.

## Sección I: Preguntas teóricas.

-   Existen 10 preguntas directas en este Rmarkdown, de las cuales usted
    deberá responder 5. Las 5 a responder estarán determinadas por un
    muestreo aleatorio basado en su número de carné.

-   Ingrese su número de carné en `set.seed()` y corra el chunk de R
    para determinar cuáles preguntas debe responder.

``` r
set.seed(20190265) 
v<- 1:10
preguntas <-sort(sample(v, size = 5, replace = FALSE ))

paste0("Mis preguntas a resolver son: ",paste0(preguntas,collapse = ", "))
```

    ## [1] "Mis preguntas a resolver son: 1, 5, 7, 8, 9"

### Listado de preguntas teóricas

1.  Para las siguientes sentencias de `base R`, liste su contraparte de
    `dplyr`:

    -   `str()`
    -   `df[,c("a","b")]`
    -   `names(df)[4] <- "new_name"` donde la posición 4 corresponde a
        la variable `old_name`
    -   `df[df$variable == "valor",]`

2.  Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas
    funciones que el keyword `OR` para filtrar uno o más elementos una
    misma columna?

3.  ¿Por qué en R utilizamos funciones de la familia apply
    (lapply,vapply) en lugar de utilizar ciclos?

4.  ¿Cuál es la diferencia entre utilizar `==` y `=` en R?

5.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`?

6.  ¿Qué es un vector y en qué se diferencia en una lista en R?

7.  ¿Qué pasa si quiero agregar una nueva categoría a un factor que no
    se encuentra en los niveles existentes?

8.  Si en un dataframe, a una variable de tipo `factor` le agrego un
    nuevo elemento que *no se encuentra en los niveles existentes*,
    ¿cuál sería el resultado esperado y por qué?

    -   El nuevo elemento
    -   `NA`

9.  En SQL, ¿para qué utilizamos el keyword `HAVING`?

10. Si quiero obtener como resultado las filas de la tabla A que no se
    encuentran en la tabla B, ¿cómo debería de completar la siguiente
    sentencia de SQL?

    -   SELECT \* FROM A \_\_\_\_\_\_\_ B ON A.KEY = B.KEY WHERE
        \_\_\_\_\_\_\_\_\_\_ = \_\_\_\_\_\_\_\_\_\_

Extra: ¿Cuántos posibles exámenes de 5 preguntas se pueden realizar
utilizando como banco las diez acá presentadas? (responder con código de
R.)

## Sección II Preguntas prácticas.

-   Conteste las siguientes preguntas utilizando sus conocimientos de R.
    Adjunte el código que utilizó para llegar a sus conclusiones en un
    chunk del markdown.

A. De los clientes que están en más de un país,¿cuál cree que es el más
rentable y por qué?

B. Estrategia de negocio ha decidido que ya no operará en aquellos
territorios cuyas pérdidas sean “considerables”. Bajo su criterio,
¿cuáles son estos territorios y por qué ya no debemos operar ahí?

## Andrea Reyes - 20190265

### I. Preguntas teóricas

Mis preguntas a resolver son: 1, 5, 7, 8, 9

##### 1. Para las siguientes sentencias de `base R`, liste su contraparte de `dplyr`:

### base R:

    a. `str()`           

    b. `df[,c("a","b")]`

    c. `names(df)[4] <- "new_name"` 

    d. `df[df$variable == "valor",]`

### dplyr:

    a.  str_

    b. df %>% 
        select(a,b)

    c. df %>% 
        rename(new_name = old_name) 
        
    d.filter(df, variable == "valor")

##### 5. ¿Cuál es la forma correcta de cargar un archivo de texto donde el delimitador es `:`?

La libreria readr incluye funciones para leer datos almacenados. La
forma correcta de leer un .txt con delimitidor : es usando la función
read.delim, que es parte de readr. A esta función se le puede
especificar cuál es el delimitador del archivo txt.

Ejemplo: read.delim(file = “nombre\_archivo.txt” header = TRUE, sep =
“:”)

##### 7. ¿Qué pasa si quiero agregar una nueva categoría a un factor que no se encuentra en los niveles existentes?

No se puede agregar la nueva categoría, las categorías tienen que ser
del mismo tamaño que los niveles. Al crear el factor se establece el
conjunto fijo de valores posibles.

##### 8. Si en un dataframe, a una variable de tipo `factor` le agrego un nuevo elemento que *no se encuentra en los niveles existentes*, ¿cuál sería el resultado esperado y por qué?

    * `El nuevo elemento`
    * `NA`

El resultado será `NA` porque cualquier valor no fijado en el factor, es
convertido a NA.

##### 9. En SQL, ¿para qué utilizamos el keyword `HAVING`?

Utilizamos HAVING para especificar condiciones que filtran los
resultados, es decir, HAVING especifica que un SELECT sólo debe devolver
las filas en las que los valores agregados cumplan las condiciones.

Por ejemplo: Si una consulta tiene GROUP BY, las filas de la tabla de
agrupan y agregan. Después de la agregación, se usa HAVING, filtrando
las filas que no coinciden con las condiciones especificadas.

### I. Preguntas prácticas

## A

``` r
###resuelva acá
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
df <- readRDS("parcial_anonimo.rds")
#View(df)

clientes <- df %>% 
              select(Cliente, Pais, Venta)%>%
              group_by(Cliente, Venta)%>%
              summarise(clientes_repetidos = n_distinct(Pais))%>%
              filter(clientes_repetidos > 1)
```

    ## `summarise()` has grouped output by 'Cliente'. You can override using the `.groups` argument.

``` r
clientes
```

    ## # A tibble: 19 × 3
    ## # Groups:   Cliente [7]
    ##    Cliente  Venta clientes_repetidos
    ##    <chr>    <dbl>              <int>
    ##  1 044118d4   0                    2
    ##  2 044118d4  16.3                  2
    ##  3 044118d4  26.0                  2
    ##  4 044118d4  31.4                  2
    ##  5 a17a7558   0                    2
    ##  6 a17a7558  22.6                  2
    ##  7 a17a7558  68.5                  2
    ##  8 bf1e94e9   0                    2
    ##  9 c53868a0   0                    2
    ## 10 c53868a0  16.7                  2
    ## 11 c53868a0  22.8                  2
    ## 12 c53868a0  62.9                  2
    ## 13 c53868a0  94.3                  2
    ## 14 f2aab44e   0                    2
    ## 15 f676043b   0                    2
    ## 16 ff122c3f   0                    2
    ## 17 ff122c3f  11.3                  2
    ## 18 ff122c3f  16.3                  2
    ## 19 ff122c3f  31.4                  2

``` r
rentable <- max(clientes$Venta)
rentable
```

    ## [1] 94.32

El cliente más rentable es c53868a0 porque de los clientes que están en
más de un país, es el que más ventas representa.

## B

``` r
###resuelva acá
library(dplyr)
#B. Estrategia de negocio ha decidido que ya no operará en aquellos territorios cuyas pérdidas sean "considerables". Bajo su criterio, ¿cuáles son estos territorios y por qué ya no debemos operar ahí?

# grupo
territorios <- df %>% 
              select(Territorio, Venta)%>%
              group_by(Territorio, Venta)
              
territorios
```

    ## # A tibble: 226,236 × 2
    ## # Groups:   Territorio, Venta [21,510]
    ##    Territorio Venta
    ##    <chr>      <dbl>
    ##  1 69c1b705    26.5
    ##  2 69c1b705     0  
    ##  3 69c1b705    39.8
    ##  4 69c1b705    39.8
    ##  5 69c1b705   106  
    ##  6 69c1b705    39.8
    ##  7 69c1b705     0  
    ##  8 69c1b705    39.8
    ##  9 69c1b705    79.5
    ## 10 69c1b705   132. 
    ## # … with 226,226 more rows

``` r
# Quien tiene pérdidas más altas
perdidas <- which.min(territorios$Venta)

terr <- territorios$Territorio[perdidas]
vent <- territorios$Venta[perdidas]

terr
```

    ## [1] "72520ba2"

``` r
vent
```

    ## [1] -622.6

El territorio con el que ya no se debe operar es 72520ba2 porque es el
territorio que más perdidas representa en cuanto a ventas.
