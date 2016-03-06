-module(wordcount_soluce_test).

-include_lib ("eunit/include/eunit.hrl").

wordcount_test () ->
    ?assertEqual ({ok, 1}, dict: find ("Hello", wordcount_soluce: wordcount(["Hello World","toto tutu"]))),
    ?assertEqual ({ok, 2}, dict: find ("Hello", wordcount_soluce: wordcount(["Hello World Hello", "toto tutu"]))),
    ?assertEqual ({ok, 2}, dict: find ("Hello", wordcount_soluce: wordcount(["Hello World","Hello tutu"]))).
