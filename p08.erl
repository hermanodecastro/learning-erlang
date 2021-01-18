-module(p08).
-export([area/2]).

-spec area(atom(), tuple()) -> float().

area(square, {X}) -> X * X;
area(rectangle, {X, Y}) -> X * Y. 


