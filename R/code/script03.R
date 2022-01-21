# Code 3: Text Mining


# 1. Packages ------------------------------------------------------------- 

pacman::p_load(tidyverse, tidytext, wordcloud,
               wordcloud2, readr, patchwork,
               pdftools, readxl, tm, textdata)

#devtools::install_github("mjockers/syuzhet")
library(syuzhet)
# 2. Data -----------------------------------------------------------------

boric <- scan(file = "C:/Users/PC/Documents/GitHub/ccss-computacionales/input/BORIC_TXT.txt",
              fileEncoding = "UTF-8",
              what = "chat",
              sep = "\n")


kast <- scan(file = "C:/Users/PC/Documents/GitHub/ccss-computacionales/input/KAST_TXT.txt",
              fileEncoding = "UTF-8",
              what = "chat",
              sep = "\n")

# 3. Manipulation ---------------------------------------------------------

## Desarmar oraciones

# Pasos
# 1. Convertir las lienas de texto en una tabla
# 2. Desarmar texto en tokens (palabras)
# 3. Contar la frecuencia de cada palabra


boric_2021 <- dplyr::tibble(boric) %>% 
  tidytext::unnest_tokens(output = "palabra",
                          input = boric,
                          strip_numeric = F) %>% 
  dplyr::count(palabra, sort = T)

kast_2021 <- dplyr::tibble(kast) %>% 
  tidytext::unnest_tokens(output = "palabra",
                          input = kast,
                          strip_numeric = F) %>% 
  dplyr::count(palabra, sort = T)


# Podemos ver palabras de funcion o gramaticales, que son las tipicas que no tienen sentido semantico como "de", "la", "y" etc. Se conocen tambien como stopwords


## Eliminar stopwords con antijoin: cada vez que las palabras de mi objeto coincidan con las de mi stopwords se eliminarán con antijoin
## es decr, lo compartido se elimina

listado_stopwords_1 <- readr::read_csv("https://raw.githubusercontent.com/7PartidasDigital/AnaText/master/datos/diccionarios/vacias.txt")
stopwords_extra <- tibble::tibble(palabra = c("de", "no", "y", "null")) # crear uno propio de ejemplo

boric_2021 <- boric_2021 %>% dplyr::anti_join(listado_stopwords_1, by = "palabra") %>% 
  dplyr::anti_join(stopwords_extra, by = "palabra")

kast_2021 <- kast_2021 %>% dplyr::anti_join(listado_stopwords_1, by = "palabra") %>% 
  dplyr::anti_join(stopwords_extra, by = "palabra")


# Exportar en excel

writexl::write_xlsx(list("Programa Boric" = boric_2021,
                         "Programa Kast" = kast_2021),
                         path = "C:/Users/PC/Documents/GitHub/ccss-computacionales/output/programas.xlsx")


## Graficar

boric_2021 %>% top_n(15) %>% 
  ggplot(aes(y = reorder(palabra,n),
             x = n)) +
  geom_col(fill = "steelblue") +
  labs(title = "Palabras más frecuentes",
       subtitle = "Programa Boric",
       y = "Palabras",
       x = "Frecuencia") +
  geom_text(aes(label = n), size = 3, hjust = -0.4)


kast_2021 %>% top_n(15) %>% 
  ggplot(aes(y = reorder(palabra,n),
             x = n)) +
  geom_col(fill = "black") +
  labs(title = "Palabras más frecuentes",
       subtitle = "Programa Kast",
       y = "Palabras",
       x = "Frecuencia") +
  geom_text(aes(label = n), size = 3, hjust = -0.4) +
  theme_classic()

## Nubes de palabras

corpus_boric <- tm::Corpus(tm::VectorSource(boric))
corpus_boric <- tm::tm_map(corpus_boric, removeWords, stopwords("spanish"))

wordcloud(corpus_boric,
          random.order = T,
          rot.per = 0.50,
          min.freq = 1,
          max.words = 200,
          scale = c(5,0,5))

wordcloud2(data = boric_2021)

# 4. Analysis ----------------------------------------------------------------

# usando corr lineal: 
# 1 = significa que dos palabras siempre aparecen juntas en el texto
# 0 = significa que dos palabras rara vez aparecen juntas en el texto

dtm_boric <- tm::TermDocumentMatrix(corpus_boric)

cor_boric <- tm::findAssocs(dtm_boric, terms = "pensiones", corlimit = 0.35)


# 5. Analysis TF IDF ------------------------------------------------------

# Acronimo de Term Frequency Times Inverse Documents Frecuency

# mide con qué frecuencia aperece un termino dentro de un documentos y lo compara con el numero de documentos que mencionan ese termino dentro de una coleccion entera de documentos

# en corto: conocer cuales son las palabras que caracteristcas de un texto midiendo la importancia de un termino comparando en otro documento

# aqui no hay necesidad de sacar stopwords

boric_frecuencia <- boric_2021 %>% 
  mutate(programa = "Boric 2021")

kast_frecuencia <- kast_2021 %>% 
  mutate(programa = "Kast 2021")

programas_candidatos <- bind_rows(boric_frecuencia, kast_frecuencia)

programas_candidatos <- programas_candidatos %>% 
  select(programa, palabra, n)

programas_candidatos <- programas_candidatos %>% 
  tidytext::bind_tf_idf(term = palabra, document = programa, n = n)

programas_candidatos <- programas_candidatos %>% 
  arrange(desc(tf_idf)) %>% 
  group_split(programa) # separa valores en var categoricas

programas_candidatos
# tf = frecuencia del termino respecto al total
# idf = el peso de cada palabra  
# Si tenemos td e idf alto es una caracteristica del texto

# Grafico

tboric <- programas_candidatos[[1]] %>% 
  slice(1:20) %>% # cortar 
ggplot(aes(x = reorder(palabra, tf_idf),
           y = tf_idf)) +
  geom_bar(stat = "identity", fill = "salmon") +
  coord_flip() +
  labs(title = "Boric",
       x = "Palabra",
       y = "TF_IDF")

tkast <- programas_candidatos[[2]] %>% 
  slice(1:20) %>% # cortar 
  ggplot(aes(x = reorder(palabra, tf_idf),
             y = tf_idf)) +
  geom_bar(stat = "identity", fill = "blue") +
  coord_flip() +
  labs(title = "Kast",
       x = "Palabra",
       y = "TF_IDF")

tboric + tkast

# 6. Sentiment Analysis ---------------------------------------------------

# Sirve para aproximar las connotaciones subjetivas de los textos analizados
# Obj: determinar si predominan emociones negativas o positivas en un tetxo

boric_2021 %>% 
  inner_join(get_sentiments("nrc"), by = c("palabra" = "word")) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(sentiment = positive - negative) %>% 
  ggplot(aes(x = palabra, y = sentiment)) +
  geom_col(fill = "darkblue") +
  coord_flip() +
  labs(title = "Analisis sentimiento",
       subtitle = "Programa Boric",
       x = "Palabras",
       y = "Sentimientos")


kast_2021 %>% 
  inner_join(get_sentiments("nrc"), by = c("palabra" = "word")) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(sentiment = positive - negative) %>% 
  ggplot(aes(x = palabra, y = sentiment)) +
  geom_col(fill = "green") +
  coord_flip() +
  labs(title = "Analisis sentimiento",
       subtitle = "Programa Boric",
       x = "Palabras",
       y = "Sentimientos")