library(dplyr)
library(rio)
TenderosFU03_Publica <- import("../datos/TenderosFU03_Publica.dta")


tenderos_tarea2 <- bind_rows(
  TenderosFU03_Publica %>%
  filter(actG1==1) %>%
  summarise(actividad="actG1", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
  filter(actG2==1) %>%
  summarise(actividad="actG2", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
  filter(actG3==1) %>%
  summarise(actividad="actG3", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG4==1) %>%
    summarise(actividad="actG4", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG5==1) %>%
    summarise(actividad="actG5", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG6==1) %>%
    summarise(actividad="actG6", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG7==1) %>%
    summarise(actividad="actG7", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG8==1) %>%
    summarise(actividad="actG8", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG9==1) %>%
    summarise(actividad="actG9", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG10==1) %>%
    summarise(actividad="actG10", internet=mean(uso_internet)*100),
  
  TenderosFU03_Publica %>%
    filter(actG11==1) %>%
    summarise(actividad="actG11", internet=mean(uso_internet)*100)
)
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

