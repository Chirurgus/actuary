# Created by Oleksandr Sorochynskyi
# On 21 Jan, 2019

#' Coale-Kisker method for closing life tables
#'
#' Extend a life table to very old ages using the Coale-Kisker method.
#' @param qx The probabilities of death, per age
#' @param x.start Age from which the method is applied
#' @param x.end Final age
#' @param kx.peak Age where kx are supposed to start to decline
#' @param qx.end Target qx for age=x.end
#' @keywords coale, kisker, close, kx
#' @export
#' @examples
#' # qx only go up to 110 years old
#' qx <- read.qx()
#' # new qx will go up to 130 years old
#' qx.extended <- coale.kisker.close(qx, x.end= 130)
coale.kisker.close <- function(qx, x.start = 65, x.end = 110, kx.peak = 80, qx.end = .7) {
  # convert ages to indicies
  x.start <- x.start + 1
  x.end <- x.end + 1
  kx.peak <- kx.peak + 1

  mx <- hazard.rate(qx)
  mx.end <- hazard.rate(qx.end)

  # kx exact
  kx <- sapply(tail(seq_along(qx), length(qx) - 1), function(age) {
    log(mx[age]/mx[age - 1])
  })
  # First k0 is undefined
  kx <- c(NA, kx)


  # kx projection

  # kx decreasing rate
  s <- (log(mx.end/mx[kx.peak - 1]) - (x.end - kx.peak + 1) * kx[kx.peak])/sum(1:(x.end-kx.peak))

  kx <- sapply(2:x.end, function(age) {
    k.peak <- log(mx[kx.peak]/mx[kx.peak - 1])

    if (age <= kx.peak) {
      kx[age]
    }
    else {
      k.peak + s * (age-kx.peak)
    }
  });

  mx.estim <- sapply(1:x.end, function(age) {
    if (age <= x.start) {
      mx[age]
    }
    else {
      mx[x.start] * exp(sum(kx[x.start:(age - 1)]))
    }
  });

  1 - exp(-mx.estim)
}
