-module(p07).
-export([is_pair/1]).

is_pair(X) when (X rem 2) =:= 0 -> true;
is_pair(X) -> false.
