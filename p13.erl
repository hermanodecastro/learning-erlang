-module (p13).
-export ([start_server/0, client/1]).

%%	Sequencial socket server
%%	Client can send a value only one time, after server refuses

start_server() ->
	io:format("Server is running~n"),
	{ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 4}, {reuseaddr, true}, {active, true}]),
	{ok, Socket} = gen_tcp:accept(Listen),
	gen_tcp:close(Listen),
	loop(Socket).

loop(Socket) ->
	receive
		{tcp, Socket, Bin} ->
			io:format("Server received binary  = ~p~n", [Bin]),
			X = binary_to_term(Bin),
			io:format("Server (unpacked) ~p~n", [X]),
			Reply = pow(X),
			io:format("Server replying = ~p~n", [Reply]),
			gen_tcp:send(Socket, term_to_binary(Reply)),
			loop(Socket);
		{tpc_closed, Socket} ->
			io:format("Server socket closed~n")
	end.

client(X) ->
	{ok, Socket} = gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
	ok = gen_tcp:send(Socket, term_to_binary(X)),
	receive
		{tcp, Socket, Bin} ->
			io:format("Client received binary = ~p~n", [Bin]),
			Val = binary_to_term(Bin),
			io:format("Client result = ~p~n", [Val]),
			gen_tcp:close(Socket)
	end.

pow(X) -> X * X.