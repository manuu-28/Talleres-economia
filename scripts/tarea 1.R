
library(dplyr)
tenderos_tarea=TenderosFU03_Publica %>%
  select(uso_internet,Munic_Dept)
View(tenderos_tarea)
tenderos_tareaAgrupar <- tenderos_tarea %>%
  group_by(Munic_Dept) %>%
summarise(internet = mean(uso_internet) * 100)
View(tenderos_tareaAgrupar)
