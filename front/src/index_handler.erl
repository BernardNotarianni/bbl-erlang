-module (index_handler).

-export ([init/3]).
-export ([handle /2]).
-export ([terminate/3]).

init ({tcp, http}, Req, []) ->
    {ok, Req, undefined_state}.

handle (Req, State) ->
    {Method, Req2} = cowboy_req:method(Req),
    HasBody = cowboy_req:has_body(Req2),
    {ok, Req3} = handle (Method, HasBody, Req2),
    {ok, Req3, State}.


handle (<<"POST">>, true, Req) ->
    {ok, PostVals, Req2} = cowboy_req:body_qs(Req),
    BinN = proplists: get_value(<<"n">>, PostVals),
    BinM = proplists: get_value(<<"m">>, PostVals),
    N = binary_to_integer (BinN),
    M = binary_to_integer (BinM),
    {ok, Server} = application: get_env (front, calcul_master),
    gen_server: call ({calcul_master_server, Server}, {calculate, N, M}),
    cowboy_req: reply(200, Req2);

handle (<<"POST">>, false, Req) ->
    cowboy_req: reply(400, [], <<"Missing body.">>, Req);

handle (<<"GET">>,_, Req) ->
    Headers = [{<<"content-type">>, <<"text/html">>}],
    {ok, Body} = index_dtl: render([]),
    cowboy_req: reply(200, Headers, Body, Req);

handle (_, _, Req) ->
    %% Method not allowed.
    cowboy_req: reply(405, Req).

terminate (_Reason, _Req, _State) ->
    ok.
