library(dplyr)
library(rio)
library(tidyr)
library(ggplot2)

TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")

tenderos_tareaAgrupar2 <- TenderosFU03_Publica %>%
  select(Munic_Dept, Municipio, uso_internet, actG1:actG11) %>%
  pivot_longer(cols = actG1:actG11, names_to = "actividad", values_to = "valor") %>%
  filter(valor == 1) %>%
  group_by(Munic_Dept, Municipio, actividad) %>%
  summarise(internet = mean(uso_internet, na.rm = TRUE) * 100, n_negocios = n(), .groups = "drop")

View(tenderos_tareaAgrupar2)

# ---- Visualización ----
grafico_tarea3 <- ggplot(tenderos_tareaAgrupar2,
                          aes(x = actividad, y = reorder(Municipio, Munic_Dept), fill = internet)) +
  geom_tile() +
  scale_fill_gradient(low = "#FDE0DD", high = "#C51B8A", name = "% uso\ninternet") +
  labs(
    title = "Uso de internet por municipio y tipo de actividad",
    subtitle = "Un mismo negocio puede aparecer en más de una actividad (actG1-actG11 no son excluyentes)",
    x = "Actividad (código)",
    y = "Municipio"
  ) +
  theme_minimal()

grafico_tarea3

ggsave("../graficos/tarea3_uso_internet_municipio_actividad.png",
       plot = grafico_tarea3, width = 9, height = 8, dpi = 300)
