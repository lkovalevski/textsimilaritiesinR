Proyecto Análisis de Similaridad entre textos
=======

Este proyecto tiene como objetivo analizar distintas alternativas para agrupar y describir textos similares.

Overview
--------

    projecto
    |- doc/            # documentacion del estudio
    |  |- articles/    # related articles, reviews 
    |  +- paper/       # manuscript(s), whether generated or not
    |
    |- data            # raw and primary data, are not changed once created 
    |  |- raw/         # raw data, will not be altered
    |  +- clean/       # cleaned data, will not be altered once created
    |
    |- code/           # any programmatic code
    |
    |- results         # all output from workflows and analyses
    |  +-  figures/     # graphs, likely designated for manuscript figures
    |
    |- scratch/        # temporary files that can be safely deleted or lost
    |
    |- README          # the top level description of content


![Plot01](https://github.com/lkovalevski/textsimilaritiesinR/blob/master/results/figures/word_plot.png)

![Plot03](https://github.com/lkovalevski/textsimilaritiesinR/blob/master/results/figures/dendograma.png)

![Plot03](https://github.com/lkovalevski/textsimilaritiesinR/blob/master/results/figures/n-gramas.png)


How to use
----------

Se ejecuta el archivo 'ejecutarAnalisisTexto.R' en el directorio raíz y los resultados del análisis se guardan enel archivo 'analisisTexto_yyyy-mm-dd.html' de la carpeta 'results'. 

Key concepts and goals
----------------------



Acknowledgements
----------------

The initial file and directory structure of this project was developed by a group of participants in the Reproducible Science Curriculum Workshop, held at [NESCent] in December 2014. The structure is based on, and heavily follows the one proposed by [Noble 2009], with a few but small modifications.
To the extent possible under law, the author(s) of this template have dedicated all copyright and related and neighboring rights to it to the public domain worldwide under the [CC0 Public Domain Dedication]. The template and all other content in the [rr-init repository] is distributed without any warranty.

[rr-init repository]: https://github.com/Reproducible-Science-Curriculum/rr-init
[latest release]: https://github.com/Reproducible-Science-Curriculum/rr-init/releases/latest
[NESCent]: http://nescent.org
[Rmarkdown]: http://rmarkdown.rstudio.com/
[Noble 2009]: http://dx.doi.org/10.1371/journal.pcbi.1000424
[CC0 Public Domain Dedication]: http://creativecommons.org/publicdomain/zero/1.0/
