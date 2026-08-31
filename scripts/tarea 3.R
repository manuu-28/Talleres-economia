library(dplyr)
library(rio)
TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")

tenderos_tareaAgrupar2 <- TenderosFU03_Publica %>%
  select(Munic_Dept, uso_internet, actG1:actG11) %>%
  pivot_longer(cols = actG1:actG11, names_to = "actividad", values_to = "valor") %>%
  filter(valor == 1) %>%
  group_by(Munic_Dept, actividad) %>%
  summarise(internet = mean(uso_internet, na.rm = TRUE) * 100, n_negocios = n(), .groups = "drop")
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
