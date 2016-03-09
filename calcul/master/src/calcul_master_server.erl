-module(calcul_master_server).
-behaviour(gen_server).

-export([start_link/0, calculate/2, register_front/1, close/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define (SERVER, ?MODULE).

%%% Client API
start_link () ->
    gen_server: start_link ({local, ?SERVER}, ?MODULE, [], []).

calculate (N, M) ->
    gen_server: call (?SERVER, {calculate, N, M}).

register_front (FrontPid)->
    gen_server: call (?SERVER, {register_front, FrontPid}).

close () ->
    gen_server: call (?SERVER, terminate).

%%% Server functions
init([]) -> {ok, undefined}.

handle_call({register_front, FrontPid}, _From, _State) ->
    {reply, ok, FrontPid};

handle_call({calculate, N, M}, _From, State) ->
    Result = calcul_master: calculate (N, M),
    FrontPid = State,
    Message = lists: flatten (io_lib: format("Result= ~p", [Result])),
    notify_server (FrontPid, Message),
    {reply, Result, State};

handle_call(terminate, _From, State) ->
    {stop, normal, ok, State}.

handle_cast(_,State) ->
    {noreply, State}.

handle_info(_Msg, State) ->
    io:format("Unexpected message: ~n"),
    {noreply, State}.

terminate(normal, _State) ->
    io:format("terminate~n"),
    ok.

code_change(_OldVsn, State, _Extra) ->
    %% No change planned. The function is there for the behaviour,
    %% but will not be used. Only a version on the next
    {ok, State}.

%%%%

notify_server (FrontPid, Message) ->
    gen_server: cast (FrontPid, {send_message, self(), Message}).


