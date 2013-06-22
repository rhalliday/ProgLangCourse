(* use "hw3provided.sml"; *)

(* going to write some helper functions for my tests *)

fun ok (test,result,message) =
  if result
  then Int.toString(test) ^ " - ok - " ^ message
  else Int.toString(test) ^ " - not ok - " ^ message

fun not_ok (test,result,message) = ok(test, not result, message)

fun is (test,result,expected,message) = ok(test,result = expected,message)

fun isnt (test,result,expected,message) = not_ok(test,result = expected,message)

(* test the tests *)
val tnum = 1;
val result = ok(tnum,true,"test ok with true returns ok");
val tnum = tnum + 1;
val result = ok(tnum,false,"test ok with false returns not ok");
val tnum = tnum +1;
val result = not_ok(tnum,true,"test not_ok with true returns not ok");
val tnum = tnum + 1;
val result = not_ok(tnum,false,"test not_ok with false returns ok");
val tnum = tnum + 1;
val result = is(tnum,2,2,"test is with 2 & 2 returns ok");
val tnum = tnum + 1;
val result = is(tnum,1,3,"test is with 1 & 3 returns not ok");
val tnum = tnum + 1;
val result = is(tnum,[1,2,3],[1,2,3],"test is with two identical lists returns ok");
val tnum = tnum + 1;
val result = is(tnum,[3,2,1],[1,2,3],"test is with two different lists returns not ok");
val result = isnt(tnum,2,2,"test isnt with 2 & 2 returns not ok");
val tnum = tnum + 1;
val result = isnt(tnum,1,3,"test isnt with 1 & 3 returns ok");
val tnum = tnum + 1;
val result = isnt(tnum,[1,2,3],[1,2,3],"test isnt with two identical lists returns not ok");
val tnum = tnum + 1;
val result = isnt(tnum,[3,2,1],[1,2,3],"test isnt with two different lists returns ok");

