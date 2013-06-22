(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
(* task a *)
(* helper function returns true if string is in list *)
fun is_in_list pair =
    case pair of
         (_,[]) => false
       | (s,x::xs) => if same_string(s,x) then true else is_in_list(s,xs)

(* helper function that removes the option from the list *)
fun remove_from_list pair =
    case pair of
         (_,[]) => []
       | (opt,x::xs) => if same_string(opt,x) then remove_from_list(opt,xs) else
           x::remove_from_list(opt,xs)

(* this function calls a function to check if the option is in the list, if it
* is it removes it. I know that it is going to be nothing at all like the
* solution that will be suggested, but it works so I ain't altering it. Mostly
* due to this helper function not really helping at all, returning the option
* makes the next function harder to write! *) 
fun all_except_option (s : string, s_list : string list) =
    case s_list of
         [] => NONE
       | _ => if is_in_list(s,s_list) then SOME (remove_from_list(s,s_list)) else NONE
    
(* this should return a list containing all variations of a name *)
fun get_substitutions1 um =
    case um of
         ([],_) => []
       | (y::ys,opt) =>
           case all_except_option(opt,y) of
                (NONE) => [] @ get_substitutions1(ys,opt) (* if
                all_except_option returns none then append the recursive call to
                an empty list. *)
              | (SOME( ums )) => ums @ get_substitutions1(ys,opt) (* otherwise
              there was something so append the recursive call to the something
              we got *)

(* same as the above, but hopefully tail recursive *)
fun get_substitutions2 um =
    let fun f (opt,xs,acc) =
        case xs of
             [] => acc
           | i::xs' => 
               case all_except_option(opt,i) of
                    (NONE) => f(opt,xs',acc)
                  | (SOME( ums )) => f(opt,xs',acc @ ums)
    in
        case um of
             ([],_) => []
           | (ys,opt) => f(opt,ys,[])
    end

(* takes a list of names and a record containg first, last and middle name and
* returns a list of records where the first name is switch by the list of
* alternate names passed in *)
fun similar_names (xs,{first=fname,last=lname,middle=mname}) =
    let fun f (names,acc) = (* this helper function does most of the work *)
        case names of
             [] => acc
           | y::ys' => f(ys',acc @ [{first=y,last=lname,middle=mname}])
    in
      (* make sure that the original record is the first in the list *)
        f(get_substitutions2(xs,fname),[{first=fname,last=lname,middle=mname}])
    end

(* you may assume that Num is always used with values 2, 3, ..., 9
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
(* return the color of the card, we only need to test two of the suits the other
* two will be the other color *)
fun card_color my_card =
    case my_card of
         (Clubs,_) => Black
       | (Spades,_) => Black
       | (_,_) => Red

(* return the value of the card, Ace 11, number cards are the number they
* represent, the face cards are 10 *)
fun card_value my_card =
    case my_card of
         (_,Ace) => 11
       | (_,Num i) => i
       | (_,_) => 10

(* remove the card from the given list of cards, if that card doesn't exist then
  * raise the passed in exception *)
fun remove_card (cs : card list,c : card,e : exn) =
    case cs of
         [] => raise e
       | y::ys => if c = y then ys else y::remove_card(ys,c,e)

(* returns true if all the cards in the list are the same colour (I'm british,
* please don't mark me down for that ;)) *)
fun all_same_color card_list =
    case card_list of
         [] => true
        | _::[] => true
        | head::(neck::rest) => (card_color(head) = card_color(neck) andalso all_same_color (neck::rest))

(* add up the values of all the cards in the list *)
fun sum_cards card_list =
    let fun f (cards,acc) =
        case cards of
              [] => acc
            | i::cards' => f(cards',card_value(i) + acc)
    in
      f(card_list,0)
    end

(* some crazy scoring rules that I didn't really understand *)
fun score (cards : card list,goal : int) =
    let val num = sum_cards(cards)
    in
        let val prelim =
            if num > goal 
            then 3 * (num - goal) (* if the number is greater than the goal then
              the preliminary score is 3 times the difference *)
            else goal - num (* otherwise it is just the difference *)
        in
          (* if all the cards are the same colour then we integer divide the
          * preliminary score *)
            if all_same_color(cards) then prelim div 2 else prelim
        end
    end
        
(* takes a list of cards, a list of moves and a goal. *)
fun officiate (cards,moves,goal) =
    let fun play(cards,moves,hand) =
        case moves of
             [] => hand (* if we run out of moves the go is over *)
           | this_move::rest =>
               case this_move of
                    Discard(card) => (* if the move is to discard a card, then
                      remove it from the hand, raise an exception if it doesn't
                      exist *)
                        play(cards,rest,remove_card(hand,card,IllegalMove))
                  | Draw => (* otherwise take a card from the list of cards *)
                        case cards of
                        (* if there are no more cards then the go is over *)
                             [] => hand 
                        (* if the card that we've drawn goes over the goal
                         * then add the card to the hand and end the go *)
                           | c::cs => if sum_cards(c::hand) > goal then c::hand
                           (* otherwise add the card to the hand and carry on
                           * going *)
                                      else play(cs,rest,c::hand)
    in
      (* return the score of the hand *)
        score(play(cards,moves,[]),goal)
    end
