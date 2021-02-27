#!/bin/bash

# programme qui va permettre de lancer un test blanc pour la certification Scrum Master de niveau I

# echo "Bonjour !"
# cat ~/test_scrum/questions/1 | grep -E "^\/"
# echo "Entrez votre réponse :"
# read reponse
# attendu=`tail -n 2 test_scrum/questions/1`

# VARIABLES :
reponse=""
attendu=""
nb=""
vrai=""
faux=""
score=""
# FONCTIONS :

# Menu a améliorer qui va permetttre de lancer le test (ordre croissant dans un premier temps + ajout aléatoire)
function menu {
    echo "__________________________"
    echo "MENU TEST SCRUM"
    echo "1. Lancer un test blanc"
    echo "2. Lancer un test blanc aléatoire"
    echo "Q. Quitter"
    read choixmenu
}

# Programme test blanc :
function test_croissant {
    for ((i=1; i < 81; i++)); do
#        echo $i
        cat ~/test_scrum/questions/$i | grep -E "^\/"
        echo "Entrez votre réponse :"
        read reponse
        attendu=`tail -n 2 ~/test_scrum/questions/$i`
        if [ $reponse = $attendu ]; then
            echo "Bonne réponse !"
            vrai="$vrai+1"
        else 
            echo -e "Mauvaise réponse !\nLa réponse était : $attendu..."
            faux="$faux+1"
        fi
    done
    score=$(($(($vrai*100))/80))
    echo -e "\nLe test blanc est terminé !\nVous avez fait un score de $score% ( vrai=$vrai et faux=$faux )."
}


# MENU :
while true; do
    menu
    case $choixmenu in
        1)
            test_croissant
            ;;
        2)
            echo "test aléatoire"
            ;;
        [Qq]*)
            echo "Casse toi !"
            exit 0
            ;;
        *)
            echo "Erreur de saisi"
            ;;     
    esac
done