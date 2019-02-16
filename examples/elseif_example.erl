%% Copying and distribution of this file, with or without modification,
%% are permitted in any medium without royalty provided the copyright
%% notice and this notice are preserved.  This file is offered as-is,
%% without any warranty.

-module(elseif_example).

-export([f/1]).

-include_lib("elseif/include/elseif.hrl").

f(X) ->
    ?'if'(X > 0)   -> pos
    ?elseif(X < 0) -> neg
    ?else          -> zero
    end.

%% Running this example
%% ====================
%% $ ~/elseif$ ERL_LIBS=.. erl
%% Erlang/OTP 21 [erts-10.2.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1]
%%
%% Eshell V10.2.3  (abort with ^G)
%% 1> c("src/elseif_parse_trans.erl").
%% {ok,elseif_parse_trans}
%% 2> c("examples/elseif_example.erl").  
%% {ok,elseif_example}
%% 3> elseif_example:f(8).
%% pos
%% 4> elseif_example:f(-1).
%% neg
%% 5> elseif_example:f(0). 
%% zero
