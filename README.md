Classic if-elseif-else in Erlang
================================

Erlang doesn't have if-elseif-else like most other languages do. This is a
trick to achieve this using macros and a parse transform.

```Erlang
-include_lib("elseif/include/elseif.hrl").

f(X) ->
    ?'if'(X > 0)   -> pos
    ?elseif(X < 0) -> neg
    ?else          -> zero
    end.
```

During compilation, this is rewritten to nested case expressions.

```
f(X) ->
    case X > 0 of
        true ->
            pos;
        false ->
            case X < 0 of
                true ->
                    neg;
                false ->
                    zero
            end
    end.
```

You may use this library as a dependency or simply copy the files to your project.

Note
----

This style is not idematic in Erlang so it might be confusing other people.
The ideomatic Erlang way of writing the example above is

```Erlang
f(X) when X > 0 -> pos;
f(X) when X < 0 -> neg;
f(_)            -> zero;
```

License
-------

```Erlang
%% Copying and distribution of this file, with or without modification,
%% are permitted in any medium without royalty provided the copyright
%% notice and this notice are preserved.  This file is offered as-is,
%% without any warranty.
```
