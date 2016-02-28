-module (mini_calendar).

-export ([new/0]).
-export ([new/1]).
-export ([next_open_day/2]).

new () -> [].

new (BankHolliDays) when is_list (BankHolliDays) -> 
    BankHolliDays.

tommorow (Day) ->
    G = calendar: date_to_gregorian_days (Day),
    T = G + 1,
    calendar: gregorian_days_to_date (T).


next_open_day (Date, Cal) ->
    T = tommorow (Date),
    over_holliday (over_week_end (T, Cal, is_weekend (T)), Cal).

over_week_end (Date, Cal, true) ->
    next_open_day (Date, Cal);
over_week_end (Date, _, false) ->
    Date.

over_holliday (Date, Cal) ->
    case lists: member (Date, Cal) of
        true ->
            next_open_day (Date, Cal);
        _ -> Date
    end.

is_weekend (Date) ->
    weekend (calendar: day_of_the_week (Date)).

weekend (6) -> true;
weekend (7) -> true;
weekend (_) -> false.
