#' @title calcAgGDP
#' @description calculates Ag GDP as % of total GDP
#'
#' @return List of magpie object with results on country  level, weight, unit and description.
#' @author David Chen
#' @examples
#'
#' \dontrun{
#' calcOutput("AgGDP")
#' }

calcAgGDP <- function(){

  gdp <- readSource("WDI", subtype="NY.GDP.MKTP.CD", aggregate=F)
  ag_gdp <- readSource("WDI", subtype="NV.AGR.TOTL.CD", aggregate=F)

  x <- ag_gdp/gdp
  x <- collapseNames(x)

  return(list(
    x=x,
    weight=NULL,
    unit="share",
    description="Ag GDP as percentage of total GDP"))
}
