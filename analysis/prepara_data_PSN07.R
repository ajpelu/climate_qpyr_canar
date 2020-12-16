# Prepare data from PSN 
library("tidyverse")
library("here")


# Read data 
# Me descargo los datos cn_PSN07_166.csv --> ojo los he quitado de la carpeta raw porque ocupan 600 MB
# psn <- read_csv(here::here("data/raw/cn_PSN07_166.csv"))

# Humedad del arie ----
# variable_id = 11 Humedad relativa del aire HI1
# h_air <- psn %>% filter(variable_id == 11)
# Validation code = 8 --> validado por rango OAPN 
# Todos los valores de validation 8, por tanto elimino esta variable 
# Elimino tambien el codigo de la estacion y cambio nombre a variable 
h_air <- psn %>% 
  filter(variable_id == 11) %>%
  dplyr::select(-validation_id, -station_id) %>% 
  mutate(variable = case_when(
    variable_id == 11 ~ "hum_rel_aire")) 

write_csv(h_air, here::here("data/raw/psn07_humedad_rel_aire.csv"))

# Precipitación ----
# 49 PI1 Precipitación caída en el período
# agregate by dia (suma todos los valores de precipitacion de un día)
prec <- psn %>% 
  filter(variable_id == 49) %>% 
  dplyr::select(-validation_id, -station_id) %>% 
  group_by(date = lubridate::floor_date(time, "day")) %>% 
  summarise(value = sum(value)) %>% 
  mutate(variable = "prec") %>% 
  ungroup()
 
write_csv(prec, here::here("data/raw/psn07_prec.csv"))

# Temperatura media del suelo ----
# 102 Temperatura media del suelo 

temp_soil <- psn %>% 
  filter(variable_id == 102) %>% 
  dplyr::select(-validation_id, -station_id) %>% 
  mutate(variable = case_when(
    variable_id == 102 ~ "temp_soil")) 

write_csv(temp_soil, here::here("data/raw/psn07_temp_soil.csv"))

# Temperatura aire ----
# 108 Temeratura Aire 

temp_air <- psn %>% 
  filter(variable_id == 108) %>% 
  dplyr::select(-validation_id, -station_id) %>% 
  mutate(variable = case_when(
    variable_id == 108 ~ "temp_air")) 

write_csv(temp_air, here::here("data/raw/psn07_temp_air.csv"))



 