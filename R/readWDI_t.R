#' Read WDI
#'
#' Read-in WDI (World development indicators) data .rda file as magclass
#' object.
#'
#'
#' @param subtype Type of WDI data that should be read. Please use the
#' worldbank indicator abbreviation. Available types are e.g.: \itemize{ \item
#' \code{SP.POP.TOTL}: Population, total \item \code{NY.GDP.MKTP.PP.KD}: GDP,
#' PPP (constant 2011 international Dollar) \item \code{NY.GDP.MKTP.PP.CD}:
#' GDP, PPP (current international Dollar) \item \code{NY.GDP.MKTP.CD}: GDP MER
#' (current USDollar) \item \code{NY.GDP.MKTP.KD}: GDP MER (constant 2005
#' USDollar) \item \code{NY.GDP.MKTP.KN}: GDP LCU (constant LCU) \item \code{SP.URB.TOTL.IN.ZS}: Urban population (peccentage of total)}
#' @return magpie object of the WDI data
#' @author David Chen
#' @seealso \code{\link{readSource}} \code{\link{downloadWDI}}
#' @examples
#'
#' \dontrun{ a <- readSource(type="WDI",subtype="SP.POP.TOTL")
#' }
#' @importFrom reshape2 melt

readWDI_t<-function(subtype){
  load("WDI.rda")
   wdi$country <- NULL
  wdi <- as.magpie(melt(wdi,id.vars = c("iso2c","year")),spatial=1,temporal=2,tidy=TRUE,replacement =".")
  wdi <- wdi[,,subtype]
  return(wdi)
}
