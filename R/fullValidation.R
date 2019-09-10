#' fullValidation
#'
#' Function that produces the complete validation data set used for evaluation of MAgPIE outputs
#'
#' @param rev data revision which should be used as input (positive numeric).
#' \code{\link{setConfig}} (e.g. for setting the mainfolder if not already set
#' properly).
#' @author Jan Philipp Dietrich, Kristine
#' @seealso
#' \code{\link{readSource}},\code{\link{getCalculations}},\code{\link{calcOutput}},\code{\link{setConfig}}
#' @examples
#'
#' \dontrun{
#' retrieveData("Validation")
#' }
#' @importFrom madrat getConfig

fullVALIDATION <- function(rev=0.1) {

  # all validation data regional aggregations happens here
  # exitsting "validation.mif" file is loaded if all functions are set to append=TRUE
  valfile <- "/../validation.mif"

  calcOutput(type="ValidPopulation", datasource="WDI", aggregate="REG+GLO", file=valfile, append=TRUE, na_warning=FALSE, try=TRUE)

}
