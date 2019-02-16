%% Copying and distribution of this file, with or without modification,
%% are permitted in any medium without royalty provided the copyright
%% notice and this notice are preserved.  This file is offered as-is,
%% without any warranty.

%% These macros expand to valid Erlang syntax, but it's nonsense unless used
%% with the parse transform.
-define('if'(Cond), case [Cond || 'if'] of true).
-define(elseif(Cond), end, case [Cond || elseif] of true).
-define(else, end, case [else || else] of true).

-compile([{parse_transform, elseif_parse_trans}]).
