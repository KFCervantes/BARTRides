# load all things needed
library(fpp3)

# current path to download updated data
current_path <- stringr::str_c(
  r"(http://64.111.127.166/origin-destination/date-hour-soo-dest-)",
  now() %>% year(),
  r"(.csv.gz)"
)

# download data
readr::read_csv(
  current_path,
  col_names = c(
    "day",
    "hour",
    "origin_station",
    "destination_station",
    "trip_count"
  )
) %>%
  
  # make date time column
  mutate(
    hour = stringr::str_glue("{day} {hour}") %>%
      lubridate::ymd_h(tz = "US/Pacific"),
    .keep = "unused"
  ) %>%
  
  # convert to tsibble object
  as_tsibble(
    index = hour,
    key = c("origin_station", "destination_station")
  ) %>%
  
  # save as RDS object for faster loading later
  saveRDS("recent_traffic.RDS")