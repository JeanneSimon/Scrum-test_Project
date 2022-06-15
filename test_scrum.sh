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
question="" # nombre de questions dans le test
indice="" # indice du tableau
declare -a tableau # déclaration du tableau pour la fonction test aléatoire

# FONCTIONS :

# Menu a améliorer qui va permetttre de lancer le test (ordre croissant dans un premier temps + ajout aléatoire)
function menu {
    echo "__________________________"
    echo "MENU TEST SCRUM"
    echo "1. Lancer un test blanc"
    echo "Q. Quitter"
    read choixmenu
    echo "__________________________"
    clear
}
function menu_2 {
    echo "__________________________"
    echo "CHOIX DU TEST"
    echo "1. Test de 10 questions"
    echo "2. Test de 30 questions"
    echo "3. Test de 80 quesions (standard)"
    echo "4. Au choix"
    echo "Q. Quitter"
    read choixmenu2
    echo "__________________________"
    clear
}

#  Test aléatoire (paramètre = nb de questions totale du test):
function test_aleatoire {
    question=$1
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
        cat ./questions/$valeur | grep -E "^\/"
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
	        echo "La bonne réponse : $attendu ..."
            faux=$(($faux+1))
        fi
        # Supprimer la question du tableau
    done

    # Affichage du score
    score=$(($(($vrai*100))/$question))
    echo -e "\nLe test blanc est terminé !\nVous avez fait un score de $score% ( vrai=$vrai et faux=$faux )."
}


# MENU :
while true; do
    menu
    case $choixmenu in
        1)
            menu_2
            case $choixmenu2 in
                1)
                    echo "Test de 10 questions"
                    test_aleatoire 10
                ;;
                2)
                    echo "Test de 30 questions"
                    test_aleatoire 30
                ;;
                3)
                    echo "Test de 80 questions"
                    test_aleatoire 80
                ;;
                4)
                    echo "Combien de questions souhaitez-vous avoir dans le test ?"
                    read nombre
                    test_aleatoire $nombre
                ;;
                [Qq]*)
                    echo "Bye !"
                    break
                ;;
                *)
                    echo "Erreur de saisi !"
                ;;
            esac
            ;;
        [Qq]*)
            echo "Casse toi !"
            exit 0
            ;;
        *)
            echo "Erreur de saisi !"
            ;;     
    esac
done

