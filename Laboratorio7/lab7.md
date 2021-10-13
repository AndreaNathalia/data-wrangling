Lab 7
================
Andrea Reyes
10/10/2021

## Análisis - Inversiones en Energía, S.A.

#### Estado de resultados 2017

``` r
# Facturacion de 2017 (ventas)
facturacion <- sum(df$factura)
facturacion <- as_tibble(facturacion)
```

``` r
# Costo de ventas
cVentas <- sum(df$directoCamion_5) + sum(df$directoMoto) + sum(df$directoPickup) + sum(df$fijoCamion_5) + sum(df$fijoMoto) + sum(df$fijoPickup)
cVentas <- as_tibble(cVentas)
```

``` r
# Utilidad 
utilidad <- facturacion - cVentas
utilidad <- as_tibble(utilidad)
```

Ventas = 36557571

Costo de ventas = 2.8174019^{7}

Utilidad = 8.3835519^{6}
