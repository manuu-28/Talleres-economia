library(dplyr)
library(rio)
TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")

tenderos_tarea3=TenderosFU03_Publica %>%
  select(uso_internet,actividad1,Munic_Dept)
View(tenderos_tarea3)
tenderos_tareaAgrupar2 <- tenderos_tarea3 %>%
  group_by(Munic_Dept,actividad1) %>%
summarise(internet=mean(uso_internet)*100)
View(tenderos_tareaAgrupar2)
# ---- Visualización ----
# % de uso de internet por municipio/departamento y tipo de actividad (heatmap)
grafico_tarea3 <- ggplot(tenderos_tareaAgrupar2,
                          aes(x = factor(actividad1), y = Munic_Dept, fill = internet)) +
  geom_tile() +
  scale_fill_gradient(low = "#FDE0DD", high = "#C51B8A", name = "% uso\ninternet") +
  labs(
    title = "Uso de internet por municipio/departamento y tipo de actividad",
    x = "Actividad (código)",
    y = "Municipio / Departamento"
  ) +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 6))

grafico_tarea3

ggsave("../graficos/tarea3_uso_internet_municipio_actividad.png",
       plot = grafico_tarea3, width = 9, height = 8, dpi = 300)
