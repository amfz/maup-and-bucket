library(opendatatoronto)
library(tidyverse)

neighborhoods <- 
  list_package_resources("4def3f65-2a65-4a4f-83c4-b2a4aed72d46")%>%
  get_resource()

neighborhood_profiles <- 
  list_package_resources("6e19a90f-971c-46b3-852c-0c48c436d1fc")

neighborhood_profiles <-
  neighborhood_profiles[1, ]%>%
  get_resource()