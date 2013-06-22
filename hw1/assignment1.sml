(* Takes two dates of int*int*int returns true if the first
* date comes before the second *)
fun is_older (d1 : (int*int*int), d2 : (int*int*int)) =
  (* if the year is the same, check the month *)
  if (#1 d1) = (#1 d2)
  (* if the month is the same check the day *)
  then if (#2 d1) = (#2 d2)
    then (#3 d1) < (#3 d2)
    else (#2 d1) < (#2 d2)
  else (#1 d1) < (#1 d2)

(* return the number of dates that have the passed in month *)
fun number_in_month (dates : (int*int*int) list, month : int) =
  if null dates
  then 0
  else 
    if (#2 (hd dates)) = month
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)

(* return a list of number of dates that have the passed in months *)
fun number_in_months(dates : (int*int*int) list, months : int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* return a list of dates in the passed in months *)
fun dates_in_month(dates : (int*int*int) list, month : int) =
  if null dates
  then []
  else
    if (#2 (hd dates)) = month
    then hd dates::dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

(* return a list of dates that have a month in the list of months *)
fun dates_in_months(dates : (int*int*int) list, months : int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* return the nth string in a list *)
fun get_nth(strings : string list, x : int) =
  if x = 1
  then hd strings
  else get_nth(tl strings,x-1)

(* takes a date and returns a string of the form January 20, 2013 *)
fun date_to_string(date : (int*int*int)) =
  get_nth(["January","February","March","April","May","June","July","August","September","October","November","December"],(#2
  date)) ^ " " ^ Int.toString((#3 date)) ^ ", " ^ Int.toString((#1 date))

fun number_before_reaching_sum(sum : int, pos_nums : int list) =
  let
    fun sum_it (nums : int list, total : int, count : int) =
      if total + hd nums >= sum
      then count
      else sum_it(tl nums,total+(hd nums),count+1)
  in
    sum_it(pos_nums,0,0)
  end

fun what_month(day : int) =
  number_before_reaching_sum(day, [0,31,28,31,30,31,30,31,31,30,31,30,31])

fun month_range(day1 : int, day2 : int) =
  if day1 > day2
  then []
  else
    let
      fun get_month (day : int) =
        if day = day2
        then what_month(day)::[]
        else what_month(day) :: get_month(day+1)
    in
      get_month(day1)
    end

fun oldest(dates : (int*int*int) list) =
  if null dates
  then NONE
  else 
    let val tl_ans = oldest(tl dates)
    in 
      if isSome tl_ans andalso is_older( valOf tl_ans, hd dates )
      then tl_ans
      else SOME (hd dates)
    end

(* remove an element from the list *)
fun remove(x : int, xl : int list) =
  if null xl
  then []
  else 
    if hd xl = x
    then
      remove(x, tl xl)
    else
      hd xl :: remove(x, tl xl)

(* remove duplicates from a list *)
fun dedup(this_list : int list) =
  if null this_list
  then []
  else hd this_list :: remove(hd this_list,dedup(tl this_list))

fun number_in_months_challenge(dates : (int*int*int) list, months : int list) =
  number_in_months(dates,dedup(months))

fun dates_in_months_challenge(dates : (int*int*int) list, months : int list) =
  dates_in_months(dates,dedup(months))

fun is_leap(year : int) =
  year mod 400 = 0 orelse (year mod 4 = 0 andalso year mod 100 > 0)

(* return the nth int in a list *)
fun get_nth_int(ints : int list, x : int) =
  if x = 1
  then hd ints
  else get_nth_int(tl ints,x-1)

fun check_day_in_month(month : int, day : int) =
  day > 0 andalso day <= get_nth_int([31,28,31,30,31,30,31,31,30,31,30,31],month)

fun reasonable_date(date : (int*int*int)) =
  (* check that the year is not 0 *)
  if (#1 date) > 0
  then
    (* check the month *)
    if (#2 date) > 0 andalso (#2 date) < 13
    then
      if (#2 date) = 2
      then
        if is_leap(#1 date)
        then
          (#3 date) > 0 andalso (#3 date) < 30
        else
          check_day_in_month(#2 date, #3 date)
      else
        check_day_in_month(#2 date, #3 date)
    else
      false
  else
    false

 
