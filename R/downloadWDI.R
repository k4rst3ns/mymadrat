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
  WDIsearch(cache = WDIcache())
  indicator <- c("NY.GDP.MKTP.PP.CD", "SP.POP.TOTL","SL.EMP.TOTL.SP.ZS","SL.AGR.EMPL.ZS",
                 "NV.AGR.TOTL.ZS")
  wdi <- WDI(indicator = indicator,start= 1960, end = 2018)
  save(wdi,file = paste("WDI","rda",sep="."))
}
