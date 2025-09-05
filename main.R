base1 <- read.csv2("precotaxatesourodireto.csv")

library(dplyr)
library(lubridate)

base1 <- base1 %>%
  mutate(Data.Base = dmy(Data.Base)) %>% 
  filter(year(Data.Base) >= 2022)  

library(dplyr)
library(tidyr)
library(lubridate)

# Criar identificador único (Tipo.Titulo + ano de vencimento)
base1 <- base1 |>
  mutate(
    ano_venc = year(dmy(Data.Vencimento)),
    id_titulo = paste(Tipo.Titulo, ano_venc)
  )

# Selecionar apenas as colunas relevantes para pivotagem
base_long <- base1 |>
  select(Data.Base, id_titulo, 
         taxa_compra = Taxa.Compra.Manha, 
         taxa_venda = Taxa.Venda.Manha,
         pu_compra = PU.Compra.Manha, 
         pu_venda = PU.Venda.Manha)

# Pivotar para wide
base_wide <- base_long |>
  pivot_wider(
    names_from = id_titulo,
    values_from = c(taxa_compra, taxa_venda, pu_compra, pu_venda)
  )

# Organizar colunas por ordem alfabética 
base_wide <- base_wide |>
  arrange(Data.Base) |>
  relocate(Data.Base)

# Conferir resultado
glimpse(base_wide)



