-module (index_handler).

-export ([init/3]).
-export ([handle/2]).
-export ([terminate/3]).

init ({tcp, http}, Req, []) ->
    {ok, Req, undefined_state}.

handle (Req, State) ->
    Headers = [{<<"content-type">>, <<"text/html">>}],
    {ok, Body} = index_dtl: render([]),
    {ok, Req2} = cowboy_req: reply(200, Headers, Body, Req),
    {ok, Req2, State}.

terminate (_Reason, _Req, _State) ->
    ok.
