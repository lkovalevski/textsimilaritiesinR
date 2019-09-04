#' ---
#' title: "Análisis de texto"
#' author: Leandro Kovalevski
#' date: "`r initime`"
#' toctitle: "Tabla de Contenidos"
#' output:
#'    html_document:
#'      toc: true
#'      toc_depth: 2
#' ---



# ---------------------------------------------------
# Info de la ejecución. ####


# Guardar la hora de inicio
initime <- Sys.time()

# Numerar secciones, tablas y gráficos.
cap    <- 1 # Número de sección
subcap <- 1 # Número de la sub-seccion
ti     <- 1 # Número de tabla
gi     <- 1 # Número de gráfico


inputFile <- "40 archivos de texto '.txt'"

cat("\n# Info de la ejecución\n")

#' 
#' 
#' El presente informe se generó de la siguient manera: \n
#' 
#' -  **Fecha de ejecución**      :`r  initime` \n
#' -  **Base de datos**           :`r  inputFile` \n
#' -  **Archivo de ejecución**    :`r  "ejecutarAnalisisTexto.R"` \n
#' -  **Ubicado en el directorio**:`r  paste0(sourcePath, "/code")`  \n
#' 
#' 


# Llamar al script que contiene la funcion 'rquery.wordcloud()'
source(paste0(sourcePath, "/code/rquery.wordcloud.R"))


# Load all the 40 article files
datapath <- paste0(sourcePath, "/data/raw/")

articles <- list() # Crear una lista para guardar los textos

for (i in 1 : 40) {
  assign( paste0("arti", i), file(paste0(datapath, "/article", i, ".txt"), "r", blocking = FALSE) )
  assign( paste0("ss", i), readLines(get(paste0("arti", i))) )
  assign( paste0("ss", i), paste(get(paste0("ss", i)), sep = " ", collapse = " ") )
  assign( paste0("ss", i), noquote(get(paste0("ss", i))) )
  close( get(paste0("arti", i)) )
  articles[[ i ]] <- get(paste0("ss", i))
  rm(list = paste0("ss",i))
}


#sec    <- paste0(cap, ".", subcap)
#subcap <- subcap + 1
sec    <- paste0(cap)

# ---------------------------------------------------
# 1. Descripcion general de los textos #### 
cat(paste0("\n# ", sec, ". Descripción general de los textos.\n")) 


#'
#'
#' Se cuenta con informacion de 40 articulos de longitud variable sobres distintos temas. En la tabla 1.1 se describen los articulos. 
#' 
#'

ti <- 1
tindex <- paste0(sec, ".", ti) # Actualizar el indice del grafico

cat(paste0("\n### Tabla ", tindex, ". Clasificación de artículos según el tema de los mismos.\n"))

#'  | id | Tema            | Artículos           |
#'  | ---|:----------------- |:-------------:| -----:|
#'  | 1  | Oil exploration, petroleum reserves, oil price | 16\*, 17\*, 18, 1, 3+, 4+, 5 |
#'  | 2  | Oil issues in Middle East countries/ Organization of the petroleum exporting countries (OPEC)      | 13\*\*, 10\*\*, 2, 6, 7, 8, 9, 11, 12, 14     | 
#'  | 3  | Stock market investments | 26+, 28+, 31, 32, 33, 37, 39, 40, 19, 21, 22 |
#'  | 4  | Movements of buying or selling companies | 30, 36, 23, 24, 25, 27, 29, 34, 35 |
#'  | 5  | Oil tanker hit a tower of power | 15 |
#'  | 6  | Argentine oil production in 1987 | 20 |
#'  | 7  | Merge of two Japanese electronics companies | 38 |
#'
#'
#' *Nota:* 
#' \n\* Los artículos 16 y 17 son idénticos salvo un párrafo. \n
#' \n+ El artículo 3 con 4 y el artículo 26 con 28 son muy similares en estructura y contenido; solo difieren en los nombres de las empresas.\n
#' \n\*\* El artículo 13 es un extracto del artículo 10.\n
#'
#'


#sec    <- paste0(cap, ".", subcap)
cap <- cap + 1
sec    <- paste0(cap)

# ---------------------------------------------------
# 2. Elección del q óptimo para determinar la longitud del q-grama #### 
cat(paste0("\n# ", sec, ". Elección del q optimo para determinar la longitud del q-grama.\n")) 


# Calcular evolución de las distancias en función de los q-grams (de 1 a 20)
distancias_jaccard <- list()
resumen            <- data.frame()

for (n in 1 : 20) {
  m          <- stringdistmatrix(as.character(articles), as.character(articles), method = "jaccard", q = n)
  frame      <- data.frame(row = rep(1 : 40, 40), col = rep(1 : 40, each = 40), dist = as.vector(m))
  dissimilar <- frame[order(frame$dist), ][ 41, ]
  colnames(dissimilar) <- c("dis.art.i" , "dis.art.ii" , "dist")
  similar    <- frame[order(frame$dist), ][length(frame$dist), ]
  colnames(similar) <- c("sim.art.i" , "sim.art.ii" , "dist")
  resumen    <- rbind(resumen, data.frame(n, similar, dissimilar, median(frame$dist)))
  x          <- as.dist(m)
  distancias_jaccard[[ n ]] <- x
  #assign(paste0("plot", n), plot(hclust(x), main = paste0("Dendogram with n = ", n, "-grams")))
  #jpeg(paste0(paste0(sourcePath, "/results/figures/", n,".jpg")))
}


cat("\n")
cat("\n")


gt <- ggplot(data = resumen, aes(x = n, y = median.frame.dist.)) +
  geom_point(stat = "identity") +
  geom_line(size = 1.1, color = "#006AA7") +
  scale_y_continuous(name = "Distancia mediana") + # Nombre de la variable respuesta
  scale_x_continuous(name = "q", breaks = 1 : 20) +  
  theme_bw() + # Quitar el color de fondo
  geom_hline(yintercept = 0, color = "grey", size = .5) +
  theme(panel.border = element_blank(),  
        panel.grid.minor   = element_blank(), 
        panel.background   = element_blank(),
        axis.text.y        = element_text(size = rel(1.5)),
        axis.text.x        = element_text(size = rel(1.5)),
        axis.title.x       = element_text(size = rel(1.3)),
        axis.title.y       = element_text(size = rel(1.3))
  )


gindex <- paste0(sec, ".", gi) # Actualizar el indice del grafico

cat(paste0("\n### Figura ", gindex, ". Mediana de las distancias entre los 40 textos según el número de caracteres de la partición (q).\n"))
gi <- 1 + gi

print(gt)

cat("\n")
cat("\n")


#'
#'
#' En la Figura `r  gindex`, se traza la distancia mediana entre artículos por q-gramas. Se puede ver que a medida que q aumenta, la mayoría de las distancias se acercan a 1 (completamente diferente).
#'
#' Para decidir la mejor q para agrupar los artículos más similares, se utilizó un Análisis de conglomerados para evaluar cómo la agrupación cambia a medida que "q" cambia. Algunos patrones de agrupación estuvieron presentes para todas las "q" evaluadas (de 1 a 20), como que los artículos 16 y 17 son los más similares y que las similitudes entre 3 y 4, 10 y 13 y 26 y 28 se presentan después.
#'
#' La "q" óptima seleccionada para agrupar artículos fue 6, porque dio la agrupación más similar a los temas de la Tabla 1.1. 
#' 
#'




cap <- cap + 1
sec    <- paste0(cap)

# ---------------------------------------------------
# 3. Elección del q óptimo para determinar la longitud del q-grama #### 
cat(paste0("\n# ", sec, ". Agrupación por similaridad.\n")) 

#' ### Analisis de conglomorado

#'
#'
#' La agrupación encontrada se presenta en el dendograma de la Figura 3.1. 
#' 
#' 

x    <- as.dist(distancias_jaccard[[6]])
fit  <- hclust(x)
fit2 <- as.dendrogram(fit)

ti <- 1
tindex <- paste0(sec, ".", ti) # Actualizar el indice del grafico

cat(paste0("\n### Tabla ", tindex, ". Dendograma con q = 6-gramas.\n"))

plot(fit, 
     xlab = "Articulos")

rect.hclust(fit, k = 7, border="red")

#'
#'
#' De la agrupación se destaca que:
#' 
#'  - El artículo atípico 20 quedó aislado en un grupo de un único elemento mientras que los atípicos 15 y 38 forman entre ellos otro grupo. 
#'  - Se identificaron grupos de artículos que efectivamente tienen artículos con los temas mencionados en la tabla 1.1: '1- Oil exploration/ petroleum reserves / oil price', '2 - Oil issues in Middle East countries/ Organization of the petroleum exporting countries (OPEC)', '3 - Stock market investments' y '4 - Movements of buying/selling companies'. 
#'  - Se indentificó un grupo de artículos con diferentes temas pero ese grupo contiene artículos de aproximadamente la misma longitud (son todos los textos más largos).
#' 
#' 


# ---------------------------------------------------
# 4. Comparación de los grupos encontrados #### 
cat(paste0("\n# ", sec, ". Comparación de los grupos encontrados.\n")) 


#'
#'
#' #### To be completed :P
#' 
#' 

# idGroup <- 5
# 
# iteracionTextos <- 1 
# 
# clustersGroup <- cutree(fit, k = 7)
# 
# clustersGroup[iteracionTextos]

cat(paste0("\n## Ejemplo nube de palabras para el texto 2 sobre 'Oil issues en OPEC'.\n"))


res <- rquery.wordcloud(articles[2], type=c("text"),
                 lang="english", excludeWords = c("said"),
                 textStemming = FALSE,  colorPalette="Dark2",
                 max.words=200)



tdm <- res$tdm
freqTable <- res$freqTable
kable(freqTable[1 : 10, ], row.names = FALSE
)

# 
# 
#   # Show the top10 words and their frequency
#   head(freqTable, 10)

cat(paste0("\n## Ejemplo nube de palabras para el texto 21 sobre 'Stock market investments'.\n"))


res2 <- rquery.wordcloud(articles[21], type=c("text"),
                        lang="english", excludeWords = c("said"),
                        textStemming = FALSE,  colorPalette="Dark2",
                        max.words=200)



tdm <- res2$tdm
freqTable <- res2$freqTable
kable(freqTable[1 : 10, ], row.names = FALSE
)