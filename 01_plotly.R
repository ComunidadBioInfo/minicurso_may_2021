## ----"cargar_librerias_plotly"-----------------------------------------------------------------------------------------------------
## Carguemos las librerías que vamos a usar para esta parte del mini curso
library("palmerpenguins")
library("ggplot2")
library("plotly")


## ----"plotly_ejemplo"--------------------------------------------------------------------------------------------------------------
## De ?plotly::ggplotly
ggpenguins <- qplot(bill_length_mm,
    body_mass_g,
    data = palmerpenguins::penguins,
    color = species
)

## Versión estática creada con ggplot2
ggpenguins


## ----"plotly_ejemplo_parte2"-------------------------------------------------------------------------------------------------------
## Ahora  en versión interactiva
ggplotly(ggpenguins)

