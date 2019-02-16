%% Copying and distribution of this file, with or without modification,
%% are permitted in any medium without royalty provided the copyright
%% notice and this notice are preserved.  This file is offered as-is,
%% without any warranty.

-module(elseif_parse_trans).

-export([parse_transform/2]).

parse_transform(Forms, _Opts) ->
    forms(Forms).

forms([{'case', P,
                {lc, _, Cond, [{atom, _, 'if'}]},
                [{clause, _, [{atom, _, true}], [], Then}]} | Forms]) ->
    {Else, Rest} = elseifs(Forms),
    ThenClause = {clause, P, [{atom, P, true}], [], Then},
    ElseClause = {clause, P, [{atom, P, false}], [], Else},
    [{'case', P, Cond, [ThenClause, ElseClause]} | forms(Rest)];
forms([F|Fs]) ->
    [forms(F)|forms(Fs)];
forms(F) when is_tuple(F) ->
    list_to_tuple(lists:map(fun forms/1, tuple_to_list(F)));
forms(F) ->
    F.

elseifs([{'case', P,
                {lc, _, Cond, [{atom, _, elseif}]},
                [{clause, _, [{atom, _, true}], [], Then}]} | Forms]) ->
    {Else, After} = elseifs(Forms),
    ThenClause = {clause, P, [{atom, P, true}], [], Then},
    ElseClause = {clause, P, [{atom, P, false}], [], Else},
    {[{'case', P, Cond, [ThenClause, ElseClause]}], After};
elseifs([{'case', _P,
                {lc, _, {atom, _, else}, [{atom, _, else}]},
                [{clause, _, [{atom, _, true}], [], Else}]} | Forms]) ->
    {Else, Forms};
elseifs(_) ->
    error(no_else).
