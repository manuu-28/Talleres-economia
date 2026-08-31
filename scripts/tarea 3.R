library(dplyr)
library(rio)
library(tidyr)
library(ggplot2)

TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")

# Nombres reales de actG1..actG11, tomados de las etiquetas de variable
# del archivo .dta original (metadata de Stata)
etiquetas_actividad <- tibble::tibble(
  actividad = c("actG1", "actG2", "actG3", "actG4", "actG5", "actG6",
                "actG7", "actG8", "actG9", "actG10", "actG11"),
  actividad_nombre = c("Tienda", "Comida preparada", "Peluquería y belleza", "Ropa",
                       "Otras variedades", "Papelería y comunicaciones", "Vida nocturna",
                       "Productos bajo inventario", "Salud", "Servicios", "Ferretería y afines")
)

tenderos_tareaAgrupar2 <- TenderosFU03_Publica %>%
  select(Munic_Dept, Municipio, uso_internet, actG1:actG11) %>%
  pivot_longer(cols = actG1:actG11, names_to = "actividad", values_to = "valor") %>%
  filter(valor == 1) %>%
  group_by(Munic_Dept, Municipio, actividad) %>%
  summarise(
    internet = mean(uso_internet, na.rm = TRUE) * 100,
    n_negocios = n(),
    .groups = "drop"
  ) %>%
  left_join(etiquetas_actividad, by = "actividad")

View(tenderos_tareaAgrupar2)

# ---- Visualización ----
# % de uso de internet por municipio y tipo de actividad (heatmap)
grafico_tarea3 <- ggplot(tenderos_tareaAgrupar2,
                          aes(x = actividad_nombre, y = reorder(Municipio, Munic_Dept), fill = internet)) +
  geom_tile() +
  scale_fill_gradient(low = "#FDE0DD", high = "#C51B8A", name = "% uso\ninternet") +
  labs(
    title = "Uso de internet por municipio y tipo de actividad",
    subtitle = "Un mismo negocio puede aparecer en más de una actividad (no son excluyentes)",
    x = "Actividad",
    y = "Municipio"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

grafico_tarea3

ggsave("../graficos/tarea3_uso_internet_municipio_actividad.png",
       plot = grafico_tarea3, width = 9, height = 8, dpi = 300)
