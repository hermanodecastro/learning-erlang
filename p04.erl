-module(p04).
-export ([fibonacci/1]).

fibonacci(1) -> 1;
fibonacci(2) -> 1;
fibonacci(N) ->
	fibonacci(N - 1) + fibonacci(N - 2).


