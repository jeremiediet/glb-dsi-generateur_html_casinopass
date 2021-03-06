#!/bin/bash

# ----------------------------------------------------------------------
# | Variables Générales                                                |
# ----------------------------------------------------------------------

CURRENTDATE=$(date +%Y%m%d-%H%M)
FOLDER="Bjr"
DATACSV=data.csv
#FILE="document/${FOLDER}-${CURRENTDATE}/bonjour-${CURRENTDATE}.html"
FILE_ANNIV_CARTE_NOIR_CARRE_VIP="anniversaire_carte_noire_carre_VIP.html"
FILE_ANNIV_CARTE_NOIR_CASINOPASS="anniversaire_carte_noire_Casinopass.html"
FILE_CONVERSIONT_POINT_CARRE_VIP="conversion_points_recompenses_carre_VIP.html"


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
# | Fonction                                 		                   |
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

Selectfichier()
{
print_question "Selectionnez le fichier à générer :"
echo  ""[1]" Anniversaire_carte_noire_carre_VIP"
echo  ""[2]" Anniversaire_carte_noire_Casinopass"
echo  ""[3]" Conversion_points_recompenses_carre_VIP "
echo  ""[4]" Tous"
echo  ""[5]" Supprimer les anciens fichiers générés "


read reponse 
case $reponse in
	"1") find document/* -type d -print0 | xargs -0 rm -rf;
                print_check "Old generated folders removed"
        Selectfichier;;
	"2") AnnivVIP > FILE_ANNIV_CARTE_NOIR_CARRE_VIP;;
	"3") AnnivCASINOPASS > FILE_ANNIV_CARTE_NOIR_CASINOPASS;;
	"4") BurnVIP > FILE_CONVERSIONT_POINT_CARRE_VIP;;
	"5") AnnivVIP > FILE_ANNIV_CARTE_NOIR_CARRE_VIP
AnnivCASINOPASS > FILE_ANNIV_CARTE_NOIR_CASINOPASS
BurnVIP > FILE_CONVERSIONT_POINT_CARRE_VIP;;
	"6") CellOpen;;
	*) Selectfichier
esac
}

BodyOpen()
{
echo -e "<body>  \n
		<table cellspacing="0" class="ms-rteTable-default" style="width: 100%;"> \n
   			<tbody>" \n
}

LineOpen()
{
echo -e "     <tr>" 
}

CellOpen()
{
echo -e "      <td class=\"ms-rteTable-default\">​​​​​​​​​​ "\n "top"
}

CellClose()
{

}

BodyClose()
{

}

AnnivVIP()
{
BodyOpen

}

AnnivCASINOPASS()
{

}

BurnVIP()
{

}
# ----------------------------------------------------------------------
# | Run		                              	            	           |
# ----------------------------------------------------------------------

Verif_presence_data
Selectfichier

