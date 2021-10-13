# Librerias
library(readr)
library(dplyr)
library(lubridate)

# Cargar dataset
df <- read.csv("c1.csv")

# Ver dataset
View(df)

#---- DESCRIPCION COLUMNAS
#id = postes
#que tipo de vehículo se usó para la verificacion (cod)
# origen = de donde dale el vehículo
# intervalos de numeros (ultimas columnas) = distancia del origen al poste (minutos o km)
# no se analiza ingreso por energía electrica sino por mantenimiento 

#directo = costo directo del mantenimiento ()
#fijo = costo ajeno al mantenimiento (independeintemente del negocio, se pagan)
# height = 
#--------------

##### Limpieza de datos
df <- df %>%
  mutate(factura = gsub("^ Q-   ", "",factura)) %>% mutate(factura = gsub("^ Q", "",factura)) %>%
  mutate(Camion_5 = gsub("^ Q-   ", "",Camion_5)) %>% mutate(Camion_5 = gsub("^ Q", "",Camion_5)) %>%
  mutate(fijoCamion_5 = gsub("^ Q-   ", "",fijoCamion_5)) %>% mutate(fijoCamion_5 = gsub("^ Q", "",fijoCamion_5)) %>%
  mutate(directoCamion_5 = gsub("^ Q-   ", "",directoCamion_5)) %>% mutate(directoCamion_5 = gsub("^ Q", "",directoCamion_5)) %>%
  mutate(Pickup = gsub("^ Q-   ", "",Pickup)) %>% mutate(Pickup = gsub("^ Q", "",Pickup)) %>%
  mutate(fijoPickup = gsub("^ Q-   ", "",fijoPickup)) %>% mutate(fijoPickup = gsub("^ Q", "",fijoPickup)) %>%
  mutate(directoPickup = gsub("^ Q-   ", "",directoPickup)) %>% mutate(directoPickup = gsub("^ Q", "",directoPickup)) %>%
  mutate(Moto = gsub("^ Q-   ", "",Moto)) %>% mutate(Moto = gsub("^ Q", "",Moto)) %>%
  mutate(fijoMoto = gsub("^ Q-   ", "",fijoMoto)) %>% mutate(fijoMoto = gsub("^ Q", "",fijoMoto)) %>%
  mutate(directoMoto = gsub("^ Q-   ", "",directoMoto)) %>% mutate(directoMoto = gsub("^ Q", "",directoMoto)) %>%
  
  mutate(Camion_5 = as.integer(Camion_5)) %>% mutate(Pickup = as.numeric(Pickup)) %>% mutate(Moto = as.numeric(Moto)) %>%
  mutate(fijoCamion_5 = as.numeric(fijoCamion_5)) %>% mutate(fijoPickup = as.numeric(fijoPickup)) %>%
  mutate(fijoMoto = as.numeric(fijoMoto)) %>%
  
  mutate(directoCamion_5 = as.numeric(directoCamion_5)) %>%
  mutate(directoPickup = as.numeric(directoPickup)) %>%
  mutate(directoMoto = as.numeric(directoMoto)) %>%
  mutate(factura = as.integer(factura)) %>%
  
  mutate(Fecha = sub("(.{6})(.*)", "\\120\\2", Fecha)) %>%
  mutate(Fecha = as_date(Fecha, format = "%d-%m-%Y")) %>%
  
  replace(is.na(.), 0) %>%
  mutate(tipoVehiculo = ifelse((Camion_5 != 0),"Camion",
                        ifelse((Pickup != 0),"Pickup",
                        ifelse((Moto != 0),"Moto","")))) %>%
  mutate(distancia = ifelse(X5.30 == " x ", "5-30",
                     ifelse(X30.45 == " x ", "30-45",
                     ifelse(X45.75 == " x ", "45-75",
                     ifelse(X75.120 == " x ", "75-120",
                     ifelse(X120. == " x ", "120+", ""))))))

df$X <- NULL
df$X.1 <- NULL
df$X.2 <- NULL
df$X.3 <- NULL
df$X.4 <- NULL
df$X.5 <- NULL

View(df)

##### Análisis
#--- Estado de resultados 2017

# Facturacion de 2017 (ventas)
facturacion <- sum(df$factura)
facturacion

# Costo de ventas
cVentas <- sum(df$directoCamion_5) + sum(df$directoMoto) + sum(df$directoPickup) + sum(df$fijoCamion_5) + sum(df$fijoMoto) + sum(df$fijoPickup)
cVentas

# Utilidad 
utilidad <- facturacion - cVentas
utilidad

#--- facturación en el 2017 por vehiculo
facturacionPorTipoVehiculo <- df %>%
    select(tipoVehiculo, factura) %>%
    group_by(tipoVehiculo) %>%
    summarise(facturacion = sum(factura))
facturacionPorTipoVehiculo

#--- facturación en el 2017 por servicio
facturacionPorCod <- df %>%
  select(Cod, factura) %>%
  group_by(Cod) %>%
  summarise(facturacion = sum(factura))
facturacionPorCod


#--- Margen de ganancia por vehículo
#Costo total por vehiculo (unidad)
costoPorTipoVehiculo <- df %>%
  select(tipoVehiculo, directoCamion_5, fijoCamion_5, directoPickup, fijoPickup, directoMoto, fijoMoto) %>%
  group_by(tipoVehiculo) %>%
  summarise(costo = sum(directoCamion_5+fijoCamion_5)+
                    sum(directoPickup+fijoPickup)+
                    sum(directoMoto+fijoMoto))
costoPorTipoVehiculo

#Margen de utilidad por vehiculo (unidad)
margenUtilidad <- data.frame(facturacionPorTipoVehiculo, costoPorTipoVehiculo)
margenUtilidad$margen <- (margenUtilidad$facturacion - margenUtilidad$costo)
margenUtilidad


#--- Tarifario en el 2017 por unidad
#Si se cobra por km recorrido:
# tarifario = valor de la venta (factura) por km
# factura/km recorridos = valor por km


#--- Cuanto podríamos perderle a un mantenimiento/reparación
#Costo maximo por servicio (Cod)
costoMaxPorServicio <- df %>%
  select(Cod, directoCamion_5, fijoCamion_5, directoPickup, fijoPickup, directoMoto, fijoMoto) %>%
  group_by(Cod) %>%
  summarise(costo = max(directoCamion_5+fijoCamion_5)+
                    max(directoPickup+fijoPickup)+
                    max(directoMoto+fijoMoto))
costoMaxPorServicio

#Facturación minima por servicio
facturacionMinPorCod <- df %>%
  select(Cod, factura) %>%
  group_by(Cod) %>%
  summarise(facturacion = min(factura))
facturacionMinPorCod

#Lo menos que puedo cobrar
perdida <- data.frame(costoMaxPorServicio, facturacionMinPorCod)
perdida$Perdida <- (perdida$facturacion - perdida$costo)
perdida


#--- Estamos en números rojos en 2018
#--- Estado de resultados 2018

# Facturacion de 2018 (ventas)
ventas9meses2018 <- df %>%
  select(Fecha, factura) %>%
  filter(Fecha <= "2017-09-30")%>%
  summarise(facturacion = sum(factura)*0.75)
ventas9meses2018

#Costo de ventas 2018
costoVenta <- df %>%
  select(directoCamion_5, directoMoto, directoPickup, fijoCamion_5, fijoPickup, fijoMoto, Fecha) %>%
  filter(Fecha <= "2017-09-30")%>%
  summarise(ctV = sum(fijoCamion_5) + sum(fijoPickup) + sum(fijoMoto)
            +sum(directoCamion_5) + sum(directoPickup) + sum(directoMoto))
costoVenta

# Utilidad 
utilidad2018 <- ventas9meses2018 - costoVenta
utilidad2018




#--- Crecimiento del 10% para el 2019
MargenVenta <- (utilidad/facturacion)*100
MargenVenta



#--- 80-20
ventasTotales <- sum(df$factura)
df %>%
  select(Cod, factura) %>%
  group_by(Cod) %>%
  summarise(ingresoServicio = sum(factura)) %>%
  summarise(`%Utilidad` = (ingresoServicio * 100)/ventasTotales, Cod) %>%
  arrange(desc(`%Utilidad`))


#--- Recorridos más efectivos.
#Costo por distancia
CostoRecorrido <- df %>%
  select(distancia, Camion_5, Moto, Pickup) %>%
  group_by(distancia) %>%
  summarise(costo = sum(Camion_5)+sum(Moto)+sum(Pickup))
CostoRecorrido
















