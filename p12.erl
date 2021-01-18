-module (p12).
-export ([start/0, store/2, lookup/1]).

%%	Shell
%%
%%	p12:start().
%%	p12:store({location, joe}, "Stockholm").
%%	p12:store(weather, raining).
%%	p12:lookup(weather).
%%	p12:lookup({location, joe}).
%%	p12:lookup({location, jane}). (Undefined)
%%
%%	End

start() -> 
	register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) -> 
	rpc({store, Key, Value}).

lookup(Key) -> 
	rpc({lookup, Key}).

rpc(Q) ->
	kvs ! {self(), Q},
	receive
		{kvs, Reply} ->
			Reply
	end.

loop() ->
	receive
		{From, {store, Key, Value}} ->
			put(Key, {ok, Value}),
			From ! {kvs, true},
			loop();
		{From, {lookup, Key}} ->
			From ! {kvs, get(Key)},
			loop()
	end.

