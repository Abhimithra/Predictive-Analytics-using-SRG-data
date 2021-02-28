PROC IMPORT DATAFILE= "C:\Users\axt190031\Desktop\Project\Book2.xlsx" 
            DBMS=xlsx REPLACE OUT = data;
			SHEET="Data";
			GETNAMES=YES;
    RUN;
PROC print data = data(obs=10);
run;
proc contents data=data;
run;
proc surveyselect data=data out=data_sampled outall samprate=0.7 seed=2;
run;
data data_train data_test;
 set data_sampled;
 if selected then output data_train; 
 else output data_test;
run;
/* Here we ran regression for age and different beers*/
proc glmselect data=data testdata=data_test seed = 2  plots=none;
class Sex(split); 
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila
/selection=lasso(choose=cv stop=none) hierarchy=single cvmethod=random(10) showpvalues;
 performance buildsscp=incremental;
run;
/* Here we ran regression for age and different beers with including interaction effect*/
proc glmselect data=data testdata=data_test seed = 2  plots=none;
class Sex(split); 
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila @2
/selection=lasso(choose=cv stop=none) hierarchy=single cvmethod=random(10) showpvalues;
 performance buildsscp=incremental;
run;
/* Here we ran regression for with all parameters using forward selection with apha=0.15 as selection criterion*/
proc glmselect data=data_train testdata=data_test  plots=none;
 class Sex(split)  snacking_in_last_24_hrs_(split) Glten_free_(split) Dairy_free(split) Nut_free(split) Diabetic(split) Plant_based_diet(split) Vegan(split) Vegetarian(split) Low_sodium(split) Low_carb(split) Low_calorie(split) Non_GMO(split) Antibiotic_free(split) Hormone_free(split) Allergen_free(split) Locally_sourced(split) Marriage_status(split) Education(split) Race(split) employement(split);
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila|alcohol_consumption|snacking_in_last_24_hrs_|Kroger_Safeway| Target| Walmart| wholefoods_trader_joes| sams_costco| dollar_store| cooking_score| No_sale_no_shop| induldge_in_food| natural_food| nat_food_better_for_me___envr| reward_w__sth_tasty| balance_healthy___unhealthy_food|give_up_convinience_for_health| buy_store_brands| eat_organic| no_junk_food_in_home| diff_types_of_food| new_recipes| fam_says_am_good_cook| change_stores_to_eat_healthier| change_stores_to_save_money| advance_meal_plans|brands_to_reflext_my_style| brands_to_support_social_causes| follow_trends_fashion| brands_I_grew_up_with| price_shopper| quality_based_shopping__not__| recommend_food_I_like_to_others| shopping_to_relax| wanting_to_impress_others| prioritize_time_w__fam| variety_in_everyday_life| same_life_week_to_week| looking_for_a_thrill| consider_myself_sophisticated| taste_over_health|Glten_free_| Dairy_free| Nut_free| Diabetic| Plant_based_diet| Vegan| Vegetarian| Low_sodium| Low_carb| Low_calorie| Non_GMO| Antibiotic_free| Hormone_free| Allergen_free| Locally_sourced| _of_household_members| Marriage_status| __of_children| Education| Race| employement| weight__lb_| Height__Inches_@1    
  /selection=forward(select=sl sle=0.15) hierarchy=single showpvalues ;
 performance buildsscp=incremental;
run;
/*ASE in train vs. test data */
/* Here we ran regression for with all parameters using backward selection with cross validation as criteria with 10-folds */
proc glmselect data=data_train testdata=data_test  plots=none;
 class Sex(split)  snacking_in_last_24_hrs_(split) Glten_free_(split) Dairy_free(split) Nut_free(split) Diabetic(split) Plant_based_diet(split) Vegan(split) Vegetarian(split) Low_sodium(split) Low_carb(split) Low_calorie(split) Non_GMO(split) Antibiotic_free(split) Hormone_free(split) Allergen_free(split) Locally_sourced(split) Marriage_status(split) Education(split) Race(split) employement(split);
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila|alcohol_consumption|snacking_in_last_24_hrs_|Kroger_Safeway| Target| Walmart| wholefoods_trader_joes| sams_costco| dollar_store| cooking_score| No_sale_no_shop| induldge_in_food| natural_food| nat_food_better_for_me___envr| reward_w__sth_tasty| balance_healthy___unhealthy_food|give_up_convinience_for_health| buy_store_brands| eat_organic| no_junk_food_in_home| diff_types_of_food| new_recipes| fam_says_am_good_cook| change_stores_to_eat_healthier| change_stores_to_save_money| advance_meal_plans|brands_to_reflext_my_style| brands_to_support_social_causes| follow_trends_fashion| brands_I_grew_up_with| price_shopper| quality_based_shopping__not__| recommend_food_I_like_to_others| shopping_to_relax| wanting_to_impress_others| prioritize_time_w__fam| variety_in_everyday_life| same_life_week_to_week| looking_for_a_thrill| consider_myself_sophisticated| taste_over_health|Glten_free_| Dairy_free| Nut_free| Diabetic| Plant_based_diet| Vegan| Vegetarian| Low_sodium| Low_carb| Low_calorie| Non_GMO| Antibiotic_free| Hormone_free| Allergen_free| Locally_sourced| _of_household_members| Marriage_status| __of_children| Education| Race| employement| weight__lb_| Height__Inches_@1    
 /selection=backward(select=cv) hierarchy=single cvmethod=random(10) showpvalues;
 performance buildsscp=incremental;
run;
/* Here we ran regression for with all parameters using forward selection with mallows Cp as selection criterion*/
/*ASE in train vs. test data */
/* Forward selection with Mallows' cp as criteria */
 proc glmselect data=data_train testdata=data_test  plots=none;
 class Sex(split)  snacking_in_last_24_hrs_(split) Glten_free_(split) Dairy_free(split) Nut_free(split) Diabetic(split) Plant_based_diet(split) Vegan(split) Vegetarian(split) Low_sodium(split) Low_carb(split) Low_calorie(split) Non_GMO(split) Antibiotic_free(split) Hormone_free(split) Allergen_free(split) Locally_sourced(split) Marriage_status(split) Education(split) Race(split) employement(split);
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila|alcohol_consumption|snacking_in_last_24_hrs_|Kroger_Safeway| Target| Walmart| wholefoods_trader_joes| sams_costco| dollar_store| cooking_score| No_sale_no_shop| induldge_in_food| natural_food| nat_food_better_for_me___envr| reward_w__sth_tasty| balance_healthy___unhealthy_food|give_up_convinience_for_health| buy_store_brands| eat_organic| no_junk_food_in_home| diff_types_of_food| new_recipes| fam_says_am_good_cook| change_stores_to_eat_healthier| change_stores_to_save_money| advance_meal_plans|brands_to_reflext_my_style| brands_to_support_social_causes| follow_trends_fashion| brands_I_grew_up_with| price_shopper| quality_based_shopping__not__| recommend_food_I_like_to_others| shopping_to_relax| wanting_to_impress_others| prioritize_time_w__fam| variety_in_everyday_life| same_life_week_to_week| looking_for_a_thrill| consider_myself_sophisticated| taste_over_health|Glten_free_| Dairy_free| Nut_free| Diabetic| Plant_based_diet| Vegan| Vegetarian| Low_sodium| Low_carb| Low_calorie| Non_GMO| Antibiotic_free| Hormone_free| Allergen_free| Locally_sourced| _of_household_members| Marriage_status| __of_children| Education| Race| employement| weight__lb_| Height__Inches_@1    
  /selection=forward(select=cp) hierarchy=single showpvalues;
 performance buildsscp=incremental;
 run;
/* Here we ran regression for with all parameters using backward selection with mallows Cp as selection criterion*/
/*ASE in train vs. test data */
/* Forward selection with Mallows' cp as criteria */
proc glmselect data=data_train testdata=data_test  plots=none;
 class Sex(split)  snacking_in_last_24_hrs_(split) Glten_free_(split) Dairy_free(split) Nut_free(split) Diabetic(split) Plant_based_diet(split) Vegan(split) Vegetarian(split) Low_sodium(split) Low_carb(split) Low_calorie(split) Non_GMO(split) Antibiotic_free(split) Hormone_free(split) Allergen_free(split) Locally_sourced(split) Marriage_status(split) Education(split) Race(split) employement(split);
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila|alcohol_consumption|snacking_in_last_24_hrs_|Kroger_Safeway| Target| Walmart| wholefoods_trader_joes| sams_costco| dollar_store| cooking_score| No_sale_no_shop| induldge_in_food| natural_food| nat_food_better_for_me___envr| reward_w__sth_tasty| balance_healthy___unhealthy_food|give_up_convinience_for_health| buy_store_brands| eat_organic| no_junk_food_in_home| diff_types_of_food| new_recipes| fam_says_am_good_cook| change_stores_to_eat_healthier| change_stores_to_save_money| advance_meal_plans|brands_to_reflext_my_style| brands_to_support_social_causes| follow_trends_fashion| brands_I_grew_up_with| price_shopper| quality_based_shopping__not__| recommend_food_I_like_to_others| shopping_to_relax| wanting_to_impress_others| prioritize_time_w__fam| variety_in_everyday_life| same_life_week_to_week| looking_for_a_thrill| consider_myself_sophisticated| taste_over_health|Glten_free_| Dairy_free| Nut_free| Diabetic| Plant_based_diet| Vegan| Vegetarian| Low_sodium| Low_carb| Low_calorie| Non_GMO| Antibiotic_free| Hormone_free| Allergen_free| Locally_sourced| _of_household_members| Marriage_status| __of_children| Education| Race| employement| weight__lb_| Height__Inches_@1    
  /selection=backward(select=cp) hierarchy=single showpvalues ;
 performance buildsscp=incremental;
run;
/*ASE in train vs. test data */
/* Here we ran regression for with all parameters using Stepwise with Elasticnet regression with AIC as criteria */
proc glmselect data=data_train testdata=data_test  plots=none;
 class Sex(split)  snacking_in_last_24_hrs_(split) Glten_free_(split) Dairy_free(split) Nut_free(split) Diabetic(split) Plant_based_diet(split) Vegan(split) Vegetarian(split) Low_sodium(split) Low_carb(split) Low_calorie(split) Non_GMO(split) Antibiotic_free(split) Hormone_free(split) Allergen_free(split) Locally_sourced(split) Marriage_status(split) Education(split) Race(split) employement(split);
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila|alcohol_consumption|snacking_in_last_24_hrs_|Kroger_Safeway| Target| Walmart| wholefoods_trader_joes| sams_costco| dollar_store| cooking_score| No_sale_no_shop| induldge_in_food| natural_food| nat_food_better_for_me___envr| reward_w__sth_tasty| balance_healthy___unhealthy_food|give_up_convinience_for_health| buy_store_brands| eat_organic| no_junk_food_in_home| diff_types_of_food| new_recipes| fam_says_am_good_cook| change_stores_to_eat_healthier| change_stores_to_save_money| advance_meal_plans|brands_to_reflext_my_style| brands_to_support_social_causes| follow_trends_fashion| brands_I_grew_up_with| price_shopper| quality_based_shopping__not__| recommend_food_I_like_to_others| shopping_to_relax| wanting_to_impress_others| prioritize_time_w__fam| variety_in_everyday_life| same_life_week_to_week| looking_for_a_thrill| consider_myself_sophisticated| taste_over_health|Glten_free_| Dairy_free| Nut_free| Diabetic| Plant_based_diet| Vegan| Vegetarian| Low_sodium| Low_carb| Low_calorie| Non_GMO| Antibiotic_free| Hormone_free| Allergen_free| Locally_sourced| _of_household_members| Marriage_status| __of_children| Education| Race| employement| weight__lb_| Height__Inches_@1    
   /selection=elasticnet(choose=cv stop=none) hierarchy=single cvmethod=random(10) showpvalues ;
 performance buildsscp=incremental;
run;
/* Bagging (Bootstrap sampling and aggregation which gives the average of the best models */
proc glmselect data=data_train testdata=data_test seed = 2  plots=none;
class Sex(split)  snacking_in_last_24_hrs_(split) Glten_free_(split) Dairy_free(split) Nut_free(split) Diabetic(split) Plant_based_diet(split) Vegan(split) Vegetarian(split) Low_sodium(split) Low_carb(split) Low_calorie(split) Non_GMO(split) Antibiotic_free(split) Hormone_free(split) Allergen_free(split) Locally_sourced(split) Marriage_status(split) Education(split) Race(split) employement(split);
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila|alcohol_consumption|snacking_in_last_24_hrs_|Kroger_Safeway| Target| Walmart| wholefoods_trader_joes| sams_costco| dollar_store| cooking_score| No_sale_no_shop| induldge_in_food| natural_food| nat_food_better_for_me___envr| reward_w__sth_tasty| balance_healthy___unhealthy_food|give_up_convinience_for_health| buy_store_brands| eat_organic| no_junk_food_in_home| diff_types_of_food| new_recipes| fam_says_am_good_cook| change_stores_to_eat_healthier| change_stores_to_save_money| advance_meal_plans|brands_to_reflext_my_style| brands_to_support_social_causes| follow_trends_fashion| brands_I_grew_up_with| price_shopper| quality_based_shopping__not__| recommend_food_I_like_to_others| shopping_to_relax| wanting_to_impress_others| prioritize_time_w__fam| variety_in_everyday_life| same_life_week_to_week| looking_for_a_thrill| consider_myself_sophisticated| taste_over_health|Glten_free_| Dairy_free| Nut_free| Diabetic| Plant_based_diet| Vegan| Vegetarian| Low_sodium| Low_carb| Low_calorie| Non_GMO| Antibiotic_free| Hormone_free| Allergen_free| Locally_sourced| _of_household_members| Marriage_status| __of_children| Education| Race| employement| weight__lb_| Height__Inches_@1    
/selection=stepwise(select=cv) hierarchy=single cvmethod=random(10) showpvalues;
 modelaverage nsamples=100 tables=(ParmEst(all));
 performance buildsscp=incremental;
 score data=data_test out=test_performance residual=res;
 score data=data_train out=insample_performance residual=res;
run;

data test_performance; 
 set test_performance; 
 sq_res = res*res;
run;

proc means data=test_performance mean; 
 var sq_res;
run;

data insample_performance; 
 set insample_performance; 
 sq_res = res*res;
run;

proc means data=insample_performance mean; 
 var sq_res;
run;
