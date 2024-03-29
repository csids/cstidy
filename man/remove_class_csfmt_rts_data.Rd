% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/csfmt_rts_generics.R
\name{remove_class_csfmt_rts_data}
\alias{remove_class_csfmt_rts_data}
\title{Remove class csfmt_rts_data_*}
\usage{
remove_class_csfmt_rts_data(x)
}
\arguments{
\item{x}{data.table}
}
\value{
No return value, called for the side effect of removing the csfmt_rts_data class from x.
}
\description{
Remove class csfmt_rts_data_*
}
\examples{
x <- cstidy::generate_test_data() \%>\%
  cstidy::set_csfmt_rts_data_v2()
class(x)
cstidy::remove_class_csfmt_rts_data(x)
class(x)
}
\seealso{
Other csfmt_rts_data: 
\code{\link{expand_time_to}()},
\code{\link{identify_data_structure}()},
\code{\link{set_csfmt_rts_data_v1}()},
\code{\link{set_csfmt_rts_data_v2}()},
\code{\link{unique_time_series}()}
}
\concept{csfmt_rts_data}
