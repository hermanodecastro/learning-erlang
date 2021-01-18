-module (p11).
-export ([client/2, server/0]).

%%	Client-Server Application
%%
%%	This program receives a message and responds by concatenating the message sent with a sentence.
%%
%%	End 

client(Pid, Msg) ->
	Pid ! {self(), Msg},
	receive
		Response -> 
			io:format("~p~n", [Response])
	end.

server() ->
	receive
		{From, Msg} ->
			From ! io:format("I receive your msg [~p] bye.~n", [Msg]),
			server();
		{From} ->
			From ! {error},
			server()
	end.

