library(dplyr)
library(rio)
library(ggplot2)

TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")

tenderos_tarea <- TenderosFU03_Publica %>%
  select(uso_internet, Munic_Dept, Municipio)
View(tenderos_tarea)

tenderos_tareaAgrupar <- tenderos_tarea %>%
  group_by(Munic_Dept, Municipio) %>%
  summarise(internet = mean(uso_internet) * 100, .groups = "drop")
View(tenderos_tareaAgrupar)

# ---- Visualización ----
grafico_tarea1 <- ggplot(tenderos_tareaAgrupar,
                          aes(x = reorder(Municipio, internet), y = internet)) +
  geom_col(fill = "#2C7FB8") +
  coord_flip() +
  labs(
    title = "Uso de internet por municipio",
    x = "Municipio",
    y = "% de negocios que usan internet"
  ) +
  theme_minimal()

grafico_tarea1

ggsave("../graficos/tarea1_uso_internet_municipio.png",
       plot = grafico_tarea1, width = 8, height = 6, dpi = 300)
