# Created by Oleksandr Sorochynskyi
# On 21 Jan, 2019

#' French reference life table.
#'
#' TH 00-02 - Table Hommes 00-02
#'
#' @docType data
#'
#' @usage data(grav)
#'
#' @format Comma seperated .txt file
#'
#' @keywords datasets, lifetable
#'
#' @examples
#' data(th0002)
#' qx <- th0002$qx
#' ages <- grav$age
#' \donttest{iplotCurves(phe, times)}
"thf0002"


#' Arabidopsis QTL data on gravitropism
#'
#' Data from a QTL experiment on gravitropism in
#' Arabidopsis, with data on 162 recombinant inbred lines (Ler x
#' Cvi). The outcome is the root tip angle (in degrees) at two-minute
#' increments over eight hours.
#'
#' @docType data
#'
#' @usage data(grav)
#'
#' @format An object of class \code{"cross"}; see \code{\link[qtl]{read.cross}}.
#'
#' @keywords datasets
#'
#' @references Moore et al. (2013) Genetics 195:1077-1086
#' (\href{https://www.ncbi.nlm.nih.gov/pubmed/23979570}{PubMed})
#'
#' @source \href{https://phenome.jax.org/projects/Moore1b}{QTL Archive}
#'
#' @examples
#' data(grav)
#' times <- attr(grav, "time")
#' phe <- grav$pheno
#' \donttest{iplotCurves(phe, times)}
"grav"
