-module (p15).
-export ([server/0, client/1]).

%%	The simplest UDP Server and Client to calculate factorial

server() ->
	Port = 4000,
	{ok, Socket} = gen_udp:open(Port, [binary]),
	loop(Socket).

loop(Socket) ->
	receive
		{udp, Socket, Host, Port, Bin} ->
			N = binary_to_term(Bin),
			Reply = factorial(N),
			gen_udp:send(Socket, Host, Port, term_to_binary(Reply)),
			loop(Socket)
	end.

client(N) ->
	{ok, Socket} = gen_udp:open(0, [binary]),
	Port = 4000,
	ok = gen_udp:send(Socket, "localhost", Port, term_to_binary(N)),
	Response = 
		receive
			{udp, Socket, _, _, Bin} ->
				Bin
		after 2000 ->
			error
		end,
	gen_udp:close(Socket),
	Result = binary_to_term(Response),
	io:format("Response: ~p~n", [Result]).

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1). 
