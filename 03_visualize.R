library(tidyverse)
library(tmap)
library(sf)

### Plots ###
demo_map <-
  tm_shape(full_data) +
  tm_polygons(c("pop_2016",
                "pop_per_sqkm",
                "total_private_dwellings",
                "avg_hh_size",
                "li_rate",
                "unaffordable_housing_rate",
                "imm_pop",
                "non_imm_pop",
                "percent_imm"),
              #convert2density = TRUE,
              #area = "sq_km",
              style ="sd",
              n = 5,
              palette ="-inferno",
              title =c("Population",
                       "Pop./sq. km",
                       "Private dwellings",
                       "Average\nhousehold size",
                       "Low income %",
                       "Unaffordable\nhousing %",
                       "Immigrant Population",
                       "Non Immigrant Population",
                       "% Immigrant")) +
  tm_facets(nrow=3,ncol=3) +
  tm_layout(main.title="Selected Neighborhood Characteristics, 2016",
            main.title.size =.9,
            legend.text.size=.7,
            legend.position =c("right","bottom"),
            attr.outside =TRUE)

print(demo_map)


imm_dens_map <-
  tm_shape(full_data) +
  tm_polygons(c("all_imm",
                "percent_imm",
                "imm_pop",
                "non_pr_pop"),
              #convert2density = TRUE,
              #area = "sq_km",
              style ="jenks",
              n = 5,
              palette ="-inferno",
              title =c("All Immigrant Pop.",
                       "% Immigrant",
                       "Perm. Imm. Pop.",
                       "Non-Perm. Imm.Pop.")) +
  tm_facets(nrow=2,ncol=2) +
  tm_layout(main.title="Immigration in Toronto, 2016 - Jenks",
            main.title.size =.9,
            legend.text.size=.65,
            legend.position =c("right", "bottom"),
            attr.outside =TRUE)

print(imm_dens_map)


pop_dens_map <-
  tm_shape(full_data) +
  tm_polygons(c("imm_dens",
                "pop_per_sqkm"),
              style ="quantile",
              n = 5,
              palette ="-inferno",
              title =c("Immigrant",
                       "Overall")) +
  tm_facets(nrow=2,ncol=1) +
  tm_layout(main.title="Population Density 2016",
            main.title.size =.9,
            legend.text.size=.7,
            legend.position =c("right","bottom"),
            attr.outside =TRUE)

print(pop_dens_map)