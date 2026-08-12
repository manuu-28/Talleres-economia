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
    summarise(actividad="actG11", internet=mean(uso_internet)*100),
)
View(tenderos_tarea2)
