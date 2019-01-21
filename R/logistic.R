# Created by Oleksandr Sorochynskyi
# On 21 Jan, 2019

mu.logistic <- function(x, theta1, theta2, theta3, sigma.sq) {
  stopifnot(length(theta1) == 1,
            length(theta2) == 1,
            length(theta3) == 1,
            length(sigma.sq) == 1);

  numerator <- theta2 * exp( theta3 * x);
  denumenator <- 1 + sigma.sq * (theta2/theta3) * (exp( theta3 * x ) - 1);
  theta1 + numerator/denumenator;
}

table.logistic <- function(qx, ages) {
  warning("Ce methode ne marche.")
  stopifnot(length(qx) == length(ages))

  mux <- -log(1-qx)

  sq.dist <- function(params, mu.obs, ages.obs) {
    stopifnot(length(params) == 4)

    theta1 <- params[1];
    theta2 <- params[2];
    theta3 <- params[3];
    sigma.sq <- params[4];

    index <- !is.na(mu.obs) & !is.infinite(mu.obs)

    mu.model <- mu.logistic(ages.obs[index], theta1, theta2, theta3, sigma.sq);

    diff <- mu.model - mu.obs[index]
    sum(diff^2)
  }

  default.values = c(runif(1), runif(1), runif(1), 1)
  #upper <- list(theta1= Inf, theta2= Inf, theta3= Inf, sigma.sq= Inf);
  #lower <- list(theta-Inf= -Inf, theta-Inf= -Inf, theta3= -Inf, sigma.sq= 1);
  optim.res <- optim(default.values, sq.dist,  mu.obs= mux, ages.obs= ages);

  par <- optim.res$par;
  mu.hat <- unname(sapply(ages, function(a) mu.logistic(a, par[1], par[2], par[3], par[4])))
  qx.hat <- 1 - exp(-mu.hat)
  browser()
  data.frame(qx= qx.hat, age= ages)
}
