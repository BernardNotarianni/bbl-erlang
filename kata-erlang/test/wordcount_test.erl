-module(wordcount_test).

-include_lib ("eunit/include/eunit.hrl").

wordcount_test () ->
    ?assertEqual ("hello bbl", wordcount: text ("hello bbl")).
