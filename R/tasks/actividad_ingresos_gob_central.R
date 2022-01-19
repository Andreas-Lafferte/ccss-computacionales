# Actividad subsetting base de datos --------------------------------------

ingresos_gob_central <- data.frame(Concepto = c("Ingreso", "Ingreso tributario neto",
                                               "Cobre bruto", "Rentas de la propiedad",
                                               "Ingresos de operación"),
                                   Junio = c(3733041, 2757722, 461533, 25646, 73921),
                                   Julio = c(4140273, 3254655, 291577, 37084, 78197))

head(ingresos_gob_central)

# 1. Seleccionar solo el mes[**junio**]().
ingresos_gob_central[,2]
ingresos_gob_central$Junio

# 2. Seleccionar las [**rentas de propiedad**]() en el mes de [**julio**]().
ingresos_gob_central[4,c(3)]

# 3. Seleccionar [**columna 1**]() mediante [**operador $**]().
ingresos_gob_central$Concepto

# 4. Seleccionar[**ingresos tributario netos**]() en el mes de [**julio**]().
ingresos_gob_central[2,c(3)]

# 5. Seleccionar las [**rentas de la propiedad**]() y el mes [**julio**]().
ingresos_gob_central[4,c(3)]






