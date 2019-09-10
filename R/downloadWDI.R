#' Dowload WDI
#'
#' Download WDI (World development indicators) data .rda file.
#' the WDI data is updated with the funciton "WDISearch(cache=WDIcache())"
#'
#' @author  David Chen
#' @seealso  \code{\link{downloadSource}} \code{\link{WDI}}
#' @examples
#'
#' \dontrun{ a <- downloadSource(type="WDI")
#' }
#'
#' @importFrom WDI WDI WDIcache WDIsearch


downloadWDI<-function(){
  #WDI::WDIsearch(cache = WDI::WDIcache()) #this function searches for updates from WDI website
  indicator <- c("NY.GDP.MKTP.CD", # gdp PPP current US$
                 "SP.POP.TOTL", # Total population
                 "SL.AGR.EMPL.ZS", #Employment in agriculture as % of total employment
                 "NV.AGR.TOTL.CD") # Ag GDP current US$
  wdi <- WDI::WDI(indicator = indicator,start= 1960, end = 2018)
  save(wdi,file = paste("WDI","rda",sep="."))
}
