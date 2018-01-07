%% Originally:
%% %% tserver_sup.erl
%% %% Kevin Lynx
%% %% 05.03.2013

-module(tcpserver_sup).
-behaviour(supervisor).
-export([start_link/4, start_child/1]).
-export([init/1]).

start_link(Callback, IP, Port, UserArgs) ->
  {ok, Pid} = supervisor:start_link(?MODULE, [Callback, IP, Port, UserArgs]),
  start_child(Pid),
  {ok, Pid}.

start_child(Server) ->
  supervisor:start_child(Server, []).

init([Callback, IP, Port, UserArgs]) ->
  BasicSockOpts = [binary,
                   {active, false},
                   {reuseaddr, true}],
  SockOpts = case IP of
               undefined -> BasicSockOpts;
               _ -> [{ip,IP} | BasicSockOpts]
             end,
  {ok, LSock} = gen_tcp:listen(Port, SockOpts),
  Server = {tcpserver_srv, {tcpserver_srv, start_link, 
                      [Callback, LSock, UserArgs]},
            temporary, brutal_kill, worker, [tcpserver_srv]},
  RestartStrategy = {simple_one_for_one, 1000, 3600},
  {ok, {RestartStrategy, [Server]}}.

