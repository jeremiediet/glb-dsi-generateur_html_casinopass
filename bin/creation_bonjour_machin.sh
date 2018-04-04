#!/bin/bash


# ----------------------------------------------------------------------
# | Variables Générales                                                    |
# ----------------------------------------------------------------------

CURRENTDATE=$(date +%Y%m%d-%H%M)
FOLDER="Bjr"
DATACSV=data.csv
#FILE="document/${FOLDER}-${CURRENTDATE}/bonjour-${CURRENTDATE}.html"
FILE="brj.html"



# ----------------------------------------------------------------------
# | Print messages                                                     |
# ----------------------------------------------------------------------

print_check() {
    # print output in gray
    printf "\e[02m [.] $1\e[0m $2 \n"
}

print_error() {
    # print output in red
    printf "\e[31m [x] $1\e[0m $2 \n"
}

print_info() {
    # print output in white
    printf "\e[01m [-] $1\e[0m $2 \n"
}

print_question() {
    # print output in blue
    printf "\e[36m [?] $1\e[0m $2 \n"
}

print_success() {
    # print output in green
    printf "\e[32m [+] $1\e[0m $2 \n"
}

# ----------------------------------------------------------------------
# | Fonction                                                   |
# ----------------------------------------------------------------------
Verif_presence_data()
{
	if [[ ! -e ./data/$DATACSV ]]; then

		print_error "Le fichier ./data/$DATACSV est absent" 
		exit;
	else 
		print_success "OK Fichier $DATACSV est présent ";
	fi

}


Selectprog()
{
print_question "selectionnez le programme"
echo  ""[1]" delet old folder"
echo  ""[2]" Creation_folder"

read reponse 
case $reponse in
	"1") find document/* -type d -print0 | xargs -0 rm -rf;
                print_check "Old generated folders removed"
        Selectprog;;
	"2") Creation_folder;;
	"3") Ecrire_dans_lefichier;;
	*) Selectprog
esac
}

Clean()
{
	print_question "etes-vous sur ?"
	select yn in "Yes" "No"
    do
        case $yn in
            Yes )
                find document/* -type d -print0 | xargs -0 rm -rf;
                print_check "Old generated folders removed";
                break;;
            No )
                break;;
        esac
    done

    Selectprog
}

Creation_folder() 
{
	#mkdir -p ./document/${FOLDER}-${CURRENTDATE}
	Ecrire_dans_lefichier2 > ./document/bjr.html

	

}

Saut_de_ligne()
{
	echo "<BR>"
}

Ecrire_dans_lefichier2()
{
cpt=0
for ROWS in $(grep -vE "^#|^$" "data/$DATACSV"); do
        # IFS storage
        OIFS=$IFS
        IFS=',' read -r -a ROW <<< "$ROWS"

        # $0=nom
        # $1=age
        # $2=ville
        while [[ cpt<10 ]]; do

        	echo "$cpt ${ROW[0]} à ${ROW[1]} ans et vie actuelement à ${ROW[2]} <BR>" 
        	((cpt+=1))
        done

        # restore IFS
        IFS=$OIFS
    done
}

# ----------------------------------------------------------------------
# | RUN                                                   |
# ----------------------------------------------------------------------

Verif_presence_data
Creation_folder
