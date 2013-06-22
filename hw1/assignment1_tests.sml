(* test file for assingment1 *)
use "assignment1.sml";
(* is_older function tests *)
is_older((2012,1,12),(2013,1,12));  (* older year *)
is_older((2013,1,12),(2013,2,12));  (* older month *)
is_older((2013,1,12),(2013,1,17));  (* older day *)
is_older((2013,1,12),(2013,1,12)) = false; (* same day *)
is_older((2013,1,12),(2012,1,12)) = false; (* younger year *)
is_older((2013,2,12),(2013,1,12)) = false; (* younger month *)
is_older((2013,1,12),(2013,1,11)) = false; (* younger day *)

(* number_in_month function tests *)
val dates = [(2012,1,12),(2012,2,12),(2012,3,12),(2012,1,11),(2012,1,10)];
number_in_month(dates,1) = 3; (* 3 january's *)
number_in_month(dates,3) = 1; (* 1 march's *)
number_in_month(dates,11) = 0; (* none in november *)

(* number in months function tests *)
number_in_months(dates,[1,3,11]) = 4; (* 4 dates for this month *)
number_in_months(dates,[1,3,1]) = 7; (* counts january twice - EXPECTED *)
number_in_months(dates,[]) = 0; (* returns 0 for empty list *)

(* dates_in_month function tests *)
dates_in_month(dates,1) = [(2012,1,12),(2012,1,11),(2012,1,10)]; (* 3 january's *)
dates_in_month(dates,3) = [(2012,3,12)]; (* 1 march's *)
dates_in_month(dates,11) = []; (* none in november thus empty list *)

(* dates_in_months *)
dates_in_months(dates,[1,3,11]) = [(2012,1,12),(2012,1,11),(2012,1,10),(2012,3,12)]; 
dates_in_months(dates,[11]) = [];

val my_strings = ["this","that","and","the","other"];
(* get_nth *)
get_nth(my_strings,1) = "this";
get_nth(my_strings,4) = "the";

(* date_to_string *)
date_to_string((2013,1,20)) = "January 20, 2013";
date_to_string((2013,3,4)) = "March 4, 2013";

(* number_before_reaching_sum *)
val my_ints = [1,2,3,4,5,6,7,8,9];
number_before_reaching_sum(10,my_ints) = 3;
number_before_reaching_sum(11,my_ints) = 4;

(* what_month *)
what_month(30) = 1;
what_month(32) = 2;
what_month(364) = 12;

(* month_range *)
month_range(30,33) = [1,1,2,2];
month_range(33,30) = [];

(* oldest *)
(* valOf oldest(dates) = (2012,1,10); *)
val return = oldest(dates);
isSome return andalso valOf return = (2012,1,10);
val return2 = oldest([]);
isSome return2 = false;

(* remove *)
remove(5,my_ints) = [1,2,3,4,6,7,8,9];

(* dedup *)
val my_list = [1,2,3,1,2,3,4];
dedup(my_list) = [1,2,3,4];

(* number in months challenge function tests *)
number_in_months_challenge(dates,[1,3,11]) = 4; (* 4 dates for this month *)
number_in_months_challenge(dates,[1,3,1]) = 4; (* counts january once - EXPECTED *)
number_in_months_challenge(dates,[]) = 0; (* returns 0 for empty list *)


(* dates_in_months_challenge *)
dates_in_months_challenge(dates,[1,3,11]) = [(2012,1,12),(2012,1,11),(2012,1,10),(2012,3,12)]; 
dates_in_months_challenge(dates,[1,3,11,1]) = [(2012,1,12),(2012,1,11),(2012,1,10),(2012,3,12)]; 
dates_in_months_challenge(dates,[11]) = [];

(* is_leap *)
is_leap(2020);
is_leap(1972);
is_leap(1974) = false;

(* get_nth_int *)
get_nth_int(my_list,3) = 3;

(* check_day_in_month *)
check_day_in_month(3,31);
check_day_in_month(4,31) = false;

(* reasonable_date *)
reasonable_date((1972,2,29));
reasonable_date((1973,2,29)) = false;
reasonable_date((1973,12,31));
reasonable_date((0,1,2)) = false;
reasonable_date((1998,0,1)) = false;
reasonable_date((1999,1,0)) = false;
