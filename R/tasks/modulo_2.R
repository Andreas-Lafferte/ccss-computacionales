# Recordatorio ------------------------------------------------------------

5+5
10*2
12*(7+2)+(45-32)+8
2 + 4 * exp(3)
c(1,2,3)^2 
sqrt(2^4 + exp(3)/55 - log(5*8-2))
22^2 - 2^2
10 == 10 
30 != 20
16 >= 12 
22 <= 12 

seq(from = 1, to = 200, by = 2)
rep(5, times = 20)
variable <- 2000:2022
rep(variable, each = 3)
rep(seq(1,20,1), 3)

# Vectores ----------------------------------------------------------------

variable_1 <- c(rep("Sociología", 3), "Ciencia Política")
variable_2 <- c("Juan", "Andreas", "Natalia", "Daniel")
variable_3 <- c(30,28,27,31)

# Data frame --------------------------------------------------------------

datos <- data.frame(carrera = variable_1,
           nombre = variable_2,
           edad = variable_3)
datos

# Subsetting --------------------------------------------------------------

paises <- datos::paises

paises$anio >= 2000 #retornamos TRUE y FALSE
paises[paises$anio >= 2007,] 
paises[paises$anio >= 2007, c(1,3),]  #retornemos solo los países y el filtro.
paises[paises$esperanza_de_vida >= 80, c("pais", "continente"),]
paises[paises$pib_per_capita >= 1000 & paises$continente == "Europa",]
paises[!(paises$pib_per_capita >= 1000 & paises$continente == "Europa"),]
subset(x = paises, subset = pais == "Chile", select = c(1:5))

# Instalar librerías ------------------------------------------------------

# install.packages("tidyverse")
# install.packages("openintro")

# Cargar librerías 
library(tidyverse)
library(openintro)

# Cargar datos y almacenar en 2 vectores diferentes.

oscars <- openintro::oscars

# Vamos a observar nuestras bases de datos.
View(oscars)

# Vamos a ver la estructura y la naturaleza de las variables.
# Objetivo: identificar si la naturaleza de la variable es correcta.

str(oscars)
glimpse(oscars)
sapply(data, class)
skimr::skim(data)

# Exploración de los nombres de la base
names(oscars)

# Select ------------------------------------------------------------------
# Extrae o selecciona variables.

# Seleccionar solo una variable.
oscars %>% dplyr::select(oscar_yr)

# Lo mismo que lo anterior pero con comandos por defecto
oscars[, "oscar_yr"]
oscars[, 2]

# Seleccionar 4 variables en específico.
oscars %>% dplyr::select(award, movie, name, age) 

# Seleccionar 3 variables en específico, pero con los comandos por defecto.
oscars[, c("award", "movie", "age")]

# Seleccionar de acuerdo a la posición (ubicación) de la variable.
oscars %>% dplyr::select(1, 2, 3)

# Lo mismo que lo anterior, pero por defecto
oscars[c(1,2,3)]

# Seleccionar todas las variables, con excepción de las que figuran en la c().
oscars %>% dplyr::select(-c(birth_date))

# Lo mismo que lo anterior, pero por defecto
oscars[-c(8),]

# Seleccionar de acuerdo a un orden en específico. Everything se refiere a "todas las demás".
oscars %>% dplyr::select(name, everything())

# Seleccionar todas las variables que comiencen con la letra M.
oscars %>% dplyr::select(name, starts_with(match = "birth"))

# Seleccionar todas las variables que finalicen con la letra E.
oscars %>% dplyr::select(ends_with(match = "e"))

# Seleccionar con una condición lógica. Es decir, cuando las variables sean de tipo numérico.
oscars %>% dplyr::select_if(is.numeric)

# Otro mecanismo para una selección lógica.
oscars %>% dplyr::select(where(is.numeric))

# Parametrizando un criterio de selección
variables <- names(oscars)[c(3:5)]
oscars %>% dplyr::select(-all_of(variables)) 

# Actividad 1 -------------------------------------------------------------

names(oscars)

# Seleccionar año del premio, nombre de actor y película
oscars %>% select(oscar_yr, name, movie)

# Seleccionar las columna 2, 4, 6 de la base de datos.
oscars %>% select(c(2,4,6))

# Seleccionar todas las variables, con excepción de columna 1 y 6.
oscars %>% select(-c(1,6))

# Eliminar todas las columnas que comiencen con "birth".
oscars %>% select(!starts_with(match = "birth"))

# Filter ------------------------------------------------------------------
# Filtra las variables de acuerdo a condiciones lógicas.

# Veamos los valores que poseen las variables de tipo cualitativo.

# Tabla de frecuencia para contabilizar los valores.
table(oscars$award)

# Visualizar los valores únicos que posee la variable.
unique(oscars$name)

# Filtrar cuando el año sea mayor o igual a 2015.
oscars %>% dplyr::filter(award >= 2015)
oscars[oscars$award >= 2015,]

# Lo mismo que lo anterior, pero con los comandos por defecto (escuela antigua).
oscars[oscars$award >= 2015,]

# Filtrar cuando el premdio sea de tipo mejor actriz.
oscars %>% dplyr::filter(award == "Best actress")

# Lo mismo que lo anterior, pero con los comandos por defecto (escuela antigua).
oscars[oscars$award == "Best actress",]

# Filtrar cuando la vedad sea mayor o igual a 50 y año del premio mayor a 2000
oscars %>% dplyr::filter(age >= 50 & oscar_yr  >= 2000)

# Lo mismo que lo anterior, pero con escuela antigua
oscars[oscars$age >= 50 & oscars$oscar_yr >= 2000,]

# Filtrar cuando la variable edad esté entre el año 2009 y 2017.
oscars %>% dplyr::filter(between(age, 20, 30) & award == "Best actress")
oscars[oscars$age >= 20 & oscars$age <= 30 & oscars$award == "Best actress",]

# Filtrar cuando el año del oscar sea el más reciente. Aquí utilizamos la función max.
oscars %>% dplyr::filter(oscar_yr == max(oscar_yr, na.rm = TRUE))


# Actividad 2: Filter ------------------------------------------------------------------

# ¿Quiénes ganaron oscars en el año más reciente?
oscars %>% dplyr::filter(oscar_yr == max(oscar_yr, na.rm = T))

# Actrices, menores de 25 años, que hayan ganado oscar
oscars %>% dplyr::filter(award == "Best actress" & age <= 25) 

# ¿Cuántos oscars ganó Meryl Streep?
oscars %>% dplyr::filter(name == "Meryl Streep") 

# En qué películas ganó oscar De Niro y Al Pacino
oscars %>% dplyr::filter(name %in% c("Robert De Niro",
                                     "Al Pacino"))
# Otra opción para lo anterior 
oscars %>% filter(stringr::str_detect(name, pattern = "De Niro")) # detectar patron de texto

# Actores que hayan ganado oscar entre los 30 y 40 años.
oscars %>% dplyr::filter(award == "Best actor", between(age, 30, 40))
oscars %>% dplyr::filter(award == "Best actor", age > 30 & age <= 40)

# Actor o actriz que ha recibido el premio con mayor edad.

oscars %>% dplyr::filter(age == max(age))
oscars[which.max(oscars$age),][4]

# Mutate ------------------------------------------------------------------

# Cuánto tiempo pasó desde que nació hasta que obtuvo el oscar
oscars %>% 
  dplyr::mutate(tiempo_oscar =  oscar_yr - birth_y) %>% view()

# Crear nueva variable con ifelse
oscars %>% 
  dplyr::mutate(award = ifelse(award == "Best actress", 
                               "Mejor actriz", "Mejor Actor"))

# Crear nueva variable con case_when
oscars %>% 
  dplyr::mutate(award = dplyr::case_when(award == "Best actress" ~ 
                                           "Mejor actriz",
                                         TRUE ~ "Mejor actor"))

# Si no se entendio, otro ejemplo

NSE <- data.frame(ID = paste("ID", seq(1, 6)),
                  Ministerio = c(1,1,2,3,4,5))

NSE %>% dplyr::mutate(Ministerio = ifelse(Ministerio == 1, "Agricultura", "Otro ministerio"))

# Otros mecanismos, como comenté en clases:
NSE %>% dplyr::mutate(Ministerio = case_when(Ministerio == 1 ~ "Agricultura", 
                                             Ministerio == 2 ~ "Hacienda", 
                                             Ministerio == 3 ~ "Economía", 
                                             TRUE ~ "Otro ministerio"))

NSE %>% dplyr::mutate(Ministerio= gsub(pattern = "3", replacement = "Economía", x = Ministerio)) # valor 3 en variable ministerio reemplazalo por cierto valor

NSE %>% dplyr::mutate(Ministerio = stringr::str_replace(string = Ministerio, 
                                                        pattern = "1", replacement = "Agricultura")) # ahora es string reemplazar 

# Dejar todas las observaciones en mayúsculas
oscars %>% dplyr::mutate_all(stringr::str_to_upper)

# Convertir todas las variables a caracter
oscars %>% dplyr::mutate_all(as.character)

# Convertir variables de una naturaleza a otra
oscars %>% dplyr::mutate_if(is.character, as.factor) 

# Paréntesis: aprendamos otra técnica de data wranling con unite.

names(oscars)
unite <- tidyr::unite(data = oscars, col = "Cumpleaños", c(birth_d, birth_mo, birth_y), sep = "-") # creamos var cumpleaños y dentro de c() damos los valores que tiene la variable, en este caso las fechas
tidyr::separate(data = unite, col = Cumpleaños, into = c("birth_d", "birth_mo", "birth_y"))

# Actividad 3:  ------------------------------------------------------------------
# Calcular edad actual de ganadores de oscars

oscars %>% 
  dplyr::mutate(diferencia_dias = Sys.Date() - birth_date,
                edad_actual = as.numeric(round(diferencia_dias/365), digits = 0)) %>% 
  dplyr::select(diferencia_dias, edad_actual) 

oscars %>% 
  dplyr::mutate(diferencia_dias = as.numeric(difftime(Sys.Date(), birth_date)),
                edad_actual = round(diferencia_dias/365))  %>% 
  dplyr::select(edad_actual, diferencia_dias) 


# Group_by ----------------------------------------------------------------
# Agrupa variables de tipo categórico.

# Contabilizar los premios a mejor actor y actriz
oscars %>% dplyr::group_by(award) %>% dplyr::count()

# Contabilizar premios según actor
oscars %>% 
  dplyr::filter(award == "Best actor") %>% 
  dplyr::group_by(name) %>% 
  dplyr::count()

# Actividad 4: Group_by ----------------------------------------------------------------

# De la base oscar, agrupar por nombre y contabilizar el numero de 
# óscars.

oscars %>% 
  dplyr::filter(award == "Best actor") %>% 
  dplyr::group_by(name) %>% 
  dplyr::count() %>% 
  dplyr::arrange(desc(n)) %>% 
  dplyr::filter(n >= 2)

# Summarize ---------------------------------------------------------------
# Realiza resumen de los datos.

oscars %>% 
  dplyr::filter(name %in% c("Robert De Niro", "Leonardo Di Caprio", "Meryl Streep",
                            "Jennifer Lawrence", "Nicole Kidman")) %>%
  dplyr::group_by(name) %>% 
  dplyr::summarize(n = n())

# Actividad 5 -------------------------------------------------------------

library(tidyverse)
resumen <- oscars %>% 
  dplyr::select(!starts_with(match = "b")) %>% 
  dplyr::group_by(award) %>% 
  dplyr::summarise(oscars = n(),
                   promedio_edad = mean(age, na.rm = TRUE),
                   mediana_edad = median(age, na.rm = TRUE),
                   Q1 = quantile(age, probs = 0.25),
                   Q3 = quantile(age, probs = 0.75),
                   sd = sd(age, na.rm = TRUE),
                   min = min(age, na.rm = TRUE),
                   max = max(age, na.rm = TRUE)) %>% 
  dplyr::rename(premio = award) %>% 
  dplyr::mutate(premio = ifelse(premio == "Best actor", "Mejor actor",
                                "Mejor actriz"))
# Almacenar en una planilla Excel

if(!dir.exists("datos")) dir.create("datos")

writexl::write_xlsx(x = resumen, path = "datos/resumen.xlsx")


# Actividad 6 -------------------------------------------------------------

titanic <- data.frame(Titanic)

titanic %>% 
  dplyr::rename(Clase = Class,
                Sexo = Sex,
                Edad = Age,
                Sobrevive = Survived) %>% 
  dplyr::group_by(Clase) %>% 
  dplyr::filter(Sobrevive == "Yes") %>% 
  dplyr::summarise(Sobrevivientes = sum(Freq)) %>% 
  dplyr::mutate(Prop = round(Sobrevivientes/sum(Sobrevivientes), 2),
                Ranking = min_rank(desc(Prop))) %>% 
  dplyr::arrange(Ranking) 


# Material adicional que agrego para su formación:
# Cruce de base de datos --------------------------------------------------

base_1 <- data.frame(Tipo = c("IPA","Lager","Porter", "Lambic"), 
                     Lupulo = c("Alto","Medio","Medio", "Bajo"),
                     Premios = c(4, 3, 2, 4), 
                     IBU = c(93.2, 38.5, 55.2, 63.5))

base_2 <- data.frame(Tipo = c("IPA","Lambic", "Porter", "Weissbier"), 
                     Caracter = c("Amarga", "Amarga", "Ácido", "Ácido"),
                     Acentuacion = c("Lúpulo-frutal", "Terroso-frutal", "Chocolate-tostado", 
                                     "Cítrico-trigo"),
                     Origen = c("Inglaterra", "Estados Unidos", "Inglaterra", "Alemania"), 
                     Amargura = c("9", "7", "6", "4"))

# Left_join ---------------------------------------------------------------
# Toma como referencia las observaciones de la tabla 1.

merge(x = base_1, y = base_2, all.x = T, all.y = F)
a <- dplyr::left_join(base_1, base_2, by = "Tipo")
dplyr::left_join(base_1, base_2, by = c("Tipo" = "Tipo"))
dplyr::left_join(base_1, base_2)

# Right_join --------------------------------------------------------------
# Toma como referencia las observaciones de la tabla 2

dplyr::right_join(x = base_1, y = base_2, by = c("Tipo" = "Tipo")) 
dplyr::right_join(base_1, base_2) 
dplyr::right_join(base_1, base_2, by = "Tipo")

# Inner_join --------------------------------------------------------------
# Toma como referencia solamente los campos donde existan las mismas observaciones

dplyr::inner_join(x = base_1, y = base_2, by = c("Tipo" = "Tipo"))
dplyr::inner_join(base_1, base_2, by = "Tipo")
dplyr::inner_join(x = base_1, y = base_2)

# Full_join ---------------------------------------------------------------
# Retorna todas las grabaciones en una nueva base de datos, independiente de si 
# figuran en ambas bases. 

dplyr::full_join(x = base_1, y = base_2, by = c("Tipo" = "Tipo"))
dplyr::full_join(x = base_1, y = base_2, by = "Tipo")
dplyr::full_join(base_1, y = base_2)

# Bind_rows ---------------------------------------------------------------

Tipo_1 <- data.frame(Tipo = c("IPA","PORTER", "LAMBIC"),
                     Premios = c(4, 3, 4), 
                     IBU = c(93.2, 38.5, 63.5))

Tipo_2 <- data.frame(Tipo = c("BOCK","STOUT", "WEISSBIER"),
                     Premios = c(2, 3, 5), 
                     IBU = c(78.2, 60.5, 40.8))

Tipo_1 %>% dplyr::bind_rows(Tipo_2) # como rbind

# Bind_cols ---------------------------------------------------------------

Tipo_cervezas <- Tipo_1 %>% dplyr::bind_rows(Tipo_2) 
Tipo_cervezas

Amargura_sabor <- data.frame(Amargura = c(9, 6, 8, 6, 6, 4),
                             Acentuacion = c("Lúpulo-frutal", 
                                             "Chocolate-tostado",
                                             "Terroso-frutal", 
                                             "Malta-tostado",
                                             "Malta-tostado",
                                             "Cítrico-trigo"))

Base_completa <- Tipo_cervezas %>% dplyr::bind_cols(Amargura_sabor) # como cbind
Base_completa

# Pivot_longer ------------------------------------------------------------

Base_completa <- Base_completa %>% dplyr::mutate(anio_2018 = c(1,1,2,0,1,2),
                                                 anio_2019 = c(1,1,1,1,1,2),
                                                 anio_2020 = c(2,1,1,1,1,1)) %>% 
  dplyr::select(Tipo, starts_with("anio"))

data_1 <- tidyr::pivot_longer(data = Base_completa, # data
                              cols = starts_with(match = "anio"), # cuales columnas wide pasan a long
                              names_to = "Anio", values_to = "Frecuencia") # hacia donde van estos vnombres y valores (dos colum distintas)

data_1 

gather(data = Base_completa, key = "Anio", value = "Frecuencia",
       c(anio_2018, anio_2019, anio_2020)) # gather es otra opcion


# Pivot_wider -------------------------------------------------------------

data_1 %>% 
  tidyr::pivot_wider(names_from = Anio, values_from = Frecuencia) # para pasar a wide indicar variable de donde vienes los nombres que serán nuevas columnas, e indicar de donde vienen los valores que luego llenaran esas nuevas columnas

spread(data = data_1 , key = "Anio", value = "Frecuencia") # spread otra opcion
