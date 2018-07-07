# Stoicos
## Concept
Le Stoicos est un langage de programmation interprete en ruby.
Il est base sur le fait d'utliser un lexer tres simple ce qui faiclite le travail de developpement.

## Utilisation
Ecrire le code dans un fichier txt et executer la commande que voici :
> ruby Stoicos.rb Chemin

Chemin peut être ou un fichier .txt ou un répertoire. Dans le second cas le fichier Main.txt de répertoire sera chargé.
Si chemin n'est pas donné alors le fichier Main.txt du répertoire courant sera chargé.

La presence de ruby 2.x est necessaire ainsi que de la gem gosu, pour la gestion
de jeux. Si vous souhaitez vous en passer vous pouver commenter la ligne suivante
dans le fichier Stoicos.rb

> require_relative "Src/GameDef"

Sur windows la commande peut etre remplacee par
> Stoicos.exe Chemin

## Comment contribuer

Pour l'instant le meilleur moyen de contribuer est dans l'utilisation du langage
soit dans la création de code soit dans la lecture des codes exemples. Cela me
permettra soit de corrger d'éventuels bugs soit de rajouter d'autres features.
