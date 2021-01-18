-module(p09).
-export([loop/0]).

%%	Shell
%%
%%	Pid = spawn(p09, loop, []).
%%	Pid ! {rectangle, 5, 4}.
%% 	Pid ! {square, 5}.
%%
%% 	End

loop() -> 
	receive
		{rectangle, Width, Height} ->
			io:format("Area of rectangle is ~p~n", [Width * Height]),
			loop();
		{square, Side} -> 
			io:format("Area of square is ~p~n", [Side * Side]),
			loop()
	end.
