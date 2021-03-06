
\dontrun{

# basic usage
require(optimx)
gm1 <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
             data = cbpp, family = binomial)
gm_all <- all_fit(gm1)
t(sapply(gm_all,fixef)) ## extract fixed effects
sapply(gm_all,logLik) ## log-likelihoods
sapply(gm_all,getME,"theta") ## theta parameters
!sapply(gm_all,inherits,"try-error") ## was fit OK?


## for GLMMs:
require("mlmRev") # for data
gm1 <- mixed(use ~ age*urban + (1 | district), family = binomial, 
             data = Contraception, method = "LRT")
gm_all <- all_fit(gm1$full_model)
sapply(gm_all,logLik)

## use allFit in combination with expand.re = TRUE
data("sk2011.2") # see example("mixed")
sk2_aff <- droplevels(sk2011.2[sk2011.2$what == "affirmation",])
sk_m2 <- mixed(response ~ instruction*inference*type+(inference*type||id), sk2_aff,
               expand_re = TRUE)
sk_m2
sk_m2_allFit <- all_fit(sk_m2$full_model)
sk_m2_allFit # all fits fail

sk_m2_allFit <- all_fit(sk_m2$full_model, data = sk_m2$data) # works
t(sapply(sk_m2_allFit,fixef))
sapply(sk_m2_allFit,logLik)

}
