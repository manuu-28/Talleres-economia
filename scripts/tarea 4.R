TerriData_Dim2 <- import("../datos/TerriData_Dim2.xlsx")

tenderos_tarea4=TerriData_Dim2 %>%
  select(`Departamento`,`Dato Numérico`)%>%
  mutate(`Dato Numérico` = as.numeric(gsub(",", ".", gsub("\\.", "", `Dato Numérico`)))) %>%
  group_by(`Departamento`)%>%
  summarize(`Dato Numérico`=sum(`Dato Numérico`, na.rm=TRUE))
View(tenderos_tarea4)
