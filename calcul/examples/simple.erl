-module (simple).
-export ([fib/1]).
-export ([double/1]).


double (N) ->
    N * 2.


fib (0) ->
    0;
fib (1) ->
    1;
fib (N) ->
    fib (N-1) + fib (N-2).
