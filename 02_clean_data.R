library(tidyverse)
library(janitor)
library(sf)

# some type fixing
neighborhoods$neighborhood_number <-
  as.integer(neighborhoods$AREA_SHORT_CODE)

#reduce the number of variables
nhood_profiles <-
  neighborhood_profiles%>%
  filter(!str_detect(Category,"Language")) %>%
  #filter(!str_detect(Category,"Ethnic origin")) %>%
  filter(!str_detect(Category,"Education")) %>%
  #filter(!str_detect(Category,"Immigration")) %>%
  #filter(!str_detect(Category,"Labour")) %>%
  filter(!str_detect(Category,"Aboriginal")) %>%
  filter(!str_detect(Category,"Ethnic origin")) %>%
  filter(!str_detect(Category,"Mobility")) %>%
  filter(!str_detect(Category,"Language of work")) %>%
  filter(!str_detect(Category,"Journey to work")) %>%
  filter(!str_detect(Topic,"Income sources")) %>%
  filter(!str_detect(Topic,"Age characteristics")) %>%
  filter(!str_detect(Topic,"Marital")) %>%
  filter(!str_detect(Characteristic,"parent")) %>%
  mutate_all(funs(na_if(.,"n/a"))) %>%# identify nas
  mutate_all(funs(str_replace(.,",",""))) %>%
  mutate_all(funs(str_replace(.,"%",""))) %>%
  drop_na(-`City of Toronto`)

nhood_profiles$Characteristic <- str_trim(nhood_profiles$Characteristic)
#helper function to identify columns that could be converted into numbers
numericcharacters <-
  function(x) {
    !any(is.na(suppressWarnings(as.numeric(x))))&is.character(x)
  }

# Further hone in on characteristics of interest
cls <-list("Neighbourhood Number",
           "Population 2016",
           "Population Change 2011-2016",
           "Population density per square kilometre",
           "Land area in square kilometres",
           "Average household size",
           "*Immigrant status and period of immigration*",
           "Immigrants",
           "Non-immigrants",
           "Non-permanent residents",
           "Total private dwellings",
           " Average household size",
           "Prevalence of low income based on the Low-income measure after tax (LIM-AT) ()",
           "Rate of inadequate housing",
           "Rate of unaffordable housing")

nhood_profiles <-
  nhood_profiles %>%
  filter(Characteristic %in% cls)

long_spec <-
  nhood_profiles %>%
  select(-6) %>%
  build_longer_spec(cols=-c("_id","Category","Topic","Data Source","Characteristic"))

long_profiles <-
  nhood_profiles %>%
  select(-6) %>%
  pivot_longer_spec(long_spec)

wide_spec <-
  long_profiles%>%
  build_wider_spec(names_from=c("_id","Topic","Characteristic"),values_from="value")

profiles <-
  long_profiles%>%
  pivot_wider_spec(spec=wide_spec,id_cols="name")%>%
  clean_names()


profiles <-
  profiles %>%
  mutate_all(str_trim) %>%
  mutate_if(numericcharacters, as.numeric)

profiles$neighborhood_number <- 
  as.integer(profiles$x1_neighbourhood_information_neighbourhood_number)


# get neighborhood attributes joined to shapes
nhoods <-neighborhoods%>%left_join(profiles,by="neighborhood_number")

# rename columns
full_data <- 
  nhoods %>%
  rename(pop_2016 = x3_population_and_dwellings_population_2016,
         total_private_dwellings = x6_population_and_dwellings_total_private_dwellings,
         pop_per_sqkm = x8_population_and_dwellings_population_density_per_square_kilometre,
         sq_km = x9_population_and_dwellings_land_area_in_square_kilometres,
         pop_change = x5_population_and_dwellings_population_change_2011_2016,
         avg_hh_size = x75_household_and_dwelling_characteristics_average_household_size,
         li_rate = x1131_low_income_in_2015_prevalence_of_low_income_based_on_the_low_income_measure_after_tax_lim_at,
         unaffordable_housing_rate = x1689_core_housing_need_rate_of_unaffordable_housing,
         inadequate_housing_rate = x1695_core_housing_need_rate_of_inadequate_housing,
         imm_pop = x1153_immigrant_status_and_period_of_immigration_immigrants,
         non_imm_pop = x1152_immigrant_status_and_period_of_immigration_non_immigrants,
         non_pr_pop = x1162_immigrant_status_and_period_of_immigration_non_permanent_residents) %>%
  clean_names()


# add extra columns for immigrant population figures
full_data$all_imm <- full_data$imm_pop + full_data$non_pr_pop

full_data$percent_imm <- 
  (full_data$all_imm / 
     (full_data$non_imm_pop + full_data$all_imm)) * 100

full_data$imm_dens <- 
  round(full_data$all_imm / full_data$sq_km)

# Export data
st_write(full_data, "data/to_data.geojson")