/*
  stan model for linear mixed effects model
*/

data {
  int<lower=0> N;
  int<lower=0> G;
  array[N] int<lower=1,upper=G> Gind;
  vector[N] X;
  vector[N] Y;
}

parameters {
  real alpha;
  real beta;
  vector[G] epsilon;
  vector<lower=0>[2] sigma;
}

transformed parameters {
   vector[N] mu;
   
   for (n in 1:N)
     mu[n] = alpha + beta * X[n] + epsilon[Gind[n]];
}

model {
  Y ~ normal(mu, sigma[1]);
  epsilon ~ normal(0, sigma[2]);
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);
  sigma ~ normal(0, 5);
}
