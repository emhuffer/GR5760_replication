# delimit;
clear;
set mem 500m;
set matsize 10000;
set more off;
capture log close;
pause on;local path "/karen/nicaragua/follow_up_2008/ecd/do_files_July2011/AEJapp_data";
cd `path';log using main_analysis.log, replace;
log off;

            use macoursetal_main;
/** DEFINITION OF DEPENDENT VARIABLES **//*FALL SAMPLE STANDARDIZED TEST SCORES*/mac def C2006_vars1z  "z_tvip_06 z_language_06 z_memory_06 z_social_06 z_behavior_06";mac def C2006_vars2z  "z_grmotor_06 z_finmotor_06 z_legmotor_06 z_height_06 z_weight_06";mac def C2008_vars1z  "z_tvip_08 z_language_08 z_memory_08 z_martians_08 z_social_08 z_behavior_08";mac def C2008_vars2z  "z_grmotor_08 z_finmotor_08 z_legmotor_08 z_height_08 z_weight_08";mac def Cvars_06z "$C2006_vars1z $C2006_vars2z";mac def Cvars_08z "$C2008_vars1z $C2008_vars2z";/*STANDARDIZED TEST SCORES LIMITED TO KIDS WHO TOOK A GIVEN TEST TWICE*/mac def C2006_vars1zm  "z_tvip_06m z_language_06m z_memory_06m z_social_06m z_behavior_06m";mac def C2006_vars2zm  "z_grmotor_06m z_finmotor_06m z_legmotor_06m z_height_06m z_weight_06m";mac def C2008_vars1zm  "z_tvip_08m z_language_08m z_memory_08m z_martians_08m  z_social_08m z_behavior_08m";mac def C2008_vars2zm  "z_grmotor_08m z_finmotor_08m z_legmotor_08m z_height_08m z_weight_08m";mac def Cvars_06zm "$C2006_vars1zm $C2006_vars2zm";mac def Cvars_08zm "$C2008_vars1zm $C2008_vars2zm";gen age_transfer1 = age_transfer+40;qui tab age_transfer1, gen(CEDAD);drop age_transfer1;/* CONTROL VARIABLES */mac def controls6 "CEDAD* male s1age_head_05 s1hhsize_05 s1hhsz_undr5_05 s1hhsz_5_14_05 s1hhsz_15_24_05 s1hhsz_25_64_05                s1hhsz_65plus_05 s1male_head_05 ed_mom_inter ed_mom_miss bweight_miss bweight_inter   tvip_05_miss tvip_05_inter  height_05_miss                height_05_inter weight_05_miss weight_05_inter               MUN* com_haz_05 com_waz_05 com_tvip_05 com_control_05 com_vit_05 com_deworm_05 com_notvip";            
log on;
********************************MAIN RESULTS 2006***************************************;********************************MAIN RESULTS 2006***************************************;********************************MAIN RESULTS 2006***************************************;********************************MAIN RESULTS 2006***************************************;********************************MAIN RESULTS 2006***************************************;
/*2006*/

/*STANDARDIZED VALUES*/

cap program drop _all;prog def suests;   qui suest  M1 M2 M3 M4 M5 M6 M7 M8 M9 M10, cluster(unique_05) dir;   display "ALL VARIABLES";   lincom ([M1_mean]T+[M2_mean]T+[M3_mean]T+[M4_mean]T+[M5_mean]T+[M6_mean]T+[M7_mean]T+[M8_mean]T+[M9_mean]T+[M10_mean]T)/10;   display "COGNITIVE AND SOCIO-EMOTIONAL VARIABLES";   lincom ([M1_mean]T+[M2_mean]T+[M3_mean]T+[M4_mean]T+[M5_mean]T)/5;   display "PHYSICAL VARIABLES";   lincom ([M6_mean]T+[M7_mean]T+[M8_mean]T+[M9_mean]T+[M10_mean]T)/5;    display "ALL VARIABLES--EXCLUDING PARENT REPORTS";   lincom ([M1_mean]T+[M3_mean]T+[M8_mean]T+[M9_mean]T+[M10_mean]T)/5;   display "COGNITIVE AND SOCIO-EMOTIONAL VARIABLES--EXCLUDING PARENT REPORTS";   lincom ([M1_mean]T+[M3_mean]T)/2;   display "PHYSICAL VARIABLES--EXCLUDING PARENT REPORTS";   lincom ([M8_mean]T+[M9_mean]T+[M10_mean]T)/3;    end;/*NO CONTROLS*//* POINT ESTIMATES INDIVIDUAL TEST */est clear;mac def count=1;foreach x of global Cvars_06z{;  qui regress `x'  T CEDAD* male  , robust cluster(unique_05);      outreg2 T using nocontrols_06_june2111, excel se append;  est store M$count;  mac def count=$count+1;};/* SURE */est clear;mac def count=1;foreach x of global Cvars_06z {;  qui regress `x'  T CEDAD* male    ;  est store M$count;  mac def count=$count+1;};suests;est clear;
/*WITH CONTROLS */

est clear;
mac def count=1;
foreach x of global Cvars_06z{;
qui  regress `x'  T $controls6  , robust cluster(unique_05);outreg2 T using controls6_06_june2111, excel se append;
  est store M$count;
  mac def count=$count+1;
};

est clear;
mac def count=1;
foreach x of global Cvars_06z{;
  qui regress `x'  T $controls6  ;
  est store M$count;
  mac def count=$count+1;
};

suests;


est clear;
mac def count=1;
foreach x of global Cvars_06zm{;
  qui regress `x'  T $controls6  ;
  est store M$count;
  mac def count=$count+1;
};

suests;**** 2006 BUT ONLY FOR KIDS FOR WHOM TITULAR = MOM AND PRESENT AT BASELINE AS WELL AS 06**;**** 2006 BUT ONLY FOR KIDS FOR WHOM TITULAR = MOM AND PRESENT AT BASELINE AS WELL AS 06**;**** 2006 BUT ONLY FOR KIDS FOR WHOM TITULAR = MOM AND PRESENT AT BASELINE AS WELL AS 06**;est clear;est clear;mac def count=1;foreach x of global Cvars_06z{;  qui regress `x'  T $controls6   if  titmom_06==1 & mominhouse_06==1;  est store M$count;  mac def count=$count+1;};suests;********************************MAIN RESULTS 2008***************************************;********************************MAIN RESULTS 2008***************************************;********************************MAIN RESULTS 2008***************************************;********************************MAIN RESULTS 2008***************************************;********************************MAIN RESULTS 2008***************************************;/*2008*/
/*STANDARDIZED VALUES*/

cap program drop _all;
prog def suests;

   qui suest  M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11, cluster(unique_05) dir;
   display "ALL VARIABLES";
   lincom ([M1_mean]T+[M2_mean]T+[M3_mean]T+[M4_mean]T+[M5_mean]T+[M6_mean]T+[M7_mean]T+[M8_mean]T+[M9_mean]T+[M10_mean]T+[M11_mean]T)/11;
   display "ALL VARIABLES WITHOUT MARTIANS TEST";
   lincom ([M1_mean]T+[M2_mean]T+[M3_mean]T+[M5_mean]T+[M6_mean]T+[M7_mean]T+[M8_mean]T+[M9_mean]T+[M10_mean]T+[M11_mean]T)/10;
   display "COGNITIVE AND SOCIO-EMOTIONAL VARIABLES";
   lincom ([M1_mean]T+[M2_mean]T+[M3_mean]T+[M4_mean]T+[M5_mean]T+[M6_mean]T)/6;
   display "COGNITIVE AND SOCIO-EMOTIONAL VARIABLES WITHOUT MARTIANS TEST";
   lincom ([M1_mean]T+[M2_mean]T+[M3_mean]T+[M5_mean]T+[M6_mean]T)/5;
   display "PHYSICAL VARIABLES";
   lincom ([M7_mean]T+[M8_mean]T+[M9_mean]T+[M10_mean]T+[M11_mean]T)/5; 
   display "ALL VARIABLES--EXCLUDING PARENT REPORTS";
   lincom ([M1_mean]T+[M3_mean]T+[M4_mean]T+[M9_mean]T+[M10_mean]T +[M11_mean]T)/6;
   display "COGNITIVE AND SOCIO-EMOTIONAL VARIABLES--EXCLUDING PARENT REPORTS";
   lincom ([M1_mean]T+[M3_mean]T+[M4_mean]T)/3;
   display "PHYSICAL VARIABLES--EXCLUDING PARENT REPORTS";
   lincom ([M9_mean]T+[M10_mean]T +[M11_mean]T)/3; 


end;

/*NO CONTROLS*/

est clear;
mac def count=1;
foreach x of global Cvars_08z{;
qui  regress `x'  T CEDAD* male   , robust cluster(unique_05);  outreg2 T using nocontrols_08_june2111, excel se append; 
  est store M$count;
  mac def count=$count+1;
};

est clear;
mac def count=1;
foreach x of global Cvars_08z{;
  qui regress `x'  T CEDAD* male    ;
  est store M$count;
  mac def count=$count+1;
};

suests;/* WITH CONTROLS */est clear;mac def count=1;foreach x of global Cvars_08z{;  qui regress `x'  T $controls6  , robust cluster(unique_05);outreg2 T using controls6_08_june2111, excel se append;  est store M$count;  mac def count=$count+1;};est clear;mac def count=1;foreach x of global Cvars_08z{;   qui regress `x'  T $controls6  ;  est store M$count;  mac def count=$count+1;};suests;est clear;mac def count=1;foreach x of global Cvars_08zm{;   qui regress `x'  T $controls6  ;  est store M$count;  mac def count=$count+1;};suests;*** tit = mom  and in house in 08***;*** tit = mom  and in house in 08***;*** tit = mom  and in house in 08***;est clear;	mac def count=1;foreach x of global Cvars_08z{; qui  regress `x'  T $controls6    if  titmom_08==1 & mominhouse_08==1;  est store M$count;  mac def count=$count+1;};suests;***** CONSUMPTION RESULTS*******;***** CONSUMPTION RESULTS*******;***** CONSUMPTION RESULTS*******;***** CONSUMPTION RESULTS*******;***** CONSUMPTION RESULTS*******;/* DEFINE DEPENDENT VARIABLES */gen lnpce_05 =ln(cons_tot_pc_05);gen lnpce_08 =ln(cons_tot_pc_08);gen lnpce_06 =ln(cons_tot_pc_06);/* DEFINE SET OF HOUSEHOLD LEVEL CONTROL VARIABLES INCLUDING BASELINE CONSUMPTION*/mac def controls6h "s1age_head_05 s1hhsize_05 s1hhsz_undr5_05 s1hhsz_5_14_05 s1hhsz_15_24_05 s1hhsz_25_64_05                s1hhsz_65plus_05 s1male_head_05  MUN* com_haz_05 com_waz_05 com_tvip_05 com_control_05 com_vit_05 com_deworm_05 com_notvip lnpce_05";                     gen basico = T;replace basico = . if inlist(itt_all_i,3,4);gen grant = T;replace grant = . if inlist(itt_all_i,3,2);gen training = T;replace training = . if inlist(itt_all_i,2,4);gen basicod = (itt_all_i==2);gen trainingd = (itt_all_i==3);gen grantd = (itt_all_i==4);** 2006**;** 2006**;** 2006**;/* CONSUMPTION ESTIMATES AT THE HOUSEHOLD LEVEL BY ONLY INCLUDING ONE OBSERVATION PER HOUSEHOLD IN THE SAMPLE *//* HOGARID06 I06 TOGETHER IDENTIFIES A 2006 HOUSEHOLD*//* CP06 IS THE PERSON (INDIVIDUAL) CODE FOR 2006*/gen cp2 = cp06 if z_all_06~=.;bysort hogarid06 i06 : egen mincp = min(cp2) if lnpce_06~=. ; foreach x in lnpce {;qui  regress `x'_06  T if cp06==mincp & cp06!=., robust cluster(unique_05);      outreg2 T using consumption_06_june2111, excel se append;qui  regress `x'_06 basicod trainingd grantd if cp06==mincp& cp06!=., robust cluster(unique_05);  test basicod = trainingd= grantd;  outreg2 basicod trainingd grantd using consumption_06_june2111, excel se append;qui  regress `x'_06  grantd  if inlist(itt_all_i,2,4) & cp06==mincp & cp06!=., robust cluster(unique_05);      outreg2 grantd using consumption_06_june2111, excel pvalue append;  };    foreach x in lnpce  {;qui  regress `x'_06  T $controls6h if cp06==mincp & cp06!=., robust cluster(unique_05);      outreg2 T using consumption_06_june2111, excel se append;    qui  regress `x'_06 basicod trainingd grantd $controls6h if cp06==mincp & cp06!=., robust cluster(unique_05);  test basicod = trainingd= grantd;  outreg2 basicod trainingd grantd using consumption_06_june2111, excel se append;  qui  regress `x'_06  grantd $controls6h if inlist(itt_all_i,2,4) & cp06==mincp & cp06!=., robust cluster(unique_05);      outreg2 grantd using consumption_06_june2111, excel pvalue append;  };** 2008**;** 2008**;** 2008**;/* CONSUMPTION ESTIMATES AT THE HOUSEHOLD LEVEL BY ONLY INCLUDING ONE OBSERVATION PER HOUSEHOLD IN THE SAMPLE *//* AND ONLY INCLUDING HOUSEHOLDS WITH CHILDREN THAT TOOK THE TEST*//* HOGARID08  IDENTIFIES A 2008 HOUSEHOLD*//* CP IS THE PERSON (INDIVIDUAL) CODE FOR 2008*/drop mincp;gen cp3 = cp if z_all_08~=.;bysort hogarid08 : egen mincp = min(cp3)  if lnpce_08~=.;   foreach x in lnpce  {;qui  regress `x'_08  T if cp==mincp & cp~=., robust cluster(unique_05);      outreg2 T using consumption_08_june2111, excel se append;qui  regress `x'_08 basicod trainingd grantd if cp==mincp & cp~=., robust cluster(unique_05);  test basicod = trainingd= grantd;  outreg2 basicod trainingd grantd using consumption_08_june2111, excel se append;  qui  regress `x'_08  grantd  if inlist(itt_all_i,2,4) & cp==mincp & cp~=., robust cluster(unique_05);      outreg2 grantd using consumption_08_june2111, excel pvalue append;  };  foreach x in lnpce {;qui  regress `x'_08  T $controls6h if cp==mincp & cp~=., robust cluster(unique_05);      outreg2 T using consumption_08_june2111, excel se append;   qui  regress `x'_08  basicod trainingd grantd $controls6h if cp==mincp & cp~=., robust cluster(unique_05);  test basicod = trainingd= grantd;        outreg2 basicod trainingd grantd using consumption_08_june2111, excel se append;    qui  regress `x'_08  grantd $controls6h if inlist(itt_all_i,2,4) & cp==mincp & cp~=., robust cluster(unique_05);      outreg2 grantd using consumption_08_june2111, excel pvalue append;  };