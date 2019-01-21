# Created by Oleksandr Sorochynskyi
# On 21 Jan, 2019

brass.table <- function(qx, qx.ref) {
  stopifnot(length(qx) == length(qx.ref))

  yx <- logit(qx)
  yx.ref <- logit(qx.ref)

  # lm doesn't discard Inf values
  yx[is.infinite(yx)] <- NA;

  logit.transform <- data.frame(y=yx, z=yx.ref)
  brass.lm <- lm(y ~ z, data= logit.transform, na.action = na.omit)

  y.hat <- predict.lm(brass.lm,
                       newdata= logit.transform,
                       type= "response",
                       interval = "confidence",
                       level= 0.95)
  qx.hat <- data.frame(logit.inv(y.hat))
  age <- 1:nrow(qx.hat) - 1
  data.frame(age=age, qx= qx.hat$fit, qx.upr= qx.hat$upr, qx.lwr= qx.hat$lwr);
}
