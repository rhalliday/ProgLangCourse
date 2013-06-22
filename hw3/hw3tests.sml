use "hw3.sml";

(* going to write some helper functions for my tests *)

fun ok (test,result,message) =
  if result
  then Int.toString(test) ^ " - ok - " ^ message
  else Int.toString(test) ^ " - not ok - " ^ message

fun not_ok (test,result,message) = ok(test, not result, message)

fun is (test,result,expected,message) = ok(test,result = expected,message)

fun isnt (test,result,expected,message) = not_ok(test,result = expected,message)

(* run the tests *)
val result =
  is(1,only_capitals(["hi","Hello","howdy","You"]),["Hello","You"],
  "only_capitals returns a list containing the strings that start with a capital");
val result =
  is(2,only_capitals(["hi","hello","howdy","you"]),[],
  "only_capitals returns empty list when no capital string");
val result = is(3, longest_string1(["hi","hello","morning","yo"]),"morning",
  "longest_string1 returns morning when this is the longest");
val result = is(3, longest_string1(["hi","hello","howdy","yo"]), "hello",
  "longest_string1 returns hello when howdy is the same length");
val result = is(4, longest_string1([]), "",
  "longest_string1 returns empty string when given empty list");
val result = is(5, longest_string2(["hi","hello","howdy","yo"]), "howdy",
  "longest_string2 returns howdy when hello is the same length");
val result = is(6, longest_string2(["hi","hello","hiya!","howdy","yo"]), "howdy",
  "longest_string2 returns howdy when hello & hiya! same length");
val result = is(7, longest_string3(["hi","hello","morning","yo"]),"morning",
  "longest_string3 returns morning when this is the longest");
val result = is(8, longest_string3(["hi","hello","howdy","yo"]), "hello",
  "longest_string3 returns hello when howdy is the same length");
val result = is(9, longest_string3([]), "",
  "longest_string3 returns empty string when given empty list");
val result = is(10, longest_string4(["hi","hello","howdy","yo"]), "howdy",
  "longest_string4 returns howdy when hello is the same length");
val result = is(11, longest_string4(["hi","hello","hiya!","howdy","yo"]), "howdy",
  "longest_string4 returns howdy when hello & hiya! same length");
val result = is(12, longest_capitalized(["hi","hello","hiya!","howdy","yo"]), "",
  "longest_capitalized returns empty string if there are none");
val result = is(13, longest_capitalized([]), "",
  "longest_capitalized empty list returns empty string");
val result = is(14, longest_capitalized(
  ["this is a long string","This is a long string","This is a long strung","hmm"]), 
  "This is a long string",
  "longest_capitalized returns the right cap string");
val result = is(15,rev_string "Hello World!","!dlroW olleH",
  "rev_string reverses the string");
val result = is(16,count_wildcards Wildcard,1,"count_wildcards returns 1");
val var = Variable("hello");
val result = isnt(17,count_wildcards var,1,"count_wildcards: 0: Variable hello");
val multi = TupleP([Wildcard, ConstructorP("a",Wildcard), Variable("z"), Wildcard])
val result = is(18,count_wildcards multi,3,"count wildcards TupleP is 3");
val result = is(19,count_wild_and_variable_lengths Wildcard,1,"wild & var = 1");
val result = is(20,count_wild_and_variable_lengths var,5, "wild & var =5");
val result = is(21,count_wild_and_variable_lengths multi,4,"wild & var is 4");
val result = is(22,count_some_var("z",multi),1,"some var z is 1");
val result = is(23,count_some_var("hello",var),1,"some var hello is 1");
val multi_var =
  TupleP([Variable("hello"),ConstructorP("hello",Wildcard),Variable("z"),Variable("hello")]);
val multi_val = Tuple([Const(1),Constructor("hello",Const(1)),Const(2),Unit]);
val result = is(24,count_some_var("hello",multi_var),2,"some var multi 2");
val result = is(25,get_var_list var,["hello"],"get var list give single element list");
val result = is(26,get_var_list multi,["z"],"get var list multi gives z");
val result = is(27,get_var_list multi_var,
  ["hello","z","hello"], "get var list multi gives 3 element list");
val result = ok(28,has_no_dupes([]),"has no dupes empty list returns true");
val result = ok(29,has_no_dupes(["hello"]),"has no dupes single element is true");
val result = ok(30,has_no_dupes(["hello","howdy"]),"has no dupes 2 element is true");
val result = not_ok(31,has_no_dupes(["hello","howdy","hello"]),
  "has no dupes is false when there are dupes");
val result = ok(32,check_pat var,"check pat var is true");
val result = ok(33,check_pat multi,"check pat multi is true");
val result = not_ok(34,check_pat multi_var,"check pat multi_var is false");
val multi_var2 = TupleP([Variable("hello"),Variable("hi"),Variable("ho")]);
val result = ok(35,check_pat multi_var2,"check pat multi_var2 is true");
val result = is(36,valOf(match(Const(1),Wildcard)),[],
  "match returns empty array for wildcard");
val result = is(37,valOf(match(Const(1),Variable("s"))),[("s",Const(1))],
  "match returns s,1 for variable");
val result = is(38,valOf(match(Unit,UnitP)),[],
  "match unit returns empty list");
val result =
  is(39,valOf(match(multi_val,multi_var)),[("hello",Unit),("z",Const(2)),("hello",Const(1))],
  "match tuple returns expected list");
val result =
  is(40,valOf(match(Constructor("hello",Const(1)),ConstructorP("hello",Variable("z")))),
  [("z",Const(1))],"match constructor z, 1");
val result = is(41,valOf(match(Const(1),ConstP(1))),[],
  "match Const returns empty list");
val result = not_ok(42,isSome(match(Const(1),ConstP(2))),"diff const don't match");
val result =
  not_ok(43,isSome(match(Constructor("hello",Const(1)),ConstructorP("hi",Variable("z")))),
  "constructor with diff strings don't match");
val result = not_ok(44,isSome(match(Const(1),UnitP)),"const & unitP is none");
val pat_list = [UnitP,ConstP(1),ConstP(2),ConstP(3)];
val const = Const(2);
val result =
  is(45,valOf(first_match const pat_list),[],
  "first_match is empty list with const");
val pat_list2 = [UnitP,ConstP(1),ConstP(3)];
val result =
  not_ok(46,isSome(first_match const pat_list2),
  "first_match returns none for no match");
