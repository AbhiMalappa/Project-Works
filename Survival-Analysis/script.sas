data shopko_sa;
set sa.sa;
run;


censored = 0;
if tt1st_purch > 0 then censored = 1;
run;


proc lifereg data = shopko_sa;
model tt1st_purch*censored(0) =
discount dir_mail email1 hh_size hh_income/dist = exponential;
output out = output p=median std = s; 
where seg = 2;
run;


distribution choices;
gamma llogistic lnormal weibull exponential ;

proc means data = output; run;

