-module(p02).
-export([factorial/1]).

factorial(0) -> 1;
factorial(N) when N > 0 ->
	N * factorial(N - 1).
