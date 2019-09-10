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

  gdp <- readSource("WDI", subtype="NY.GDP.MKTP.CD")
  ag_gdp <- readSource("WDI", subtype="NV.AGR.TOTL.CD")

  x <- ag_gdp/gdp


  return(list(
    x=x,
    weight=NULL,
    unit="share",
    description="Ag GDP as percentage of total GDP"))
}
