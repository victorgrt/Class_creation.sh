#!/bin/bash

# Fonction pour afficher une barre de chargement avec informations
function afficher_barre_chargement_informations() {
    local texte="$1"
    local pourcentage="$2"
    local largeur=30
    local delay=0.005

    # Calculer le nombre de caractères à afficher pour le pourcentage
    local chars_pourcentage=$((($pourcentage * $largeur) / 100))

    echo -n -e "$texte ["

    local i
    for i in $(seq 1 $chars_pourcentage); do
        echo -n "#"
        sleep $delay
    done

    # Afficher les espaces vides
    for i in $(seq 1 $((largeur - chars_pourcentage))); do
        echo -n " "
    done

    echo -e -n "] $pourcentage%"
}

# Fonction pour afficher une étape du script avec couleur et délai
function afficher_etape_script() {
    local texte="$1"
    local couleur="$2"
    local delay=0.3

    echo -e -n "$couleur$texte$RESET"
    sleep $delay
}

# Définir les couleurs de texte
RESET="\\033[0m"
BOLD="\\033[1m"
GREEN="\\033[1;32m"
BLUE="\\033[1;34m"
YELLOW="\\033[1;33m"
MAGENTA="\\033[1;35m"
RED="\\033[1;31m"

# Vérifier si le nombre d'arguments est correct
if [ $# -lt 1 ]; then
    echo "Usage: $0 <nom_du_projet> [DELETE]"
    exit 1
fi

# Nom du projet
projet=$1

# Vérifier si l'argument est "DELETE"
if [ "$2" == "DELETE" ]; then
    # Supprimer les fichiers
    rm -f Makefile $projet.cpp $projet.hpp main.cpp ./$projet *.o
    echo "Fichiers supprimés avec succès pour le projet $projet."
    exit 0
fi

# Afficher la barre de chargement pour l'ensemble du script
echo -e "$BOLD\nScript en cours d'exécution...$RESET"
pourcentage=0

# Créer le fichier Makefile
afficher_etape_script "Création du fichier Makefile" "$BLUE"
sleep 0.5
echo -e "NAME = $projet\n\nCXX = c++\nCXXFLAGS = -Wall -Wextra -Werror -std=c++98\n\nSRCS = main.cpp $projet.cpp\nOBJS = \$(SRCS:.cpp=.o)\n\nall: \$(NAME)\n\n\$(NAME): \$(OBJS)\n\t\$(CXX) \$(CXXFLAGS) -o \$@ \$^\n\n%.o: %.cpp\n\t\$(CXX) \$(CXXFLAGS) -c \$< -o \$@\n\nclean:\n\trm -f \$(OBJS)\n\nfclean: clean\n\trm -f \$(NAME)\n\nre: fclean all\n\n.PHONY: all clean fclean re" > Makefile
pourcentage=25
afficher_barre_chargement_informations " Progression globale du script" $pourcentage
echo -e " - $GREEN Fichier Makefile créé avec succès$RESET"

# Créer le fichier main.cpp
afficher_etape_script "Création du fichier main.cpp" "$YELLOW"
sleep 0.5
echo -e "#include \"$projet.hpp\"\n\n \
int main()\
\n{\n\
\t$projet my$projet;\n\
\t$projet your$projet = my$projet;\n\
\treturn 0;\n}" \
> main.cpp
pourcentage=50
afficher_barre_chargement_informations " Progression globale du script" $pourcentage
echo -e " - $GREEN Fichier main.cpp créé avec succès$RESET"
# Créer le fichier .cpp
afficher_etape_script "Création du fichier $projet.cpp" "$MAGENTA"
sleep 0.5
echo -e "#include \"$projet.hpp\"\n\n\
$projet::$projet()\n{\n\tstd::cout << GREEN << \"Constructeur par défaut called.\" << RESET << std::endl;\n}\n\n\
$projet::$projet(const $projet& copie)\n{\n\t(void) copie;\n\tstd::cout << BLUE << \"Constructeur par copie called.\" << RESET << std::endl;\n}\n\n\
$projet::~$projet()\n{\n\tstd::cout << RED << \"Destructeur called.\" << RESET << std::endl;\n}\n\n\
$projet& $projet::operator=(const $projet& copie)\n{\n\t(void) copie;\n\tstd::cout << YELLOW << \"Operateur d\'affectation called.\" << RESET << std::endl;\treturn *this;\n}\n" \
> $projet.cpp
pourcentage=75
afficher_barre_chargement_informations " Progression globale du script" $pourcentage
echo -e " - $GREEN Fichier $projet.cpp créé avec succès$RESET"

# Créer le fichier .hpp
afficher_etape_script "Création du fichier $projet.hpp" "$RED"
sleep 0.5
echo -e "#ifndef ${projet^^}_HPP\n#define ${projet^^}_HPP\n\n\
#include <iostream>\n\n\
#define RESET \"\\033[0m\"\n\
#define BOLD \"\\033[1m\"\n\
#define GREEN \"\\033[1;32m\"\n\
#define BLUE \"\\033[1;34m\"\n\
#define YELLOW \"\\033[1;33m\"\n\
#define MAGENTA \"\\033[1;35m\"\n\
#define RED \"\\033[1;31m\"\n\n\
class $projet\n\
{\n\
\tprivate : \n\n\
\tpublic : \n\
\t$projet();\n\
\t$projet(const $projet& copie);\n\
\t~$projet();\n\
\t$projet& operator=(const $projet& copie);\n\n\
};\n\n\
#endif" > $projet.hpp
pourcentage=100
afficher_barre_chargement_informations " Progression globale du script" $pourcentage
echo -e " - $GREEN Fichier $projet.hpp créé avec succès$RESET"
# Afficher un message de confirmation
longueur_nom=${#projet}


# Longueur totale de la ligne (40 caractères)
longueur_totale=33

# Calculer l'espace à ajouter après le nom de la classe
espace_apres_nom=$((longueur_totale - longueur_nom - 2))

# Utiliser printf pour assurer un alignement correct
echo -e "$GREEN╔═════════════════════════════════════╗\n\
║                                     ║\n\
║            Fichiers Créés           ║\n\
║                                     ║\n\
║ $BLUE Makefile$RESET$GREEN                           ║\n\
║ $YELLOW main.cpp$RESET$GREEN                           ║\n\
║  $MAGENTA$(printf "%-${longueur_nom}s" "$projet.cpp")$(printf "%-${espace_apres_nom}s" " ")$RESET$GREEN║\n\
║  $RED$(printf "%-${longueur_nom}s" "$projet.hpp")$(printf "%-${espace_apres_nom}s" " ")$RESET$GREEN║\n\
║                                     ║\n\
╚═════════════════════════════════════╝$RESET"
