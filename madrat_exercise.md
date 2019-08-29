---
title: "MADRaT Exercise"
author: "David Chen"
date: "2019-08-29"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{MADRat exercise}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---



In this exercise, we will practice reading in and using input data through MadRAT. We will create our own MADRat-based package for data input processing package. For this example, we will use World Bank World Development Indicator (WDI) data, with the wbstats library for easy direct download.

## "mymadrat" Package
First, create a new package through the "New Project" option in RStudio and call it "mymadrat". Add madrat.R script to the R folder. 


```r
### madrat.R
#' @importFrom madrat vcat
> .onLoad <- function(libname, pkgname){
> madrat::setConfig(packages=c(madrat::getConfig("packages"),pkgname),
		  .cfgchecks=FALSE, .verbose=FALSE)
> }
#create an own warning function which redirects calls to vcat (package internal)
> warning <- function(...) vcat(0,...)
# create a own stop function which redirects calls to stop (package internal)
> stop <- function(...) vcat(-1,...)
# create an own cat function which redirects calls to cat (package internal)
> cat <- function(...) vcat(1,...)

```


## MadRAT Functions - Exercise

We will create new download, read, and convert functions for WDI indicators Population, GDP, Employment rate, and Employment share in Agriculture, and agricultural GDP. Each function is a separate file, and each indicator a parameter within each function.
Note that the functions need to be named with the wrapper, for example, readWDI.R

Remember that complete magclass objects are an array with the the regional (ISO3) dimension in the first dimension, the temporal dimension in the second, and data values in the third dimemsions (3.1, 3.2...). 

### Download function

Note that if direct download not possible, data files can be manually created in the inputdatasources folder. In that case, a download function is not necessary.


```r
install.packages("WDI")
library(WDI)

downloadWDI <- function(...){

# Use the WDI() function to easily direct download WDI data
install.packages("WDI")
library(WDI)

# Download these indicators:
# "NY.GDP.MKTP.KD" National GDP in 2010 USD
# "SP.POP.TOTL" Total population
# "SL.EMP.TOTL.SP.ZS" Employment ratio
# "SL.AGR.EMPL.ZS" Employment in agriculture as % of total employment
# "NV.AGR.TOTL.KD" Agricultural GDP in 2010 USD

#Save the downloaded data as a .Rda file as the last step of the function
save()
}

```

### Read function

Read functions are the first step in transforming input data into magclass objects. They should be as simple as possible, with most steps of filling in, transforming, and data cleaning reserved for the convert function. The Read function should be able to specify between indicators (subtypes).


```r

readWDI <- function(...){

#begin by loading the dataset saved by the previous download function. Note that only the file name and extension are required, as madrat is configured to search for matching sources in its sources folder.
load()
  
#Use as.magpie() to transform the dataset into a magclass object. Remember that magclass objects always have the spatial indicator (iso code, not country name) in their 1st dimension & the temporal dimension in 2nd dimenson. It is ideal to reshape the data into 'tidy' format, with only the last column containing data as.magpie(...tidy=TRUE). 

wdi <- as.magpie(melt(wdi,id.vars = c("iso2c","year")), ...)

#Once the magclass object is created, we can specify the subtype/indicator desired, so that the read function only returns one indicator at a time. Use [] to subset.
  

}
```

### Convert Function

The convert function will complete the magclass object: All 249 countries represented in MAGPie need to have a value and be in ISO3 country code.


```r

convertWDI <- function(...){

#Units need to be regularized in this function as well, for instance, MAgPIE uses population in millions:
  if (subtype %in% "NY.GDP.MKTP.KD", "SP.POP.TOTL","NV.AGR.TOTL.KD" ) {
    x <- x/1e6
}

# Now we convert the iso2c countrycodes into iso3c, using the function countrycode(), and the magclass call getRegions. Note that some regions have now been turned into NA; it would be important to check that no information is lost. In this case they are mostly WB aggregate regions. 

getRegions(x)<-countrycode(getRegions(x),"iso2c","iso3c")
x<-x[!is.na(getCells(x)),,]
x <- clean_magpie(x)

#clean_magpie() cleans MAgPIE objects so that they follow some extended magpie object rules (currently it makes sure that the dimnames have names and removes cell numbers if it is purely regional data)

#Now fill the missing countries using toolCountryFill(), choose an arbitrary fill value for now.

x <- toolCountryFill()

#Now we have a complete MAgPIE object! congratulations. 

return(x)}
  

```

### calcOutput

Magclass objects lend themselves easily to calculations between them. Use the read Functions we just wrote to calculate agricultural GDP as a percentage of total gdp, using a new calcOutput function.
Read and download functions are called with readSource("file"), downloadSource("file")


```r
calcAgGDP <- function(){

readSource("WDI", subtype="NY.GDP.MKTP.KD")

#note that by default, readSource also converts; otherwise set convert=FALSE
  
}

```


## Validation

Madrat treats post-model run validation separately from the input data, though these often come from the same source. All validation functions are named using the "calcValid" output, and combine to create a .pdf validation document that compares model indicators with available validation data.
The "fullVALIDATION" function combines all calcValid functions and produces a .mif file. Open 

