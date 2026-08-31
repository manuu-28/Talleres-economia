library(dplyr)
library(rio)
TerriData_Dim2 <- import("../datos/TerriData_Dim2.xlsx")

tenderos_tarea4=TerriData_Dim2 %>%
  select(`Departamento`,`Dato Numérico`)%>%
  mutate(`Dato Numérico` = as.numeric(gsub(",", ".", gsub("\\.", "", `Dato Numérico`)))) %>%
  group_by(`Departamento`)%>%
  summarize(`Dato Numérico`=sum(`Dato Numérico`, na.rm=TRUE))
View(tenderos_tarea4)
# ---- Visualización ----
# Dato numérico total por departamento (TerriData)
grafico_tarea4 <- ggplot(tenderos_tarea4,
                          aes(x = reorder(Departamento, `Dato Numérico`), y = `Dato Numérico`)) +
  geom_col(fill = "#31A354") +
  coord_flip() +
  labs(
    title = "Dato numérico total (TerriData) por departamento",
    x = "Departamento",
    y = "Dato numérico total"
  ) +
  theme_minimal()

grafico_tarea4

ggsave("../graficos/tarea4_dato_numerico_departamento.png",
       plot = grafico_tarea4, width = 8, height = 8, dpi = 300)
