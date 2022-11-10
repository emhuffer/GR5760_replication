# delimit;
gen ln_pce08 =ln(cons_tot_pc_08);
egen pce_C025=pctile(ln_pce06) if T==0, p(2.5);
egen pce_C975=pctile(ln_pce06) if T==0, p(97.5);
gen xC=1 if ln_pce06>pce_C025 & ln_pce06<pce_C975;

** generate identifiers for 1st and 99th percentile to define grids in fan**;       
mac def depvars_st1 " z_language_06  z_social_06  z_tvip_06  z_behavior_06  z_memory_06 z_finmotor_06  z_grmotor_06  z_legmotor_06 z_height_06  z_weight_06";

***********FAN REGRESSIONS ECD OUTCOMES ON LOG PCE FOR CONTROL - GRADIENTS FIG ************;
