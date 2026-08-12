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
