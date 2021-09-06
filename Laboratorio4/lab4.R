# Librerias
library(readr)
library(dplyr)
library(highcharter)

# Cargar dataset
df <- read_delim("tabla_completa.csv", delim = ",", escape_double = TRUE, trim_ws = TRUE)

# Ver dataset
View(df)

# ---------- 
# ¿Debemos invertir en la contratación de más personal?
# ---------- 

# Cuantos pilotos contratados hay
df %>%
  summarise(total_pilotos = n_distinct(PILOTO))

# Cuantos viajes hace cada piloto por año
viajes_por_piloto <- df %>%
  select(COD_VIAJE, PILOTO, ANIO) %>%
  group_by(PILOTO, ANIO) %>%
  summarise(total_viajes = n_distinct(COD_VIAJE))

View(viajes_por_piloto)

# Cuantos viajes hace cada piloto por año
viajes_por_piloto_mes <- df %>%
  select(COD_VIAJE, PILOTO, MES) %>%
  group_by(PILOTO, MES) %>%
  summarise(total_viajes = n_distinct(COD_VIAJE))

View(viajes_por_piloto_mes)

# Cuanto dinero representan todos los trabajadores
sum(df$Q)

# Cuantos clientes se atienden 
df %>%
  summarise(total_clientes = n_distinct(CLIENTE))




# ---------- 
# ¿Debemos invertir en la compra de más vehículos de distribución? ¿Cuántos y de que tipo?
# ---------- 

# Con cuantos tipos de vehículos se cuenta
df %>%
  summarise(total_tiposVehiculos = n_distinct(UNIDAD))

# Que tipo de vehículo hace más entregas
viajes_por_unidad <- df %>%
  select(COD_VIAJE, UNIDAD, ANIO) %>%
  group_by(UNIDAD, ANIO) %>%
  summarise(total_viajes_por_vehiculo = n_distinct(COD_VIAJE))

View(viajes_por_unidad)

# Que tipo de vehículo usa cada piloto
tipo_vehiculo <- df %>%
  group_by(PILOTO, UNIDAD) %>%
  summarise(tipo_unidad = n_distinct(UNIDAD))

View(tipo_vehiculo)




# ---------- 
# Las tarifas actuales ¿son aceptables por el cliente?
# ---------- 

#	Cuantos creditos diferentes hay
df %>%
  group_by(CREDITO) %>%
  summarise(total_creditos = n_distinct(CREDITO))

# Cuantos clientes pagan a que tipo de credito
credito_clientes <- df %>%
  group_by(CLIENTE, CREDITO) %>%
  summarise(tipo_credito = n_distinct(CREDITO))

View(credito_clientes)





