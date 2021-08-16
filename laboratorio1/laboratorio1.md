Laboratorio 1
================
Andrea Reyes
8/15/2021

## —– Problema 1 —–

Librerias:

``` r
library(readxl)
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.3     ✓ dplyr   1.0.7
    ## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
    ## ✓ readr   2.0.1     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(dplyr)
library(xlsx)
```

Cargar archivos excel:

``` r
entrega1 <- read_excel("data/01-2018.xlsx")
entrega2 <- read_excel("data/02-2018.xlsx")
entrega3 <- read_excel("data/03-2018.xlsx")
entrega4 <- read_excel("data/04-2018.xlsx")
entrega5 <- read_excel("data/05-2018.xlsx")
entrega6 <- read_excel("data/06-2018.xlsx")
entrega7 <- read_excel("data/07-2018.xlsx")
entrega8 <- read_excel("data/08-2018.xlsx")
```

    ## New names:
    ## * `` -> ...10

``` r
entrega9 <- read_excel("data/09-2018.xlsx")
entrega10 <- read_excel("data/10-2018.xlsx")
entrega11 <- read_excel("data/11-2018.xlsx")
```

Unificar todos los archivos:

``` r
entregas <- bind_rows(entrega1, entrega2, entrega3, entrega4, entrega5, entrega6, entrega7, entrega8, entrega9, entrega10, entrega11, .id = "FECHA")
head(entregas)
```

    ## # A tibble: 6 × 11
    ##   FECHA COD_VIAJE CLIENTE   UBICACION CANTIDAD PILOTO     Q CREDITO UNIDAD  TIPO
    ##   <chr>     <dbl> <chr>         <dbl>    <dbl> <chr>  <dbl>   <dbl> <chr>  <dbl>
    ## 1 1      10000001 EL PINCH…     76002     1200 Ferna… 300        30 Camio…    NA
    ## 2 1      10000002 TAQUERIA…     76002     1433 Hecto… 358.       90 Camio…    NA
    ## 3 1      10000003 TIENDA L…     76002     1857 Pedro… 464.       60 Camio…    NA
    ## 4 1      10000004 TAQUERIA…     76002      339 Angel…  84.8      30 Panel     NA
    ## 5 1      10000005 CHICHARR…     76001     1644 Juan … 411        30 Camio…    NA
    ## 6 1      10000006 UBIQUO L…     76001     1827 Luis … 457.       30 Camio…    NA
    ## # … with 1 more variable: ...10 <dbl>

Columna fecha:

``` r
entregas$FECHA <- paste(entregas$FECHA, "- 2018")
head(entregas)
```

    ## # A tibble: 6 × 11
    ##   FECHA  COD_VIAJE CLIENTE  UBICACION CANTIDAD PILOTO     Q CREDITO UNIDAD  TIPO
    ##   <chr>      <dbl> <chr>        <dbl>    <dbl> <chr>  <dbl>   <dbl> <chr>  <dbl>
    ## 1 1 - 2…  10000001 EL PINC…     76002     1200 Ferna… 300        30 Camio…    NA
    ## 2 1 - 2…  10000002 TAQUERI…     76002     1433 Hecto… 358.       90 Camio…    NA
    ## 3 1 - 2…  10000003 TIENDA …     76002     1857 Pedro… 464.       60 Camio…    NA
    ## 4 1 - 2…  10000004 TAQUERI…     76002      339 Angel…  84.8      30 Panel     NA
    ## 5 1 - 2…  10000005 CHICHAR…     76001     1644 Juan … 411        30 Camio…    NA
    ## 6 1 - 2…  10000006 UBIQUO …     76001     1827 Luis … 457.       30 Camio…    NA
    ## # … with 1 more variable: ...10 <dbl>

Eliminar columnas innecesarias:

``` r
entregas <- subset(entregas, select = -c(TIPO, ...10) )
head(entregas)
```

    ## # A tibble: 6 × 9
    ##   FECHA    COD_VIAJE CLIENTE    UBICACION CANTIDAD PILOTO       Q CREDITO UNIDAD
    ##   <chr>        <dbl> <chr>          <dbl>    <dbl> <chr>    <dbl>   <dbl> <chr> 
    ## 1 1 - 2018  10000001 EL PINCHE…     76002     1200 Fernand… 300        30 Camio…
    ## 2 1 - 2018  10000002 TAQUERIA …     76002     1433 Hector … 358.       90 Camio…
    ## 3 1 - 2018  10000003 TIENDA LA…     76002     1857 Pedro A… 464.       60 Camio…
    ## 4 1 - 2018  10000004 TAQUERIA …     76002      339 Angel V…  84.8      30 Panel 
    ## 5 1 - 2018  10000005 CHICHARRO…     76001     1644 Juan Fr… 411        30 Camio…
    ## 6 1 - 2018  10000006 UBIQUO LA…     76001     1827 Luis Ja… 457.       30 Camio…

Exportar archivo excel:

``` r
write.xlsx(entregas, "entragasEmbotelladora.xlsx")
```

-   El .xlsx se encuentra en la carpeta principal (laboratorio1)

## —– Problema 2 —–

Crear lista de vectores:

``` r
listaVectores <- function(n){
  v1 = sample(1:50, size = n, replace = FALSE)
  v2 = sample(1:20, size = n, replace = FALSE)
  v3 = sample(1:80, size = n, replace = FALSE)
  
  vectores <- list(v1, v2, v3)
  return(vectores)
}

vectores <- listaVectores(12)
```

Encontrar la moda de cada vector:

``` r
lapply(vectores, mean)
```

    ## [[1]]
    ## [1] 16.33333
    ## 
    ## [[2]]
    ## [1] 8.583333
    ## 
    ## [[3]]
    ## [1] 44.66667

## —– Problema 3 —–

Librerias:

``` r
library(readr)
```

Leer archivo de la sat:

``` r
textFileSat <- "sat/INE_PARQUE_VEHICULAR_080119.txt"

parqueVehicular <- read_delim(textFileSat, delim = "|")
```

    ## New names:
    ## * `` -> ...11

    ## Warning: One or more parsing issues, see `problems()` for details

    ## Rows: 2417809 Columns: 11

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: "|"
    ## chr (8): MES, NOMBRE_DEPARTAMENTO, NOMBRE_MUNICIPIO, MODELO_VEHICULO, LINEA_...
    ## dbl (2): ANIO_ALZA, CANTIDAD
    ## lgl (1): ...11

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
satVPdf <- data.frame(parqueVehicular)
```

Show:

``` r
head(satVPdf)
```

    ##   ANIO_ALZA MES NOMBRE_DEPARTAMENTO NOMBRE_MUNICIPIO MODELO_VEHICULO
    ## 1      2007  05       HUEHUETENANGO    HUEHUETENANGO            2007
    ## 2      2007  05         EL PROGRESO        EL JICARO            2007
    ## 3      2007  05          SAN MARCOS             OCOS            2007
    ## 4      2007  05           ESCUINTLA      SAN JOS\xc9            2006
    ## 5      2007  05             JUTIAPA           MOYUTA            2007
    ## 6      2007  05           GUATEMALA        FRAIJANES            1997
    ##            LINEA_VEHICULO TIPO_VEHICULO USO_VEHICULO MARCA_VEHICULO CANTIDAD
    ## 1                SPORT125          MOTO  MOTOCICLETA      ASIA HERO        1
    ## 2 BT-50 DBL CAB 4X2 TURBO       PICK UP   PARTICULAR          MAZDA        1
    ## 3                   JL125          MOTO  MOTOCICLETA         KINLON        1
    ## 4               JL125T-15          MOTO  MOTOCICLETA        JIALING        1
    ## 5                 JH100-2          MOTO  MOTOCICLETA        JIALING        1
    ## 6  TACOMA XTRA CAB 4X4 V6       PICK UP   PARTICULAR         TOYOTA        1
    ##   ...11
    ## 1    NA
    ## 2    NA
    ## 3    NA
    ## 4    NA
    ## 5    NA
    ## 6    NA
