#=========================================================================================
This was the initial repository repository for the stoicos language. It is now archived.
The project is now maintained [here](https://github.com/HellperKK/stoicos-lang).
#=========================================================================================

This is a french version of the readme. For english version look [here](https://github.com/HellperKK/Stoicos/blob/master/README_ENG.md)

# Stoicos
## Concept
Le Stoicos est un langage de programmation interprete en ruby.
Il est base sur le fait d'utliser un lexer tres simple ce qui faiclite le travail de developpement.

## Specifications
Le stoicos est un langage de programmation imperatif à traits fonctionnel, dynamiquement
typé et à conversion implicites. Son nom, vient de son caractère stoique, en effent il
est conçu pour ignorer la plupart des erreurs pour tourner coûte que coûte.

## Utilisation
Ecrire le code dans un fichier txt et executer la commande que voici :
`ruby Stoicos.rb Chemin`

Chemin peut être ou un fichier .txt ou un répertoire. Dans le second cas le fichier Main.txt de répertoire sera chargé.
Si chemin n'est pas donné alors le fichier Main.txt du répertoire courant sera chargé.

La presence de ruby 2.x est necessaire ainsi que de la gem gosu, pour la gestion
de jeux. Si vous souhaitez vous en passer vous pouver commenter la ligne suivante
dans le fichier Stoicos.rb

`require_relative "Src/GameDef"`

Sur windows la commande peut etre remplacee par
`Stoicos.exe Chemin`

## Documentation

Un wiki est disponible [ici](https://github.com/HellperKK/Stoicos/wiki)

## Comment contribuer

Pour l'instant le meilleur moyen de contribuer est dans l'utilisation du langage
soit dans la création de code soit dans la lecture des codes exemples. Cela me
permettra soit de corrger d'éventuels bugs soit de rajouter d'autres features.
