
Proc print data=shopko_sa; 
Run;

proc freq data = shopko_sa;
table purchase; 
where purchase > 25;
run;

*Correlation check*

Proc corr data=shopko_sa;
  Var email_forward_rate email_unsub_rate email_engage_rate	distinct_store_visit_num	trans_num	item_num	item_distinct_num	item_amt_sum	net_amt_per_trans	item_per_trans	net_amt_per_item;
Run;

* Correct collin by ridge reg *
proc reg data = mg.segment3;
model felv = flv_vca flv_comp_hi flv_comp_lo flv_vca_hi share_well_visits	share_visit_boarding any_puppy_kitten		
share_visit_food/collin; 	
run;

proc reg data = mg.segment3 outvif
outest = mg.s3b 
ridge = 0 to 1 by 0.05;
model felv = flv_vca 
flv_comp_hi flv_comp_lo flv_vca_hi 
share_well_visits	share_visit_boarding any_puppy_kitten		
share_visit_food/collin; 	
run; 
quit;


proc logistic descending data = test;
  model logit_lawn_garden =logit_ logit_active_shoe logit_baby_personal_care logit_electronic_service logit_furniture logit_patio_furniture logit_household_supplies;
run;

proc reg data = shopko_sa;
  model total_txns = hhage hhkids cmpns tenure / dist=poisson ;
  output out = regress p = predicted;
run;

Proc gPlot data=shopko_sa;
  Plot predict*logit_lawn_garden;
Run;


* graphs *
proc sort data = pred;
by total_txns;
proc gplot data = pred;
plot total_txns*pred_tottxns = 1;
run;

proc corr data = regress;
  var total_txns predicted; run;


*** ELASTICITY MODELING ***

proc reg data = merge;
model total_items = 
recency
response
unique_sizes
unique_depts
tenure
retained_flag
cmpns
pct_response
hhage
hhincome/collin;
run; quit;

* calculating elasticity *;

proc reg data = mg.segment1; 
  model well_visits =  exam_vca exam_comp_hi exam_comp_lo exam_vca_hi;
run;
proc means data = mg.segment1; var well_visits  exam_vca ; 
run;
proc reg data = mg.segment4 ;
model well_visits =  exam_vca 	exam_comp_hi 	exam_comp_lo 	exam_vca_hi  tenure   
share_visit_boarding	any_puppy_kitten; 
run; 




