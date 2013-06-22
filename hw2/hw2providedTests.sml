(* Dan Grossman, Coursera PL, HW2 Provided Tests *)

use "hw2provided.sml";

(* Tests for problem 1 *)
(* removes string from the start of the list *)
val test1 = valOf (all_except_option("Sue",["Jill","Sue","Chow"])) = ["Jill","Chow"];
val test2 = isSome(all_except_option("Sue",["Jill","Chow"])) = false;
val test3 = isSome(all_except_option("Sue",[])) = false;
val test4 =
  get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred")
  = ["Fredrick","Freddie","F"];
val test5 =
  get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")
  = ["Jeffrey","Geoff","Jeffrey"];
val test4 =
  get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred")
  = ["Fredrick","Freddie","F"];
val test5 =
  get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")
  = ["Jeffrey","Geoff","Jeffrey"];
val test6 =
  similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
  {first="Fred", middle="W", last="Smith"}) 
  = [{first="Fred", last="Smith", middle="W"},
  {first="Fredrick", last="Smith", middle="W"},
  {first="Freddie", last="Smith", middle="W"},
  {first="F", last="Smith", middle="W"}];


  

(* These are just two tests for problem 2; you will want more.

   Naturally these tests and your tests will use bindings defined 
   in your solution, in particular the officiate function, 
   so they will not type-check if officiate is not defined.
 *)

fun provided_test1 () = (* correct behavior: raise IllegalMove *)
    let val cards = [(Clubs,Jack),(Spades,Num(8))]
	val moves = [Draw,Discard(Hearts,Jack)]
    in
	officiate(cards,moves,42)
    end

fun provided_test2 () = (* correct behavior: return 3 *)
    let val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
	val moves = [Draw,Draw,Draw,Draw,Draw]
    in
 	officiate(cards,moves,42)
    end

val test7 = card_color(Spades,Ace) = Black;
val test8 = card_color(Hearts,Queen) = Red;
val test9 = card_value(Spades,Ace) = 11;
val test10 = card_value(Hearts,Queen) = 10;
val test11 = card_value(Clubs,Num(2)) = 2;
val test12 =
  remove_card([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],(Spades,Ace),IllegalMove)
  = [(Clubs,Ace),(Clubs,Ace),(Spades,Ace)];
val test13 = (remove_card([], (Clubs, Jack), IllegalMove); false) handle IllegalMove => true;
val test14 = all_same_color([(Hearts,Queen),(Diamonds,Num(2)),(Hearts,Ace)]);
val test15 = all_same_color([(Hearts,Queen),(Diamonds,Num(2)),(Clubs,Ace)]) =
  false;
val test16 = sum_cards([(Hearts,Queen),(Diamonds,Num(2)),(Clubs,Ace)]) = 23;
val test17 = score([(Hearts,Queen),(Diamonds,Num(2)),(Clubs,Ace)],22) = 3;
val test18 = score([(Hearts,Queen),(Diamonds,Num(2)),(Clubs,Ace)],24) = 1;
val test19 = score([(Hearts,Queen),(Diamonds,Num(2)),(Clubs,Ace)],23) = 0;
val test20 = score([(Hearts,Queen),(Diamonds,Num(2)),(Hearts,Ace)],22) = 1;
val test21 = (provided_test1(); false) handle IllegalMove => true;
val test22 = provided_test2() = 3;
