# Stock de deuda bruta gob central ----------------------------------------

# 1. Cifras de deuda interna y externa.

deuda_interna <- c(70417.1, 58575.6, 55703.2, 56128.7, 43284.6)
deuda_externa <- c(21208.1, 15815.6, 14544.3, 12807.5, 10080.8)

# 2. Crear vector numérico llamado año, que considere desde el año 2016 al 2020.
ano <- 2016:2020

# 3. Asignar los años a la deuda interna y deuda externa.
names(deuda_externa) <- ano
names(deuda_interna) <- ano

# 4. Calcule el total de deuda interna por todos los años.
sum(deuda_interna)
sum(deuda_externa)

# 5. Determinar si la deuda interna es mayor o igual que la deuda externa.
sum(deuda_interna) >= sum(deuda_externa)

ifelse(sum(deuda_interna) >= sum(deuda_externa), T, F)

# 6. Determinar en qué año se encuentra la mayor deuda interna y externa.
deuda_externa[which.max(deuda_externa)]
deuda_interna[which.max(deuda_interna)]

# 7. Calcular porcentaje de variación de la deuda interna para el año 2020.
sd(deuda_interna)/mean(deuda_interna)*100
