-module (front_server).
-behaviour (gen_server).

-export ([start_link/0, connect/1, disconnect/1, send_message/1]).

%% gen_server callbacks
-export ([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

-define (SERVER, ?MODULE).

-record (state, {clients=[]}).

%%%=============================================================================
%%% API
%%%=============================================================================

start_link () ->
    gen_server: start_link({local, ?SERVER}, ?MODULE, [], []).

connect (Pid) ->
    gen_server: cast(?SERVER, {connect, Pid}).

disconnect (Pid) ->
    gen_server: cast(?SERVER, {disconnect, Pid}).

send_message (Message) ->
    gen_server: cast(?SERVER, {send_message, self(), Message}).

%%%=============================================================================
%%% gen_server callbacks
%%%=============================================================================

init([]) ->

    Dispatch = cowboy_router:compile([
        {'_', [
               {"/", index_handler, []}
              ,{"/ws", log_ws_handler, []}
              ,{"/static/[...]", cowboy_static, {priv_dir, front, "static"}}
              ]}
    ]),

    cowboy: start_http (front_http_listener, 100, [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]),
    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {noreply, State}.

handle_cast({connect, Pid}, State = #state{clients = Clients}) ->
    {noreply, State#state{clients = [Pid|Clients]}};
handle_cast({disconnect, Pid}, State = #state{clients = Clients}) ->
    {noreply, State#state{clients  = Clients -- [Pid]}};
handle_cast({send_message, FromPid, Message}, State) ->
    do_send_message(FromPid, Message, State),
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    cowboy:stop_listener(chat).

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%=============================================================================
%%% Internal functions
%%%=============================================================================

do_send_message(FromPid, Message, #state{clients = Clients}) ->
    OtherPids = Clients -- [FromPid],
    lists:foreach(
      fun(OtherPid) ->
              OtherPid ! {send_message, self(), Message}
      end, OtherPids).
