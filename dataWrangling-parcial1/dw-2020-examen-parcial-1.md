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

    a.  nn 

    b.

    c. df %>% 
        rename(old_name = new_name) 
        
    d.

##### 5. ¿Cuál es la forma correcta de cargar un archivo de texto donde el delimitador es `:`?

La libreria readr incluye funciones para leer datos almacenados. La
forma correcta de leer un .txt con delimitidor : es usando la función
read.delim, que es parte de readr. A esta función se le puede
especificar cuál es el delimitador del archivo txt.

Ejemplo: read.delim(file = “nombre\_archivo.txt” header = TRUE, sep =
“:”)

##### 7. ¿Qué pasa si quiero agregar una nueva categoría a un factor que no se encuentra en los niveles existentes?

##### 8. Si en un dataframe, a una variable de tipo `factor` le agrego un nuevo elemento que *no se encuentra en los niveles existentes*, ¿cuál sería el resultado esperado y por qué?

    * El nuevo elemento
    * `NA`

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
```

## B

``` r
###resuelva acá
```