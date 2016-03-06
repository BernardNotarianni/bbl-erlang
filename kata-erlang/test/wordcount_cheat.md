# Kata wordcount Cheat Sheet

## Premier test

wordcount_test () ->
    ?assertEqual ("hello bbl", wordcount: text ("hello bbl")).


## Introduction du dict

- dict
- utilisation des variables non mutables

```erlang
list (L) ->
    D = dict: new (),
    D2= dict: store("aaa", 1, D),
    D3= dict: store("bbb", 2, D2),
    dict: to_list (D3).
```

# Itération recursive sur la liste

- un accumulateur en 2eme parametre
- un pattern matching pour terminer la recursion

```erlang
list ([], D)->
    D;
list (L, D)->
    W = hd(L),
    D2 = case dict: find (W, D) of
             {ok, Count} -> dict: store (W, Count+1, D);
             error -> dict: store (W, 1, D)
         end,
    list (tl(L), D2).
```

# Pattern matching dans les parametres

```erlang
list ([], D)->
    D;
list ([Word|Others], D)->
    D2 = case dict: find (Word, D) of
             {ok, Count} -> dict: store (Word, Count+1, D);
             error -> dict: store (Word, 1, D)
         end,
    list (Others, D2).
```
# Transformation en foldl


```erlang
list (L) ->
    DictEmpty = dict: new (),
    DictWithCounts = lists: foldl (fun add_word_count/2, DictEmpty, L),
    dict: to_list (DictWithCounts).

add_word_count (Word, D) ->
    case dict: find (Word, D) of
        {ok, Count} -> dict: store (Word, Count+1, D);
        error -> dict: store (Word, 1, D)
    end.
```
