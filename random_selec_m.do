********************************
* REPLICATION EXERCISE - GRPOL *
********************************


# delimit
clear
set mem 500m
set matsize 10000
set more off


* GLOBALS
global repo = "/Users/Erin/Documents/GitHub/GR5760_replication"
cd $repo 

use "$repo/macoursetal_main", clear 

* Define global varlists for regressions
global depvars_input_i_05 = "male age_transfer  s2mother_inhs_05  ed_mom yrsedfath tvip_05 weight_05 height_05 a10whz_05 bweight  weighted_05 s4p6_vitamina_i_05 s4p7_parasite_i_05"   
global depvars_hhchar_05  = "s1male_head_05 s1hhsize_05 s1hhsz_undr5_05 s1hhsz_5_14_05 s1hhsz_15_24_05 s1hhsz_25_64_05 s1hhsz_65plus_05 s3ap5_rooms_h_05 s3ap23_stime_h_05 s3ap24_htime_h_05 s3ap25_hqtime_h_05 s3atoilet_hh_05 s3awater_access_hh_05 s3aelectric_hh_05 s11ownland_hh_05 cons_tot_pc_05 cons_food_pc_05 propfood_05 prstap_f_05 pranimalprot_f_05 prfruitveg_f_05"  

/* drop birthweight for children born between baseline and first transfer*/
replace bweight=. if weighted_05==.


/*RANDOMIZATION : TABLE 1 - SAMPLE OF ALL CHILDREN WITH TESTS IN 2008 AND THEIR HOUSEHOLDS*/
/*RANDOMIZATION : TABLE 1 - SAMPLE OF ALL CHILDREN WITH TESTS IN 2008 AND THEIR HOUSEHOLDS*/
/*RANDOMIZATION : TABLE 1 - SAMPLE OF ALL CHILDREN WITH TESTS IN 2008 AND THEIR HOUSEHOLDS*/

/*
COMMENTED OUT EMH - these variables are already defined in the saved dataset -- go figure 

bysort hogarid_old: egen cpfirstchild = min(cp) if sample08==1

gen basicod = (itt_all_i==2)
gen trainingd = (itt_all_i==3)
gen grantd = (itt_all_i==4)
*/

est clear



foreach x of global depvars_input_i_05{

  regress `x' T if sample08==1, robust cluster(unique_05)
  test T
  outreg2 using table1_sample08, excel addstat(Prob > F, r(p))

  regress `x' basicod trainingd grantd if sample08==1, robust cluster(unique_05)
  test basicod = trainingd = grantd
  outreg2 using table1a_sample08, excel addstat(Prob > F, r(p))
  
  regress `x' basicod trainingd grantd if sample08==1, robust cluster(unique_05)
  test basicod =  grantd
  outreg2 using table1b_sample08, excel addstat(Prob > F, r(p))
}

est clear



foreach x of global depvars_hhchar_05{

  regress `x' T if  cp== cpfirstchild & sample08==1, robust cluster(unique_05)
  test T
  outreg2 using table1_sample08, excel addstat(Prob > F, r(p))
  
  regress `x' basicod trainingd grantd if  cp== cpfirstchild & sample08==1, robust cluster(unique_05)
  test basicod = trainingd = grantd
  outreg2 using table1a_sample08, excel addstat(Prob > F, r(p))
  
    regress `x' basicod trainingd grantd if  cp== cpfirstchild & sample08==1, robust cluster(unique_05)
  test basicod =  grantd
  outreg2 using table1b_sample08, excel addstat(Prob > F, r(p))


}



