-module(p06).
-export([map/2, filter/2]).

% 	 Example
%
%    p06:map(fun(X) -> X * X end, [1, 2, 3, 4, 5]).
%
%
map(Fun, L) -> [Fun(X) || X <- L].

%	Example
%	
%	p06:filter(fun(X) -> (X rem 2) =:= 0 end, [1, 2, 3, 4, 5]).

filter(Pred, L) -> [X || X <- L, Pred(X)]. 