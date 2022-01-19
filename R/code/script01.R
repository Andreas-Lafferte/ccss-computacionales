# Atajos ------------------------------------------------------------------

# Comentarios en R

# Cmd + Shift + C (Mac) 
# Ctrl + Shift + C (Windows).

# Seccionar líneas de código

# Cmd + Shift + R (Mac) 
# Ctrl + Shift + R (Windows).

# Instalar y leer librería

# install.packages("nombre del paquete")
# library("nombre de librería")

# Ejecutar una línea de código

# Opción 1: Click en botón Run 
# Opción 2: Ctrl + Enter (Windows)
# Opción 3: Cmd + Enter (Mac)

# Introducción a R --------------------------------------------------------

# R como calculadora 

5+5
25/5
2*2
27-2

# Operatoria con más cálculos

sqrt(2^4 + exp(3)/55 - log(5*8-2))
12*(7+2)+(45-32)+8
30-(-2)*(-10)+(-5)*(-2)
520 + 202 * log(25)
2 + 4 * exp(3)
22^2 - 2^2
5 + (5 * 10 + 2 * 3)
log(5) + pi/sqrt(5)
52 + 203 + 1002 + 204

# R como calculadora lógica

20 == 5 # igualdad
30 >= 14 # mayor o igual que
22 <= 2 # menor o igual que
25 != 10 # no es igual a
p = 10; y = 5; p <= y # operatoria en objetos

# Actividad 1: Cálculo aritmético -------------------------------------------------------------

520 + 202 * log(25)
2 + 4 * exp(3)
2^2* sqrt(2)
5 + (5 * 10 + 2 * 3)^2
log(5) + pi/sqrt(5)
5**2 + 20**3 + 100**2 + 20**4

# Actividad 2: Lógica orientada a objetos -------------------------------------------------------------

# ¿Cuál es el valor de a y b? Si a <- 5; b <- a; a <- 4

a <- 5
b <- a
a <- 4
print(a)

# Sea x = 30, w = 5 y z = a^2, ¿qué resultado obtenemos de x * y + z?

x <- 30
w <- 5
z <- a^2
z*y+z

# Almacenar en un objeto el resultado anterior llamado variable_1.

variable_1 <- z*y+z

# ¿Qué resultado obtenemos al dividir variable_1 y z?

variable_1/z

# Asignar el valor 20000 a la variable presupuesto_2020

presupuesto_2020 <- 20000

# Ejecutar variable presupuesto_2020

presupuesto_2020

# Asignar el valor 30000 a la variable presupuesto_2021

presupuesto_2021 <- 30000

# Ejecutar la variable presupuesto_2021

presupuesto_2021

# Crear nueva variable que sea la sumatoria de presupuesto_2020 y presupuesto_2021

presupuesto_global <- presupuesto_2020 + presupuesto_2021

# Actividad 3: secuencias y repeticiones ----------------------------------

# Construya las siguientes repeticiones usando la función rep, no lo haga ingresando número por número.

# 1 2 3 4 1 2 3 4
rep(1:4, times = 2)
rep(seq(from = 1, to = 4, by = 1), 2)
secuencia <- c(1:4, 1:4)

# 1 1 2 2 3 3 4 4
rep(1:4, each = 2)
rep(1:4, times = c(2,2,2,2))

# 1 1 2 3 3 4
rep(1:4, times = c(2, 1, 2, 1))

# 1 1 2 2 3 3
rep(1:3, each = 2)

# Una secuencia de dos en dos comenzando en 1 y finalizando en 200.
seq(from = 1, to = 200, by = 2)
1:200

# Crear un vector con los números de 1 a 17 y extraer los números que son mayores o iguales a 12.
1:17 > 12 # Nos entrega el valor lógico.
which(seq(from = 1, to = 17, by = 1) > 12) # Para entregar la observación y no la posición.
which(1:17 > 12) 

# Actividad 4: Contagios covid --------------------------------------------

# Número de casos Covid-19 diarios según Comuna.

Las_Condes <- c(80, 90, 50, 40, 35)
La_Florida <- c(75, 68, 50, 90, 98)

# Crear vector que contenga los días de la semana.
Dias_contagios <- c("Lunes", "Martes", "Miércoles", "Jueves", "Viernes")

# Asignar los días de la semana al vector Las_Condes y vector La_Florida.
names(Las_Condes) <- Dias_contagios
names(La_Florida) <-  Dias_contagios

# Calcule el total de contagios semanales por comuna.
Total_Las_Condes <- sum(Las_Condes)
Total_La_Florida <- sum(La_Florida)

# Determinar si los contagios en Las Condes son mayores a La Florida

Total_Las_Condes > Total_La_Florida

# Determinar qué día de la semana se encuentra la mayor cantidad de contagios, 
# según comuna.

Las_Condes[which.max(Las_Condes)]
La_Florida[which.max(La_Florida)]

# Elementos adicionales. 

# ¿Qué días fueron mayores a 75 casos diarios por cada comuna?

Las_Condes[which(Las_Condes > 75)]
La_Florida[which(La_Florida > 75)]

names(Las_Condes)[Las_Condes > 75]
names(La_Florida)[La_Florida > 75]

# ¿Qué días fueron menores a 40 casos en la comuna de Las Condes?
Las_Condes[which(Las_Condes < 40)]

# ¿Qué días fueron menores a 68 casos en la comuna de La Florida?
Las_Condes[which(Las_Condes > 68)]

# Actividad 5: Subsetting -------------------------------------------------

Conteo <- data.frame(Candidato = c("Kast", "Boric"),
                     Votos = c("64000", "78000"),
                     Mesas = c("Mesa1", "Mesa1"))

# 1. Seleccionar solo la columna votos
Conteo[, "Votos"]
Conteo[, 2]

# 2. Seleccionar la fila 1 y columna 1 y 2.
Conteo[1, c(1:2)]
Conteo[1, c(1,2)]
Conteo[1, c("Candidato", "Votos")]

# 3. Seleccionar columna 2 mediante operador $.
Conteo$Votos

# 4. Selccionar la fila 1 y columna 1 y 3.
Conteo[1, c(1,3)]
Conteo[1, c("Candidato", "Mesas")]

# 5. Seleccionar fila 2, además de la columna 3.
Conteo[2, 3]