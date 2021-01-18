-module (p10).
-export ([loop/0, rpc/2]).

%%	Shell
%%
%%	Pid = spawn(p10, loop, []).
%%	p10:rpc(Pid, {rectangle, 5, 6}).
%%	p10:rpc(Pid, {square, 5}).
%% 	p10:rpc(Pid, {circle, 10}).
%%	p10:rpc(Pid, socks). (Error)
%%
%%	End.

rpc(Pid, Request) ->
	Pid ! {self(), Request},
	receive
		Response ->
			io:format("Response: ~p~n", [Response])
	end.

loop() ->
	receive
		{From, {rectangle, Width, Height}} ->
			From ! Width * Height,
			loop();
		{From, {square, Side}} ->
			From ! Side * Side,
			loop();
		{From, {circle, R}} ->
			From ! 3.14159 * R * R,
			loop();
		{From, Other} ->
			From ! {error, Other},
			loop()
	end.


