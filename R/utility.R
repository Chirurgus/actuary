# Created by Oleksandr Sorochynskyi
# On 21 Jan, 2019

#' Hazard rate
#'
#' Calculate the hazard rate from the probability of death. Under the asumption of constant hazard rate.
#' @param p.death Vector of probabilities of death
#' @keywords hazard_rate, mu, mx, qx
#' @export
#' @references
#'
#' @examples
#' mu <- hazard.rate(qx)
hazard.rate <- function(p.death) {
  -log(1-qx)
}

logit <- function(x) {
  log(x/(1-x))
}
logit.inv <- function(x) {
  exp(x)/(exp(x) + 1)
}
