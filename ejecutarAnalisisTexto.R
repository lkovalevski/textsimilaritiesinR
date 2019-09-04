  
  #'#################################################################################################
  #' 
  #' EDA - Analisis Exploratorio previo al modelado 5.0
  #' ==================================================
  #'
  #' Version construida el 29/05/2019.
  #'
  #'   Conecta los scripts de las distintas coberturasAnalisis de los valores . 
  #'
  #'   @FileInput:  nombre del archivo del AR simple
  #'   
  #'#################################################################################################
  
  
  rm(list = ls()) # Clean Objects
  options(warn = 0)
  memory.limit(size = 3000000000)
  
  #' Capturar la fecha y hora de inicio
  initime <- Sys.Date()

  #' Instalar los paquetes que no estan y cargar todos
  listofpackages <- c("here", "dplyr", "ggplot2", "knitr", "rmarkdown", "ggwordcloud", "tm", "stylo", "plyr", "readr", "stringdist", "reshape", "wordcloud")
  newPackages    <- listofpackages[ ! (listofpackages %in% installed.packages()[, "Package"])]
  if(length(newPackages)) install.packages(newPackages)
  for (paquete in listofpackages) {
    suppressMessages(library(paquete, character.only = TRUE))
  }
  
  
  #' Definir el directorio donde se encuentra la base de datos a analizar.
  sourcePath <- here::here()
  sourcePath <- "C:/Users/usuario/Dropbox/Analisis de texto en R"
  
  #' Definir el conjunto de datos a analizar
  inputFile  <- paste0("article1.txt")
  

  knitr::opts_chunk$set(
    echo    = TRUE,  
    cache   = FALSE,
    results = 'asis'
  )

    
#'  Genera un html
  rmarkdown::render(paste0(sourcePath, "/code/analisisTexto.R"),
                    encoding = "UTF-8",
                    output_file = paste0(sourcePath, "/results/analisisTexto_", Sys.Date(), ".html"))


  
