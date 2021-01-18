-module (p14).
-export ([start_server/0, client/1]).

%%	Parallel socket server
%%	Client can send value many times.

start_server() ->
	io:format("Server is running~n"),
	{ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 4}, {reuseaddr, true}, {active, true}]),
	spawn(fun() -> connect(Listen) end).

%%	Parallel connect
connect(Listen) ->
	{ok, Socket} = gen_tcp:accept(Listen),
	spawn(fun() -> connect(Listen) end),
	loop(Socket).

loop(Socket) ->
	receive
		{tcp, Socket, Bin} ->
			io:format("Server received binary  = ~p~n", [Bin]),
			N = binary_to_term(Bin),
			io:format("Server (unpacked) ~p~n", [N]),
			Reply = factorial(N),
			io:format("Server replying = ~p~n", [Reply]),
			gen_tcp:send(Socket, term_to_binary(Reply)),
			loop(Socket);
		{tpc_closed, Socket} ->
			io:format("Server socket closed~n")
	end.

client(N) ->
	{ok, Socket} = gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
	ok = gen_tcp:send(Socket, term_to_binary(N)),
	receive
		{tcp, Socket, Bin} ->
			io:format("Client received binary = ~p~n", [Bin]),
			Val = binary_to_term(Bin),
			io:format("Client result = ~p~n", [Val]),
			gen_tcp:close(Socket)
	end.

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).
