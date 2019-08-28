#' Dowload WDI
#'
#' Download WDI (World development indicators) data .rda file.
#' the WDI data is updated with the funciton "WDISearch(cache=WDIcache())"
#'
#' @author  David Chen
#' @seealso  \code{\link{downloadSource}} \code{\link{WDI}}
#' @examples
#'
#' \dontrun{ a <- downloadSource(type="WDI_t")
#' }
#'
#' @importFrom WDI WDI WDIcache WDIsearch


downloadWDI_t<-function(){
  end_year <- as.numeric(strsplit(as.character(Sys.Date()),"-")[[1]][1]) -1
  WDIsearch(cache = WDIcache())
  indicator <- c("NY.GDP.MKTP.PP.CD", "SP.POP.TOTL","SL.EMP.TOTL.SP.ZS","SL.AGR.EMPL.ZS",
                 "NV.AGR.TOTL.ZS")
  wdi <- WDI(indicator = indicator,start= 1960, end = end_year)
  save(wdi,file = paste("WDI","rda",sep="."))
}
