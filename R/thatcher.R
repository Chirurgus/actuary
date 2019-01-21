# Created by Oleksandr Sorochynskyi
# On 21 Jan, 2019

mu.tatcher <- function(x, phi, beta, gamma) {
  stopifnot(length(phi) == 1,
            length(beta) == 1,
            length(gamma) == 1)
  z <- exp( beta * (x - phi) )

  z/(1 + z) + gamma
}

table.tatcher <- function(qx, ages) {
  stopifnot(length(qx) == length(ages))

  mx <- qx/(1-qx)

  sq.dist <- function(params, mx.obs, ages.obs) {
    phi <- params[1];
    beta <- params[2];
    gamma <- params[3];

    # Clamp parameters
    beta <- logit.inv(beta);

    mx.model <- mu.tatcher(ages.obs, phi, beta, gamma);

    index <- !is.na(mx.obs) & !is.infinite(mx.obs)

    diff <- mx.model[index] - mx.obs[index]
    res <- sum(diff^2);
    res;
  }
