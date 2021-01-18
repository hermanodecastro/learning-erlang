-module (p17).
-export ([client/1, server/0]).
-import (calendar, [local_time/0]).

%%	Shell
%%
%%	Pid = spawn(p18, server, []).
%%	p18:client(Pid).
%%
%%	End.

client(Pid) ->
	Hour = local_time(),
	Pid ! {self(), Hour},
	receive
		Response -> 
			io:format("~p~n", [Response])
	end.

server() ->
	receive
		{From, Hour} ->
			From ! io:format("The hour is: [~p] bye.~n", [Hour]),
			server();
		{From} ->
			From ! {error},
			server()
	end.