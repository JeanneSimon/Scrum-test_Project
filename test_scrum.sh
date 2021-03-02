#!/bin/bash

# programme qui va permettre de lancer un test blanc pour la certification Scrum Master de niveau I

# echo "Bonjour !"
# cat ~/test_scrum/questions/1 | grep -E "^\/"
# echo "Entrez votre réponse :"
# read reponse
# attendu=`tail -n 2 test_scrum/questions/1`

# VARIABLES :
reponse="" # réponse donnée par l'utilisateur
attendu="" # réponse de la question
nb=`ls questions/ | wc -l` # nombre de questions dans le répertoire questions/
vrai="" # nombre de bonnes réponses
faux="" # nombre de mauvaises réponses
score="" # pourcentage de bonnes réponses
question="10" # nombre de questions dans le test
indice="" # indice du tableau
declare -a tableau # déclaration du tableau pour la fonction test aléatoire

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
	echo ""
	echo "_______________________"
        cat ~/Scrum-test_Project/questions/$i | grep -E "^\/"
        echo "_______________________"
	echo ""
	echo "Entrez votre réponse :"
        read reponse
        attendu=`tail -n 2 ~/Scrum-test_Project/questions/$i`
        if [ $reponse = $attendu ]; then
	    echo ""
            echo "Bonne réponse !"
            vrai="$vrai+1"
        else
	    echo ""	
	    echo "Mauvaise réponse !"
	    echo "La bone réponse réponse : $attendu ..."
            faux="$faux+1"
        fi
    done
    score=$(($(($vrai*100))/80))
    echo -e "\nLe test blanc est terminé !\nVous avez fait un score de $score% ( vrai=$vrai et faux=$faux )."
}

#  Test aléatoire (paramètre = nb de questions totale du test):
function test_aleatoire {
    tableau=( $( seq 1 1 $nb ) )
    tableau=( $(shuf -e "${tableau[@]}") )
    for i in `seq 1 $question`
    do
        # attribution de valeur pour la variable indice
        indice=$(($i-1))
        valeur=${tableau[$indice]}
        # Affichage de la question 
        echo ""
        echo "__________________________"
        cat ~/Scrum-test_Project/questions/$valeur | grep -E "^\/"
        echo "__________________________"
        echo ""
        # Saisie de la réponse
        echo "Entrez votre réponse (ex: "A" ou "ACD") :"
        read reponse
        # Récupération et retour de la bonne réponse
        attendu=`tail -n 2 ~/Scrum-test_Project/questions/$valeur`
        # Condition si bonne ou mauvaise réponse
        if [ $reponse = $attendu ]; then
	        echo ""
            echo "Bonne réponse !"
            vrai=$(($vrai+1))
        else
	        echo ""	
	        echo "Mauvaise réponse !"
	        echo "La bone réponse réponse : $attendu ..."
            faux=$(($faux+1))
        fi
        # Supprimer la question du tableau
    done

    # Affichage du score
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
            test_aleatoire
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

