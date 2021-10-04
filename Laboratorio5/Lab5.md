Lab5
================
Andrea Reyes
9/30/2021

# Laboratorio 5

## Parte 1: Predecir un eclipse solar

``` r
#Eclipse anterior
eclipseTotal <- ymd_hms("2017 aug 21 18:26:40", tz="GMT")
eclipseTotal <- with_tz(eclipseTotal, "GMT")
```

``` r
#Siguiente eclipse
# Un Synodic Month equivale a 29 días con 12 horas, con 44 minutos y 3 segundos.
SynodicMonth <- days(29) + hours(12) + minutes(44) + seconds(3)

# Un Saros equivale a 223 Synodic Months
Saros <- 223 * SynodicMonth

siguienteEclipseSolar <- eclipseTotal + Saros
```

``` r
# Requisitos (variables)

#Variable con la fecha del eclipse histórico.
eclipseTotal <- as_tibble(eclipseTotal)

#Variable que sea un Saros.
Saros <- as_tibble(Saros)

#Variable que sea un Synodic Month.
SynodicMonth <- as_tibble(SynodicMonth)

#La fecha del siguiente eclipse solar
siguienteEclipseSolar <- as_tibble(siguienteEclipseSolar)
```

Fecha del eclipse histórico: 2017-08-21 18:26:40

Saros: 6467d 2676H 9812M 669S

Synodic Month: 29d 12H 44M 3S

##### El siguiente eclipse solar será en: 2035-09-02 02:09:49

## Parte 2: Agrupaciones y operaciones con fechas

Leer data

``` r
df <- read_excel("data.xlsx")
```

Ver data

``` r
#View(df)
```

##### 1. ¿En qué meses existe una mayor cantidad de llamadas por código?

``` r
df <- df %>%
  mutate(`Fecha Creación` = dmy(`Fecha Creación`)) %>%
  mutate(`Fecha Final` = dmy(`Fecha Final`))
```

    ## Warning: 104237 failed to parse.

    ## Warning: 104237 failed to parse.

``` r
mes <- df %>%
    select(`Fecha Final`, Call, Cod) %>%
    group_by(month = lubridate::floor_date(`Fecha Final`, "month"), Cod) %>%  
    filter(Call == 1) %>%
    summarise(sum(Call)) 
```

    ## `summarise()` has grouped output by 'month'. You can override using the `.groups` argument.

``` r
mes = mes[-13, ] 
mayor <- which.max(mes$`sum(Call)`)
```

``` r
fecha <- mes[mayor,]$month
fecha <- as_tibble(fecha)
llamadas <- mes[mayor,]$`sum(Call)`
llamadas <- as_tibble(llamadas)
```

##### El mes que tiene la mayor cantidad de llamadas por códido es: 2017-05-01 (Mayo) con 314 llamadas

##### 2. ¿Qué día de la semana es el más ocupado?

``` r
dia <- df %>%
    select(`Fecha Final`, Call) %>%
    mutate(dia = weekdays(`Fecha Final`)) %>%
    group_by(dia) %>%  
    filter(Call == 1) %>%
    summarise(sum(Call))
```

``` r
dia = dia[-8, ] 
ocupado <- which.max(dia$`sum(Call)`)
```

``` r
dias <- dia[ocupado,]$dia
dias <- as_tibble(dias)
llamadas <- dia[ocupado,]$`sum(Call)`
llamadas <- as_tibble(llamadas)
```

##### El día más ocupado es: Wednesday con 532 llamadas

##### 3. ¿Qué mes es el más ocupado?

``` r
mesOcupado <- df %>%
          select(`Fecha Final`, Call, Email, SMS) %>%
          group_by(month = lubridate::floor_date(`Fecha Final`, "month")) %>%  
          summarise(sum(Call), sum(Email), sum(SMS))
```

``` r
mesOcupado = mesOcupado[-13, ] 
sumaTrabajo <- rowSums(mesOcupado[2:4])
mayor <- which.max(sumaTrabajo)
m <- max(sumaTrabajo)
m <- as_tibble(m)
```

``` r
fecha <- mesOcupado[mayor,]$month
fecha <- as_tibble(fecha)
```

##### El mes más ocupado es: 2017-03-01 (Marzo) con una carga de trabajo de 1.3813^{4} entre llamadas, email’s y SMS’s

##### 4. ¿Existe una concentración o estacionalidad en la cantidad de llamadas?

``` r
concentracion <- df %>%
              select(`Fecha Final`, Call,`Hora Final`) %>%
              mutate(hora = hour(`Hora Final`)) %>%
              mutate(mes = month(`Fecha Final`)) %>%
              filter(!is.na(mes)) %>%
              mutate(season = ifelse(mes %in% c(month(10), month(11), month(12)) , "Fall",
                              ifelse(mes %in% c(month(1), month(2), month(3)), "Winter",
                              ifelse(mes %in% c(month(4), month(5), month(6)), "Spring",
                              ifelse(mes %in% c(month(7), month(8), month(9)), "Summer",""))))) %>%
              group_by(season, hora) %>%
              summarise(sum(Call))
```

    ## `summarise()` has grouped output by 'season'. You can override using the `.groups` argument.

``` r
cantLlamadas <- which.max(concentracion$`sum(Call)`)
```

``` r
estacion <- concentracion[cantLlamadas,]$season
hora <- concentracion[cantLlamadas,]$hora
llamadas <- concentracion[cantLlamadas,]$`sum(Call)`

estacion <- as_tibble(estacion)
hora <- as_tibble(hora)
llamadas <- as_tibble(llamadas)
```

##### La concentración de llamadas se da en: Fall a las 0 horas con 62 llamadas

##### 5.¿Cuántos minutos dura la llamada promedio?

``` r
prom <- df %>%
      select(Call, `Hora Creación`, `Hora Final`) %>%
      filter(Call == 1) %>%
      mutate(x = `Hora Final` - `Hora Creación`) %>%
      mutate(x = minute(seconds_to_period(x))) %>%
      summarise(prmd = mean(x))
```

``` r
p <- prom$prmd
p <- as_tibble(p)
```

##### La llamada promedio dura: 14.5579039 minutos

## Parte 3: Signo Zodiacal

``` r
FechaNacimiento = ymd("2001-6-21")

print("Tu fecha de nacimiento es: ")
```

    ## [1] "Tu fecha de nacimiento es: "

``` r
FechaNacimiento
```

    ## [1] "2001-06-21"

``` r
if (month(FechaNacimiento) == 3 || month(FechaNacimiento) == 4  & day(FechaNacimiento) >= 20){ 
  print("Tu signo zodiacal es Aries") 
}else if (month(FechaNacimiento) == 4 || month(FechaNacimiento) == 5  & day(FechaNacimiento) >= 21){ 
  print("Tu signo zodiacal es Tauro") 
}else if (month(FechaNacimiento) == 5 || month(FechaNacimiento) == 6  & day(FechaNacimiento) >= 21){ 
  print("Tu signo zodiacal es Géminis")
}else if (month(FechaNacimiento) == 6 || month(FechaNacimiento) == 7  & day(FechaNacimiento) >= 22){ 
  print("Tu signo zodiacal es Cáncer")
}else if (month(FechaNacimiento) == 7 || month(FechaNacimiento) == 8  & day(FechaNacimiento) >= 23){ 
  print("Tu signo zodiacal es Leo")
}else if (month(FechaNacimiento) == 8 || month(FechaNacimiento) == 9  & day(FechaNacimiento) >= 23){ 
  print("Tu signo zodiacal es Virgo")
}else if (month(FechaNacimiento) == 9 || month(FechaNacimiento) == 10  & day(FechaNacimiento) >= 23){ 
  print("Tu signo zodiacal es Libra")
}else if (month(FechaNacimiento) == 10 || month(FechaNacimiento) == 11  & day(FechaNacimiento) >= 22){ 
  print("Tu signo zodiacal es Escorpión")
}else if (month(FechaNacimiento) == 11 || month(FechaNacimiento) == 12  & day(FechaNacimiento) >= 21){ 
  print("Tu signo zodiacal es Sagitario")
}else if (month(FechaNacimiento) == 12 || month(FechaNacimiento) == 1  & day(FechaNacimiento) >= 20){ 
  print("Tu signo zodiacal es Capricornio")
}else if (month(FechaNacimiento) == 1 || month(FechaNacimiento) == 2  & day(FechaNacimiento) >= 18){ 
  print("Tu signo zodiacal es Acuario")
}else if (month(FechaNacimiento) == 2 || month(FechaNacimiento) == 3  & day(FechaNacimiento) >= 19){ 
  print("Tu signo zodiacal es Piscis")
}
```

    ## [1] "Tu signo zodiacal es Géminis"

## Parte 4: Flights

##### 1. Genere 4 nuevas columnas para cada variable con formato fecha y hora.

``` r
f <- flights %>%
  mutate(departure = substr(as.POSIXct(sprintf("%04.0f", dep_time), format='%H%M'), 12, 16)) %>%
  mutate(arrival = substr(as.POSIXct(sprintf("%04.0f", arr_time), format='%H%M'), 12, 16)) %>%
  mutate(schedDept = substr(as.POSIXct(sprintf("%04.0f", sched_dep_time), format='%H%M'), 12, 16)) %>%
  mutate(schedArr = substr(as.POSIXct(sprintf("%04.0f", sched_arr_time), format='%H%M'), 12, 16)) 
f
```

    ## # A tibble: 336,776 × 23
    ##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
    ##  1  2013     1     1      517            515         2      830            819
    ##  2  2013     1     1      533            529         4      850            830
    ##  3  2013     1     1      542            540         2      923            850
    ##  4  2013     1     1      544            545        -1     1004           1022
    ##  5  2013     1     1      554            600        -6      812            837
    ##  6  2013     1     1      554            558        -4      740            728
    ##  7  2013     1     1      555            600        -5      913            854
    ##  8  2013     1     1      557            600        -3      709            723
    ##  9  2013     1     1      557            600        -3      838            846
    ## 10  2013     1     1      558            600        -2      753            745
    ## # … with 336,766 more rows, and 15 more variables: arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
    ## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>,
    ## #   departure <chr>, arrival <chr>, schedDept <chr>, schedArr <chr>
