library(lubridate)
library(nycflights13)
library(tidyverse)

# Hoy y ahora
today()
now()

# Parsear fechas de texto
x <- "1994 October 27th"
ymd(x)

y <- "27.10.1994"
dmy(y)

z <- "oct, 27th 1994 14:00"
mdy_hm(z)

a <- 19942710
ymd(a)

# Operaciones con tiempo

# Diferecnias
#La fecha de aterrizaje y el primer paso en la luna
date_landing <- mdy("July 20, 1969")
moment_step <- mdy_hms("July 20, 1969, 02:56:15", tz = "UTC")

difftime(now(), moment_step, units="days")

# Suma de tiempos
mon_1p <- dmy_hm("27 sep 2021 13:00")
mon_1p + weeks(x=1)

# Consideraciones importantes

## Durations: cronometro
## Periods: general, como hablamos

feb <- dmy("28 feb 2020")
feb + dyears(1)
feb + years(1)

# Si se suma un mes al 31 de de enero de 2021, ¿qué devuelve?
ymd("2020-01-31") + months(1)
this_jan <- ymd("2020-01-31")
add_with_rollback(this_jan, months(1), roll_to_first = TRUE) #1er día del mes (inicio de mes)
add_with_rollback(this_jan, months(1), roll_to_first = FALSE) #ultimo día del mes (fin de mes)


# Generar secuencia de fechas
jan_31 <- ymd("2021-01-31")
oct_31 <- ymd("2021-10-31")

# Secuencia de 1 a 12 periods de un mes
month_seq <- 1:12 * months(1)
month_seq + jan_31

month_seq

seq(jan_31, oct_31, "weeks")


# Flights
View(flights)
    
flights %>%
  select(year, month, day, hour, minute, arr_time)

# make_date
make_date(year = 1995, month = 11, day = 21)


flights <- flights %>%
  mutate(departure = make_date(year, month, day))

flights$departure


# make_datetime
    
flights <- flights %>%
  mutate(departure = make_datetime(year, month, day, minute))

flights$departure




