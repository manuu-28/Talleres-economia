library(dplyr)
library(rio)
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

tenderos_tarea2 <- bind_rows(
  TenderosFU03_Publica %>%
    filter(actG1 == 1) %>%
    summarise(actividad = "actG1", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG2 == 1) %>%
    summarise(actividad = "actG2", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG3 == 1) %>%
    summarise(actividad = "actG3", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG4 == 1) %>%
    summarise(actividad = "actG4", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG5 == 1) %>%
    summarise(actividad = "actG5", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG6 == 1) %>%
    summarise(actividad = "actG6", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG7 == 1) %>%
    summarise(actividad = "actG7", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG8 == 1) %>%
    summarise(actividad = "actG8", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG9 == 1) %>%
    summarise(actividad = "actG9", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG10 == 1) %>%
    summarise(actividad = "actG10", internet = mean(uso_internet, na.rm = TRUE) * 100),

  TenderosFU03_Publica %>%
    filter(actG11 == 1) %>%
    summarise(actividad = "actG11", internet = mean(uso_internet, na.rm = TRUE) * 100)
) %>%
  left_join(etiquetas_actividad, by = "actividad")

View(tenderos_tarea2)

# ---- Visualización ----
# Tasa de uso de internet según tipo de actividad económica
grafico_tarea2 <- ggplot(tenderos_tarea2,
                          aes(x = reorder(actividad_nombre, internet), y = internet)) +
  geom_col(aes(fill = actividad_nombre == "Tienda")) +
  scale_fill_manual(values = c("TRUE" = "#D7263D", "FALSE" = "#2C7FB8"), guide = "none") +
  coord_flip() +
  labs(
    title = "Tasa de uso de internet según tipo de actividad",
    subtitle = "Tiendas (rojo) muy por debajo del resto de actividades",
    x = NULL,
    y = "% de uso de internet"
  ) +
  theme_minimal()

grafico_tarea2

ggsave("../graficos/tarea2_uso_internet_actividad.png",
       plot = grafico_tarea2, width = 8, height = 6, dpi = 300)
