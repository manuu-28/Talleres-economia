
library(dplyr)
library(rio)
TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")

tenderos_tarea=TenderosFU03_Publica %>%
  select(uso_internet,Munic_Dept)
View(tenderos_tarea)
tenderos_tareaAgrupar <- tenderos_tarea %>%
  group_by(Munic_Dept) %>%
summarise(internet = mean(uso_internet) * 100)
View(tenderos_tareaAgrupar)

# ---- Visualización ----
# % de uso de internet por municipio/departamento
grafico_tarea1 <- ggplot(tenderos_tareaAgrupar,
                          aes(x = reorder(Munic_Dept, internet), y = internet)) +
  geom_col(fill = "#2C7FB8") +
  coord_flip() +
  labs(
    title = "Uso de internet por municipio/departamento",
    x = "Municipio / Departamento",
    y = "% de negocios que usan internet"
  ) +
  theme_minimal()

grafico_tarea1

ggsave("../graficos/tarea1_uso_internet_municipio.png",
       plot = grafico_tarea1, width = 8, height = 6, dpi = 300)
