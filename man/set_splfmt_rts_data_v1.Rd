% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/splfmt_rts_v1.R
\name{set_splfmt_rts_data_v1}
\alias{set_splfmt_rts_data_v1}
\alias{splfmt_rts_data_v1}
\title{Convert data.table to splfmt_rts_data_v1}
\usage{
set_splfmt_rts_data_v1(x, create_unified_columns = TRUE, heal = TRUE)

splfmt_rts_data_v1(x, create_unified_columns = TRUE, heal = TRUE)
}
\arguments{
\item{x}{The data.table to be converted to splfmt_rts_data_v1}

\item{create_unified_columns}{Do you want it to \code{\link{create_unified_columns}}?}

\item{heal}{Do you want to \code{\link{heal}} on creation?}
}
\value{
An extended \code{data.table}, which has been modified by reference and returned (invisibly).
}
\description{
\code{set_splfmt_rts_data_v1} converts a \code{data.table} to \code{splfmt_rts_data_v1} by reference.
\code{splfmt_rts_data_v1} creates a new \code{splfmt_rts_data_v1} (not by reference) from either a \code{data.table} or \code{data.frame}.
}
\details{
For more details see the vignette:
\code{vignette("splfmt_rts_data_v1", package = "cstidy")}
}
\section{Smart assignment}{

\code{splfmt_rts_data_v1} contains the smart assignment feature for time and geography.

When the \strong{variables in bold} are assigned using \verb{:=}, the listed variables will be automatically imputed.

\strong{location_code}:
\itemize{
\item granularity_geo
\item country_iso3
}

\strong{isoyear}:
\itemize{
\item granularity_time
\item isoweek
\item isoyearweek
\item season
\item seasonweek
\item calyear
\item calmonth
\item calyearmonth
\item date
}

\strong{isoyearweek}:
\itemize{
\item granularity_time
\item isoyear
\item isoweek
\item season
\item seasonweek
\item calyear
\item calmonth
\item calyearmonth
\item date
}

\strong{date}:
\itemize{
\item granularity_time
\item isoyear
\item isoweek
\item isoyearweek
\item season
\item seasonweek
\item calyear
\item calmonth
\item calyearmonth
}
}

\section{Unified columns}{

\code{splfmt_rts_data_v1} contains 16 unified columns:
\itemize{
\item granularity_time
\item granularity_geo
\item country_iso3
\item location_code
\item border
\item age
\item sex
\item isoyear
\item isoweek
\item isoyearweek
\item season
\item seasonweek
\item calyear
\item calmonth
\item calyearmonth
\item date
}
}

\examples{
# Create some fake data as data.table
d <- cstidy::generate_test_data(fmt = "splfmt_rts_data_v1")
d <- d[1:5]

# convert to splfmt_rts_data_v1 by reference
cstidy::set_splfmt_rts_data_v1(d, create_unified_columns = TRUE)

#
d[1, isoyearweek := "2021-01"]
d
d[2, isoyear := 2019]
d
d[3, date := as.Date("2020-01-01")]
d
d[4, c("isoyear", "isoyearweek") := .(2021, "2021-01")]
d
d[5, c("location_code") := .("norge")]
d

# Investigating the data structure of one column inside a dataset
cstidy::generate_test_data() \%>\%
  cstidy::set_splfmt_rts_data_v1() \%>\%
  cstidy::identify_data_structure("deaths_n") \%>\%
  plot()
# Investigating the data structure via summary
cstidy::generate_test_data() \%>\%
  cstidy::set_splfmt_rts_data_v1() \%>\%
  summary()
}
\seealso{
Other splfmt_rts_data: 
\code{\link{create_unified_columns}()},
\code{\link{expand_time_to}()},
\code{\link{heal}()},
\code{\link{identify_data_structure}()},
\code{\link{remove_class_splfmt_rts_data}()},
\code{\link{unique_time_series}()}
}
\concept{splfmt_rts_data}
