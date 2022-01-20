# Script 2: Data manipulation 


# 1. Packages ----
library(tidyverse)
library(openintro)

# 2. Data ----
oscars <- openintro::oscars

# 3. Processing ----
dplyr::glimpse(oscars)
sapply(oscars, class)
names(oscars)
head(oscars)
tail(oscars)

# Select ----
names(oscars)
oscars %>% dplyr::select(name, everything())
oscars %>% dplyr::select(name, starts_with("o"))
oscars %>% dplyr::select(name, ends_with("e"))
oscars %>% dplyr::select(name, matches("birth"))
oscars %>% dplyr::select(name, contains("b")|contains("e"))
oscars %>% dplyr::select(where(is.numeric))


# Parametrizar: crear objetos que agrupen datos para facilitar programacion
variables <- names(oscars)[3:5]
oscars %>% dplyr::select(variables)


# Actividad 
head(oscars)
oscars %>% dplyr::select(everything(), -c(1,6))
oscars %>% dplyr::select(!starts_with("birth")) # se puede usar ! o - como negacion


# Filter -----
oscars %>% filter(award >=2015) # tidy
oscars[oscars$award >= 2015] # base

oscars %>% filter(age >= 50 & oscar_yr > 2000)
oscars[oscars$age >= 50 & oscars$oscar_yr > 2000,]

oscars %>% dplyr::filter(age %in% c(20:30) & award == "Best actress")
oscars %>% dplyr::filter(between(age, 20, 30) & award == "Best actress")

# Actividad

oscars %>% filter(oscar_yr >= 2015)

oscars %>% filter(award == "Best actress" & age >50)

oscars %>% filter(name == "Meryl Streep")

oscars %>% filter(name %in% c("Leonardo Di Caprio", "Al Pacino"))

oscars %>% filter(between(age, 20, 30))

oscars %>% filter(age == max(age))
oscars[which.max(oscars$age),]

# Mutate -----

oscars %>% mutate(tiempo = oscar_yr - birth_y) %>% View()

oscars %>% 
  mutate(var = if_else(award == "Best actress", 1, 0))

oscars %>% mutate(var = case_when(award == "Best actress" ~ "Mejor actriz",
                                  TRUE ~ "Mejor actor"))

oscars %>% mutate_if(is.character, as.factor) # mutate if como condicionante

oscars %>% mutate_all(stringr::str_to_upper) # poner en mayuscula

oscars %>% select(name, birth_date) %>% 
  mutate(dias = Sys.Date() - birth_date,
         edad = as.numeric(round(dias/365), digits = 0))

# Group by ----

oscars %>% group_by(award) %>% count()

oscars %>% filter(award == "Best actor") %>% 
  group_by(name) %>% count() %>% filter(n >=2)

# Summarise ----

oscars %>% filter(name %in% c("Leonardo Di Caprio", "Robert De Niro", "Al Pacino",
                              "Meryl Streep", "Jennifer Lawrence")) %>%
  group_by(name) %>% 
  summarise(n=n())

# group by debe ir acompañado de o un count() o un summarise()

# Actividad 

oscars %>% select(!starts_with("b")) %>% 
  group_by(award) %>% 
  summarise(oscar = n(),
            edad = mean(age, na.rm = T),
            mediana = median(age, na.rm = T),
            q1 = quantile(age, probs = 0.25),
            q3 = quantile(age, probs = 0.75),
            sd = sd(age, na.rm = T),
            min = min(age, na.rm = T),
            max = max(age, na.rm = T)) %>% 
            rename(premio=award) %>% 
            mutate(premio = if_else(premio == "Best actor", "Mejor actor", "Mejor actriz"))

    
# Actividad titanic

titanic <- Titanic %>% as.data.frame()
names(titanic)

titanic %>% select(Class, Survived, Freq) %>% 
  filter(Survived == "Yes") %>% 
  group_by(Class) %>% 
  summarise(Freq = sum(Freq)) %>% 
  mutate(prop = round(prop.table(Freq),digits = 3)) %>% 
  arrange(desc(prop)) 

