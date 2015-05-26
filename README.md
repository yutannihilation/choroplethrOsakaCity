Osaka City Map for choroplethr
====================

## Original Map Data

This package is for the use with the choroplethr package.

You can draw the choropleth maps of Osaka, the second largest city in Japan. The original shp file is destributed by the City Planning Bureau of Osaka City, under CC-BY 2.1 license. For more details, see http://www.city.osaka.lg.jp/toshikeikaku/page/0000250227.html

## Install

```r
install_github("yutannihilation/choroplethrOsakaCity")
```

## How To Use

```r
library(choroplethrOsakaCity)
library(ggplot2)
library(dplyr)

csv_file <- tempfile(fileext = ".csv")

download.file("https://raw.githubusercontent.com/yutannihilation/osaka_age_composition/master/osaka_age_composition.csv",
              destfile = csv_file, method = "curl")

age_comp.df <- read.csv(csv_file, header = TRUE, stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>%
  group_by(district) %>% 
  summarise(value = sum(age * total)/sum(total)) %>%
  mutate(region = to_osaka_ward_code(district))

osaka_city_chropleth(age_comp.df, title = "Age Composition") + coord_equal()
```
![demo](demo.png)
