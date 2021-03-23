**Note: This project is a submission for an assignment on deceptive information visualization. Please don't take it at face value.**

# Here are the 10 least Canadian neighbourhoods in Toronto

It's no secret that Toronto is a diverse, international city. Though areas in Scarborough and Markham come to mind as immigrant enclaves, the most immigrant-dense neighbourhoods in the city are still downtown. We crunched the numbers from [Statistics Canada](https://open.toronto.ca/dataset/neighbourhood-profiles/) and the [city's neighbourhood profiles](https://www.toronto.ca/city-government/data-research-maps/neighbourhoods-communities/neighbourhood-profiles/) to find the areas with the highest concentration of immigrants.

1. North St.James Town
2. Church-Yonge Corridor
3. Mount Pleasant West
4. Taylor-Massey
5. Bay Street Corridor
6. Regent Park
7. Willowdale East
8. Flemingdon Park
9. Kensington-Chinatown
10. Westminster-Branson
11. Moss Park

---

# Design

I chose to work with immigration data in Toronto because of the richness of the Toronto neighbourhood profile dataset. The dataset is available on the Toronto Open Data portal; it consists of thousands of demographic and socioeonomic characteristics from the 2016 Census aggregated to the neighborhood level by the city's Social Policy Analysis and Research Unit. The 140 neighbourhoods defined in the data are built up from census tracts based on several rules and considerations, including historical planning area divisions, service boundaries, and dividing arterials like highways and rivers. While originally created to help local planning efforts, the geographies have embedded themselves in the popular imagination enough that the announcement of 34 new neighbourhoods [made it to BlogTO](https://www.blogto.com/city/2021/03/toronto-changing-boundaries-create-34-new-neighbourhoods/).

Ideas for a misleading visualization fell into a few categories: bad statistical analysis, suspect data aggregation, and questionable framing. The neighbourhood profile dataset's 2383 variables are rife with opportunities for spurious correlations and inappropriate statistical methods. On the data aggregation side, ideas included binning continuous variables in unusual ways, creatively combining categories (e.g., by conflating first- and second-generation immigrant counts), and exploiting the Modifiable Areal Unit Problem, which stipulates that how one divides space affects descriptions and analytical results (e.g., by aggregating the neighbourhoods to the level of former boroughs).

I iterated through maps in R before settling on creating a single map embedded in a clickbait-y listicle. Doing so was an opportunity to pair a poor data wrangling choice with some of ad-driven web publishing's most annoying tendencies: sensationalist headlines, careless copy, and uncritical circulation of data-driven material. The result is a misleading take meant for a casual, Toronto-based audience that is only probably half-paying attention.

The piece is dishonest in a couple of ways. There is the misleading headline that frames immigrants as un-Canadian. The text and visualization launder authority from their data sources, Statistics Canada and the City of Toronto, using what Huff (2010) would call OK names to back sketchy claims. The map cartography is based on styles found in official City of Toronto publications: competent but not slick.

It is also weaselly in its use of "concentration", moving from normalization-by-population to normalization-by-area in the span of a sentence. An immigrant-dense neighbourhood would conventionally be one where immigrants comprise a large proportion of the total population. This piece instead highlights as immigrant-dense areas that have a large number of immigrants relative to land area. As a result, many of the areas with "the highest concentration of immigrants" are simply areas with the highest concentrations of people in Toronto overall, though some legitimately . There is also an outright lie in the piece: Westminster-Branson has more immigrants per square kilometer than Moss Park (5331 to 5194), but the underlying data is not provided, it is not obvious from the visualization, and it is unlikely that the target audience would fact-check the claim.

The visualization is honest in one sense: the underlying data is legitimately from the neighbourhood profiles. Land areas come directly from the `Land area in square kilometres` characteristic, and immigrant population figures are summed from the `Immigrants` and `Non-permanent residents` characteristics.




##
notes

accent red: #f61600

## References

Firke, S. (2021). janitor: Simple Tools for Examining and Cleaning Dirty Data. R
  package version 2.1.0. https://CRAN.R-project.org/package=janitor

Gelfand, S. (2020). opendatatoronto: Access the City of Toronto Open Data Portal. R
  package version 0.1.4. https://CRAN.R-project.org/package=opendatatoronto

Pebesma, E. (2018). Simple Features for R: Standardized Support for Spatial Vector
  Data. The R Journal 10 (1), 439-446, https://doi.org/10.32614/RJ-2018-009

R Core Team (2020). R: A language and environment for statistical computing. R
  Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

Tennekes, M. (2018). “tmap: Thematic Maps in R.” _Journal of Statistical Software_,
*84*(6), 1-39. doi: 10.18637/jss.v084.i06 (URL: https://doi.org/10.18637/jss.v084.i06).
  
Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software,
  4(43), 1686, https://doi.org/10.21105/joss.01686