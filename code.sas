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
proc glmselect data=data testdata=data_test seed = 2  plots=all;
class Sex(split); 
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila/selection=lasso(choose=cv stop=none) hierarchy=single cvmethod=random(10) showpvalues;
 performance buildsscp=incremental;
run;
proc glmselect data=data_train testdata=data_test seed = 2  plots=none;
 class Sex(split)  snacking_in_last_24_hrs_(split) Glten_free_(split) Dairy_free(split) Nut_free(split) Diabetic(split) Plant_based_diet(split) Vegan(split) Vegetarian(split) Low_sodium(split) Low_carb(split) Low_calorie(split) Non_GMO(split) Antibiotic_free(split) Hormone_free(split) Allergen_free(split) Locally_sourced(split) Marriage_status(split) Education(split) Race(split) employement(split);
model POINTS = Sex|Age|Domestic_beer|Imported_Beer|Craft_Beer|Sparkling_Wine|Red_Wine|White_Wine|Scotch|Gin|Bourbon|Vodka|Rum|Tequila|alcohol_consumption|snacking_in_last_24_hrs_|Kroger_Safeway| Target| Walmart| wholefoods_trader_joes| sams_costco| dollar_store| cooking_score| No_sale_no_shop| induldge_in_food| natural_food| nat_food_better_for_me___envr| reward_w__sth_tasty| balance_healthy___unhealthy_food|give_up_convinience_for_health| buy_store_brands| eat_organic| no_junk_food_in_home| diff_types_of_food| new_recipes| fam_says_am_good_cook| change_stores_to_eat_healthier| change_stores_to_save_money| advance_meal_plans|brands_to_reflext_my_style| brands_to_support_social_causes| follow_trends_fashion| brands_I_grew_up_with| price_shopper| quality_based_shopping__not__| recommend_food_I_like_to_others| shopping_to_relax| wanting_to_impress_others| prioritize_time_w__fam| variety_in_everyday_life| same_life_week_to_week| looking_for_a_thrill| consider_myself_sophisticated| taste_over_health|Glten_free_| Dairy_free| Nut_free| Diabetic| Plant_based_diet| Vegan| Vegetarian| Low_sodium| Low_carb| Low_calorie| Non_GMO| Antibiotic_free| Hormone_free| Allergen_free| Locally_sourced| _of_household_members| Marriage_status| __of_children| Education| Race| employement| weight__lb_| Height__Inches_@1    
  /selection=forward(select=cv) hierarchy=single cvmethod=random(10)showpvalues ;
 performance buildsscp=incremental;
run;
