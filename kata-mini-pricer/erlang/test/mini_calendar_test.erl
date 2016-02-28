-module (mini_calendar_test).

-include_lib ("eunit/include/eunit.hrl").

next_day_test () ->
    Cal = mini_calendar: new (),
    ?assertEqual (wednesday(), mini_calendar: next_open_day (tuesday(), Cal)).

next_day_over_weekend_test () ->
    Cal = mini_calendar: new (),
    ?assertEqual (monday(), mini_calendar: next_open_day (friday(), Cal)).

next_day_over_bank_holliday_test () ->
    Cal = mini_calendar: new ([wednesday()]),
    ?assertEqual (thursday(), mini_calendar: next_open_day (tuesday(), Cal)).

tuesday()   -> {2015,4,7}.
wednesday() -> {2015,4,8}.
thursday()  -> {2015,4,9}.
friday()    -> {2015,4,10}.
monday()    -> {2015,4,13}.
