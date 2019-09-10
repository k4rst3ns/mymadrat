#' calcValidPopulation
#'
#' Returns historical development of population
#'
#' @param datasource  WDI
#' @author Florian Humpenoeder, Jan Philipp Dietrich, Kristine Karsens
#' @importFrom magclass getRegions

calcValidPopulation <- function(datasource="WDI") {

  if(datasource=="WDI"){

    out <- readSource("WDI", "SP.POP.TOTL")

  } else { stop("No datasource of the given name.") }

  getNames(out)                   <- "Population (million people)"
  getSets(out,fulldim = FALSE)[3] <- "variable"

  out <- add_dimension(out, dim=3.1, add="scenario", nm = "historical")
  out <- add_dimension(out, dim=3.2, add="model",    nm = datasource)

  return(list(
    x=out,
    weight=NULL,
    unit="million",
    description=paste0("Population data. Datasource for the Past: ",
                       datasource)))

}
