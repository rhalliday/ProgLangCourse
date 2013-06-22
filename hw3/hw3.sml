(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* when passed a list of strings should return a list where only the elements 
* that are title cased are returned *)
fun only_capitals xs = List.filter (fn y => Char.isUpper(String.sub(y,0))) xs

(* when passed a list of strings returns the longes string. if there are two
* strings with the same lenght it returns the left most *)
fun longest_string1 xs = 
  List.foldl (fn (x,y) => if String.size x > String.size y then x else y) "" xs

(* when passed a list of strings returns the longes string. If there are two
* string with the same length it returns the left most *)
fun longest_string2 xs = 
  List.foldl (fn (x,y) => if String.size x < String.size y then y else x) "" xs

(* helper function that uses currying to help implement the two above functions
* *)
val longest_string_helper = fn x => fn xs => 
  List.foldl 
    (fn (p,q) => if x(String.size(p),String.size(q)) then p else q ) 
    "" 
    xs

(* same as longest_string1 but with currying and partial application *)
val longest_string3 = longest_string_helper (fn(x,y) => x > y)

(* same as longest_string2 but with currying and partial application *)
val longest_string4 = longest_string_helper (fn(x,y) => x >= y)

(* longest_capitalized that takes a string list and returns the longest string
* in the list that begins with an uppercase letter *)
val longest_capitalized = longest_string3 o only_capitals

(*rev_string that takes a string and returns the string that is the same
* characters in reverse order *)
val rev_string = String.implode o List.rev o String.explode

(* first_answer of type (’a -> ’b option) -> ’a list -> ’b. The first argument
* should be applied to elements of the second argument in order until the first 
* time it returns SOME v for some v and then v is the result of the call to 
* first_answer. If the first argument returns NONE for all list elements, then
* first_answer should raise the exception NoAnswer *)
val first_answer = fn f => fn xs =>
   let fun f2 ys =
    case ys of
       [] => raise NoAnswer
     | y::ys' => case f(y) of
                    NONE => f2(ys')
                  | SOME(z) => z
   in
     f2(xs)
   end

(* (’a -> ’b list option) -> ’a list -> ’b list option *)
(* The first argument should be applied to elements of the second
* argument. If it returns NONE for any element, then the result for all_answers
* is NONE. Else the calls to the first argument will have produced SOME lst1, 
* SOME lst2, ... SOME lstn and the result of all_answers is SOME lst where lst 
* is lst1, lst2, ..., lstn appended together (order doesn’t matter). *)
val all_answers = fn f => fn xs =>
   let fun f2 (ys,acc) =
     case ys of
          [] => acc
        | y::ys' => case f y of
                         NONE => []
                       | SOME(x) => f2(ys',x @ acc)
   in
     case f2(xs,[]) of
          [] => NONE
        | ys => SOME(ys)
   end

(*count_wildcards that takes a pattern and returns how many Wildcard
* patterns it contains *) 
val count_wildcards = g (fn () => 1) (fn x => 0)

(* count the number of wildcard and add the sum of the variables *)
val count_wild_and_variable_lengths = g (fn () => 1) (fn x => String.size(x))

(* count the number of variables with x in the pattern *)
fun count_some_var (x, pat) =
    g (fn () => 0) (fn y => if y = x then 1 else 0) pat 

(* takes a pattern and returns a string list of all variables in that pattern *)
fun get_var_list p =
	case p of
	    Wildcard          => []
	  | Variable x        => [x]
	  | TupleP ps         => List.foldl (fn (p,i) => i @ get_var_list(p)) [] ps
	  | ConstructorP(_,p) => get_var_list p
	  | _                 => []

(* takes a list of strings and returns false if there are duplicates *)
fun has_no_dupes xs =
    case xs of
         [] => true
       | y::ys' => if List.exists (fn exists => y = exists) ys' then false else has_no_dupes(ys')

(* takes a pattern and checks that all the variables are unique *)
val check_pat = has_no_dupes o get_var_list

(* match takes a valu and a pattern and returns a (string * valu) list
* option *)
fun match x = 
    case (x) of
        (_,Wildcard)           => SOME []
      | (v,Variable x)         => SOME [(x,v)]
      | (Unit, UnitP)          => SOME []
      | (Const c,ConstP y)     => if y = c then SOME [] else NONE
      | (Tuple vs, TupleP ps)  => all_answers (match) (ListPair.zip(vs,ps))
      | (Constructor(s,v),ConstructorP(s2,p)) => if s2 = s then (match (v, p)) else NONE
      | (_,_)                  => NONE

(* takes a valu and a list of patterns and returns a list option *)
fun first_match v ps =
  SOME (first_answer (fn x => match(v,x)) (ps)) 
  handle NoAnswer => NONE
