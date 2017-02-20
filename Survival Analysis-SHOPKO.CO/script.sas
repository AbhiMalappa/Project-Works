**Segmentation - Kmeans**

proc standard data =General_retail mean=0 std=1 out = retail;
    var active_shoe baby_personal_care baby_furn_basics beauty_aids boys_apparel cards_books_mag consumer_electron electronic_service
    furniture girls_apparel health_aid_otc home_decor home_organization household_supplies
    intimate_apparel jewelry_watches junior_apparel kitchen_tabletop lawn_garden leased_shoe licensed_sports linens_domestics mens_apparel
    missy_apparel optical patio_furniture pet_supplies pharmacy plus_apparel school_office_sup small_electronics
    sports_rec toys trim_a_tree womens_accessories unallocated home_improvement
    email_engage_rate distinct_store_visit_num
    trans_num item_amt_sum;

proc fastclus data=active_cust maxclusters=4 maxiter=1000 converge=0 out=retail;
    var baby_personal_care beauty_aids cards_books_mag consumer_electron 
    food_beverage girls_apparel health_aid_otc home_decor home_improvement home_organization household_supplies 
    intimate_apparel kitchen_tabletop licensed_sports linens_domestics mens_apparel
    pharmacy school_office_sup small_electronics
    sports_rec toys trim_a_tree womens_accessories ;
run;


**Survival Analysis**
data shopko_sa;
    set sa_sa;
run;
censored = 0;
if tt1st_purch > 0 then censored = 1;
run;


proc lifereg data = sa_data;
    model tt1st_purch*censored(0) =
    discount dir_mail email1 hh_size hh_income / dist = exponential;
    output out = output p=median std = s; 
    where seg = 2;
run;


distribution choices;
    gamma llogistic lnormal weibull exponential;
run;

proc means data = output; 
run;



** Marcom value **
proc reg data = shopko_sa;
    model revenue = em1 em2 sms dm/vif collin;
    output out = marcom_resid p = Prev r = Rrev student = student;
run;
quit;
    proc means data = marcom_resid; 
run;


** Market basket **
data test;
set shopko_co;
logit_a = 0; logit_b = 0; logit_c = 0; logit_d = 0; logit_e = 0;
if active_shoe  > 0 then logit_active_shoe  =1;
if baby_personal_care  > 0 then logit_baby_personal_care  =1;
if baby_furn_basics > 0 then logit_baby_furn_basics =1;
if beauty_aids  > 0 then logit_beauty_aids  =1;
if boys_apparel  > 0 then logit_boys_apparel  =1;
if cards_books_mag  > 0 then logit_cards_books_mag  =1;
if consumer_electron  > 0 then logit_consumer_electron  =1;
if electronic_service > 0 then logit_electronic_service =1;
if food_beverage  > 0 then logit_food_beverage  =1;
if furniture  > 0 then logit_furniture  =1;
if girls_apparel  > 0 then logit_girls_apparel  =1;
if health_aid_otc  > 0 then logit_health_aid_otc  =1;
if home_decor > 0 then logit_home_decor =1;
run;

proc logistic descending data = test;
model logit_lawn_garden =logit_ logit_active_shoe logit_baby_personal_care logit_electronic_service logit_furniture logit_patio_furniture logit_household_supplies;
run; 

