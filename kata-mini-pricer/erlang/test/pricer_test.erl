-module (pricer_test).

-include_lib ("eunit/include/eunit.hrl").

pricer () ->
    AlwaysUp = fun () -> 1 end,
    pricer: new (AlwaysUp).

price_over_one_day_test () ->
    OneDay = {tuesday(), wednesday()},
    Pricer = pricer (),
    ?assertEqual (110.0, r(Pricer (OneDay, 100, 10))).

price_over_3_days_test () ->
    ThreeDays = {tuesday(), friday()},
    Pricer = pricer (),
    ?assertEqual (133.1, r(Pricer (ThreeDays, 100, 10))).

price_over_weekend_test () ->
    OverWeekend = {friday(), monday()},
    Pricer = pricer (),
    ?assertEqual (110.0, r(Pricer (OverWeekend, 100, 10))).

price_over_hollidays_test () ->
    ThreeDaysWithHolliday = {tuesday(), friday(), [wednesday()]},
    Pricer = pricer (),
    ?assertEqual (121.0, r(Pricer (ThreeDaysWithHolliday, 100, 10))).

price_with_random_generator_test () ->
    ThreeDays = {tuesday(), friday()},
    GoingDown = fun () -> -1 end,
    Pricer = pricer: new (GoingDown),
    ?assertEqual (72.9, r(Pricer (ThreeDays, 100, 10))).

tuesday()   -> {2015,4,7}.
wednesday() -> {2015,4,8}.
friday()    -> {2015,4,10}.
monday()    -> {2015,4,13}.


r (X) ->
    floor (X * 10000) / 10000.

floor (X) when X < 0 ->
    T = trunc (X),
    case X - T == 0 of
        true -> T;
        false -> T - 1
    end;
floor (X) ->
    trunc (X).
