Exploration
================

This document is for me to explore different aspects of the data before
creating the dashboard. `tidyverse` libraries will be used to assist in
exploring the data.

``` r
library(tidyverse)
```

# `README`

Now BART’s data contains a `README` file. This mostly gives an overview
of the column names and how they are stored. The columns are:

``` r
col_names <- c(
  "day",
  "hour",
  "origin_station",
  "destination_station",
  "trip_count"
)
```

These are stored to help with reading the data later.

The file also mentions that the names of the different stations are
abbreviated and provides the [download link for a
spreadsheet](https://www.bart.gov/sites/default/files/docs/Station_Names.xls)
giving the corresponding full names. After downloading, I was able to
read this into a tibble.

``` r
station_tibble <- readxl::read_xls("Station_Names.xls") %>%
  rename(
    station_code = `Two-Letter Station Code`,
    station_name = `Station Name`
  )

station_tibble
```

    # A tibble: 50 × 2
       station_code station_name                     
       <chr>        <chr>                            
     1 RM           Richmond                         
     2 EN           El Cerrito Del Norte             
     3 EP           El Cerrito Plaza                 
     4 NB           North Berkeley                   
     5 BK           Berkeley                         
     6 AS           Ashby                            
     7 MA           MacArthur                        
     8 19           19th Street Oakland              
     9 12           12th Street / Oakland City Center
    10 LM           Lake Merritt                     
    # … with 40 more rows

The full `README` can be found
[here](http://64.111.127.166/origin-destination/READ%20ME.txt).

# Reading Data

I decided to preview the most recent data.

``` r
read_csv(
  "http://64.111.127.166/origin-destination/date-hour-soo-dest-2022.csv.gz",
  col_names = col_names
) %>%
  head()
```

    # A tibble: 6 × 5
      day         hour origin_station destination_station trip_count
      <date>     <dbl> <chr>          <chr>                    <dbl>
    1 2022-01-01     0 12TH           12TH                         1
    2 2022-01-01     0 12TH           16TH                         1
    3 2022-01-01     0 12TH           24TH                         2
    4 2022-01-01     0 12TH           ASHB                         1
    5 2022-01-01     0 12TH           MONT                         1
    6 2022-01-01     0 12TH           POWL                         2

Now, one issue with this data is that the station abbreviations do not
match those given in the spreadsheet.
