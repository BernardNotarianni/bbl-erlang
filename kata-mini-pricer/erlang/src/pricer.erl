-module (pricer).

-export ([new/0]).
-export ([new/1]).


new () ->
    Random = fun () -> (random: uniform () * 3) - 2 end,
    fun (D,I,V) ->
            price (D,I,V, Random)
    end.

new (RandomGenerator) ->
    fun (D,I,V) ->
            price (D,I,V, RandomGenerator)
    end.


price ({Start,End}, InitialPrice, Volatility, Gen) ->
    price ({Start,End,[]}, InitialPrice, Volatility,Gen);

price ({Today,Today,_}, InitialPrice, _,_) ->
    InitialPrice;
price ({Today,PriceDate,Hollidays}, InitialPrice, Volatility, Gen) ->
    Cal = mini_calendar: new (Hollidays),
    NextOpenDay = mini_calendar: next_open_day (Today, Cal),
    price ({NextOpenDay, PriceDate, Hollidays}, InitialPrice, Volatility, Gen)
        * (1 + Gen() * Volatility/100.0).
