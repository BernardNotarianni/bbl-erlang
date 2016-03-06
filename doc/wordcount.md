
# Objectif

Donner une idée de la syntaxe d'erlang au travers d'un exercice
simple.

Les notions abordées:
- Boucle à l'aide de la recurssion
- Pattern matching
- dict
- case

# Le kata

Compter le nombre d'occurence de chaque mot d'un texte.
Un texte est une liste de chaines de caractères.

# Le plan

1. Découper les mots d'une string
2. Compter le nombre de mots d'une string
3. Compter le nombre de mots d'une liste de string

`string:tokens(String,Sep)` decouper `String` selon les séparateurs
donnés dans `Sep`
