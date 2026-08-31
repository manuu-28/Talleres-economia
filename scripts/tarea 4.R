library(dplyr)
library(rio)
library(ggplot2)

TerriData_Dim2 <- import("../datos/TerriData_Dim2.xlsx")
TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")

poblacion_municipal <- TerriData_Dim2 %>%
  filter(Indicador == "Población total") %>%
  filter(Año == max(Año, na.rm = TRUE)) %>%
  transmute(
    Munic_Dept = as.numeric(`Código Entidad Territorial`),
    Departamento,
    Municipio = `Entidad Territorial`,
    Poblacion = as.numeric(gsub(",", ".", gsub("\\.", "", `Dato Numérico`)))
  ) %>%
  distinct(Munic_Dept, .keep_all = TRUE)
View(poblacion_municipal)

penetracion_municipal <- TenderosFU03_Publica %>%
  group_by(Munic_Dept) %>%
  summarise(internet = mean(uso_internet, na.rm = TRUE) * 100, n_tenderos = n())

tenderos_tarea4 <- penetracion_municipal %>%
  inner_join(poblacion_municipal, by = "Munic_Dept")
View(tenderos_tarea4)

# ---- Visualización ----
# Penetración de internet vs. población municipal
grafico_tarea4 <- ggplot(tenderos_tarea4,
                          aes(x = Poblacion, y = internet)) +
  geom_point(size = 3, color = "#31A354") +
  geom_text(aes(label = Municipio), vjust = -0.8, size = 3) +
  scale_x_continuous(labels = scales::comma) +
  labs(
    title = "Penetración de internet vs. población municipal",
    x = "Población total del municipio",
    y = "% de negocios que usan internet"
  ) +
  theme_minimal()

grafico_tarea4

ggsave("../graficos/tarea4_penetracion_vs_poblacion.png",
       plot = grafico_tarea4, width = 8, height = 6, dpi = 300)
