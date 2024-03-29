d <- generate_test_data()
set_csfmt_rts_data_v1(d, create_unified_columns = T)
d[1:4]

d <- generate_test_data()
d[]
set_csfmt_rts_v1(d, create_unified_columns = F)
d[]
set_csfmt_rts_v1(d, create_unified_columns = T)
d[]

# Looking at the dataset
d[]
x <- d

# Smart assignment of time variables (note how granularity_time, isoyear, isoyearweek, date all change)
d[1,isoyearweek := "2021-01"]
d

d[1, date := as.Date("2021-01-01")]
d[1, location_code := "norge"]
heal(d)




heal()
sc::fill_in_missing_v8



summary(d)

identify_data_structure(d, "deaths_n") %>% plot()



d <- generate_test_data()
set_csfmt_rts_data_v1(d)
d[1,isoyearweek := "2021-01"]
d[2,isoyear := 2019]
d[4:5,date := as.Date("2020-01-01")]
d[10,c("isoyear","isoyearweek") := .(2021,"2021-01")]
d[10,c("location_code") := .("norge")]



d <- generate_test_data()
set_csfmt_rts_v1(d)
d[, .(deaths_n = sum(deaths_n), location_code = "norge", granularity_geo = NA, date = "2021-01-01"), keyby=.(granularity_time)] %>%
  create_unified_columns() %>%
  #heal() |>
  print()

  # heal() %>%
  print()


library(magrittr)
conn <- DBI::dbConnect(
  odbc::odbc(),
  driver = "ODBC Driver 17 for SQL Server",
  server = Sys.getenv("SYKDOMSPULSEN_DB_CONFIG_SERVER"),
  Port = Sys.getenv("SYKDOMSPULSEN_DB_CONFIG_PORT"),
  trusted_connection = "yes"
)

sc::use_db(conn, Sys.getenv("SYKDOMSPULSEN_DB_CONFIG_DB_ANON"))

conn %>% dplyr::tbl("anon_weather_rawdata") |> cstidy::identify_data_structure("temperature_min_n") |> plot()

conn %>% dplyr::tbl("anon_weather_rawdata") |> class()

var = 'temperature_min_n'
conn %>% dplyr::tbl("anon_weather_rawdata") %>%
  dplyr::select(
    granularity_time,
    granularity_geo,
    age,
    sex,
    var = !!var
  ) %>%
  dplyr::summarize(
    num_valid = sum(!is.na(!!var)),
    num_na = sum(is.na(!!var))
  ) %>%
  dplyr::collect() %>%
  print()

conn %>% dplyr::tbl("anon_weather_rawdata") %>%
  dplyr::rename(var = !!var) %>%
  dplyr::group_by(
    granularity_time
  ) %>%
  dplyr::summarize(
    num_valid = sum(!is.na(!!var)),
    num_na = sum(is.na(!!var))
  ) %>%
  dplyr::collect() %>%
  print()

# "print.tbl_Microsoft SQL Server" <- function(x, ...) {
#   print(3)
# }


conn %>% dplyr::tbl("anon_weather_rawdata") %>%
  dplyr::rename(var = !!var) %>%
  dplyr::group_by(
    granularity_time,
    granularity_geo,
    age,
    sex
  ) %>%
  dplyr::summarize(
    num_total = n(),
    num_na = sum(as.numeric(is.na(var)))
  ) %>%
  dplyr::mutate(
    num_valid = num_total - num_na
  ) %>%
  dplyr::select(-num_valid) %>%
  dplyr::collect() %>%
  as.data.table()

summarized <- x[, .(
  num_valid = sum(!is.na(get(var))),
  num_na = sum(is.na(get(var)))
),
keyby = .(
  granularity_time,
  granularity_geo,
  age,
  sex
)
]

#### skeleton
d <- generate_test_data()[c(1,4,10:.N)]
d[]
set_csfmt_rts_data_v1(d)
d[]


make_skeleton_isoweek.csfmt_rts_data_v1 <- function(
  isoyearweek_min = NULL,
  isoyearweek_max = NULL,
  granularity_geo = "all",
  location_reference = csdata::nor_locations_names(),
  ...) {

  if(yrwk_min==yrwk_max){
    yrwks <- isoyearweek_min
  } else {
    isoyearweek_min <- which(cstime::dates_by_isoyearweek$isoyearweek==isoyearweek_min)
    isoyearweek_max <- which(cstime::dates_by_isoyearweek$isoyearweek==isoyearweek_max)
    yrwks <- fhidata::world_dates_isoyearweek[yrwk_min:yrwk_max,yrwk]
  }

  locs <- NULL
  if ("all" %in% granularity_geo) {
    locs <- location_reference$location_code
  } else {
    x_gran <- granularity_geo
    locs <- location_reference[granularity_geo %in% x_gran]$location_code
  }
  retval <- expand.grid(
    ...,
    isoyearweek = yrwks,
    location_code = locs,
    stringsAsFactors = FALSE
  )
  setDT(retval)
  retval[, granularity_time := "isoweek"]
  retval[, granularity_geo := fhidata::get_granularity_geo(location_code, location_reference = location_reference)]
  setcolorder(retval, c("granularity_time","isoyearweek", "granularity_geo","location_code"))
  setorderv(retval, names(retval))
  return(retval)
}




