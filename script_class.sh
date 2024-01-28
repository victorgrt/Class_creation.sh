#!/bin/bash

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

# Créer le fichier Makefile
echo -e "NAME = $projet\n\nCXX = c++\nCXXFLAGS = -Wall -Wextra -Werror -std=c++98\n\nSRCS = main.cpp $projet.cpp\nOBJS = \$(SRCS:.cpp=.o)\n\nall: \$(NAME)\n\n\$(NAME): \$(OBJS)\n\t\$(CXX) \$(CXXFLAGS) -o \$@ \$^\n\n%.o: %.cpp\n\t\$(CXX) \$(CXXFLAGS) -c \$< -o \$@\n\nclean:\n\trm -f \$(OBJS)\n\nfclean: clean\n\trm -f \$(NAME)\n\nre: fclean all\n\n.PHONY: all clean fclean re" > Makefile

# Créer le fichier main.cpp
echo -e "#include \"$projet.hpp\"\n\n \
int main()\
\n{\n\
\t$projet my$projet;\n\
\t$projet your$projet = my$projet;\n\
\treturn 0;\n}" \
> main.cpp

# Créer le fichier .cpp
echo -e "#include \"$projet.hpp\"\n\n\
$projet::$projet()\n{\n\tstd::cout << GREEN << \"Constructeur par défault called.\" << RESET << std::endl;\n}\n\n\
$projet::$projet(const $projet& copie)\n{\n\t(void) copie;\n\tstd::cout << BLUE << \"Constructeur par copie called.\" << RESET << std::endl;\n}\n\n\
$projet::~$projet()\n{\n\tstd::cout << RED << \"Destructeur called.\" << RESET << std::endl;\n}\n\n\
$projet& $projet::operator=(const $projet& copie)\n{\n\t(void) copie;\n\tstd::cout << YELLOW << \"Operateur d\'affectation called.\" << RESET << std::endl;\treturn *this;\n}\n" \
> $projet.cpp

# Créer le fichier .hpp
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

# Afficher un message de confirmation
echo "Fichiers générés avec succès pour le projet $projet."

