#!/bin/bash

# ----------------------------------------------------------------------
# | Variables Générales                                                |
# ----------------------------------------------------------------------

CURRENTDATE=$(date +%Y%m%d-%H%M)
FOLDER=""
DATACSV=datas.csv
#FILE="document/${FOLDER}-${CURRENTDATE}/bonjour-${CURRENTDATE}.html"
FILE_ANNIV_CARTE_NOIR_CARRE_VIP="./document/anniversaire_carte_noire_carre_VIP.html"
FILE_ANNIV_CARTE_NOIR_CASINOPASS="./document/anniversaire_carte_noire_Casinopass.html"
FILE_CONVERSIONT_POINT_CARRE_VIP="./document/conversion_points_recompenses_carre_VIP.html"

STAR1="*"
STAR2="* *"
STAR3="* * *"
STAR4="* * * *"
STAR5="* * * * *"

RATECPIC="<B>CPIC </B>: Rate code pour le client casino hors resort."
RATECPIRC="<B>CPIRC </B>: Rate code pour le client casino hors resort."

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
	"5") find ./document/* -type d -print0 | xargs -0 rm -rf; >2 error.log
                print_check "Old generated folders removed"
        Selectfichier;;
	"1") 	AnnivVIP > $FILE_ANNIV_CARTE_NOIR_CARRE_VIP
				print_success "le fichier $Anniversaire_carte_noire_carre_VIP à été généré avec succes";;
	"2") 	AnnivCASINOPASS > FILE_ANNIV_CARTE_NOIR_CASINOPASS;;
	"3") 	BurnVIP > FILE_CONVERSIONT_POINT_CARRE_VIP;;
	"4") 	AnnivVIP > FILE_ANNIV_CARTE_NOIR_CARRE_VIP
			AnnivCASINOPASS > FILE_ANNIV_CARTE_NOIR_CASINOPASS
			BurnVIP > FILE_CONVERSIONT_POINT_CARRE_VIP;;
	"8") 	Run;;
	*) Selectfichier
esac
}

BodyOpen()
{
echo -e "<body> 
	<table cellspacing=\"0\" class=\"ms-rteTable-default\" style=\"width: 100%;\"> 
   	<tbody>" 
}

BodyClose()
{
echo -e "	</tbody>
	</table>
</body>​​"
}
LineOpen()
{
cpt=0
echo -e "		<tr>" 
}

LineClose()
{
echo -e "		</tr>" 	
}

CellOpen()
{
echo -e "			<td class=\"ms-rteTable-default\">​​​​​​​​​​ "

}

CellClose()
{
echo -e "			</td>"
}

 Run()
{
BodyOpen
LineOpen
CellOpen
CellClose
CellOpen
CellClose
LineClose
BodyClose
TEST

}

AnnivVIP()
{
BodyOpen	
for ROWS in $(grep -vE "^#|^$" "data/$DATACSV"); do
        # IFS storage
        OIFS=$IFS
        IFS=',' read -r -a ROW <<< "$ROWS"

        # $0=station
        # $1=hotel
        # $2=star
        # $3=img
        # $4=tunel
        # $5=codehtl
        # $6=langue
        # $7=ratecode
        # $8=mkcode
        # $9=commentaire

        	LineOpen
        	CellOpen
        	echo -e "              <img src=\"${ROW[3]}\" alt=\"\" style=\"float: left; margin-right: 40px;\"/>" 
        	CellClose
        	CellOpen
        	echo -e "            <p>
                <b> ${ROW[0]} | Hôtel Barrière ${ROW[1]} ${ROW[2]} </b> <br/>ANNIVERSAIRE CARRE VIP NOIRE</p>
                <p>"

        #phrase en fonction du ratecode
            case ${ROW[7]} in
            	CPIC ) echo "$RATECPIC";;
            	CPIRC ) echo "$RATECPIRC" ;;
            esac
            echo -e "               </p>
            <p>&gt;&#160;<a href=\"https://booking.lucienbarriere.com/lbwebbooking/?h=${ROW[5]}&amp;l=${ROW[6]}&amp;rc=${ROW[7]}&amp;mk=${ROW[8]}\"><u>Réservez</u></a> ${ROW[9]} <br/> </p>"
            CellClose
            LineClose



        # restore IFS
        IFS=$OIFS
    done
BodyClose
}

TEST()
{
for ROWS in $(grep -vE "^#|^$" "data/$DATACSV"); do
        # IFS storage
        OIFS=$IFS
        IFS=',' read -r -a ROW <<< "$ROWS"

        # $0=station
        # $1=hotel
        # $2=star
        # $3=img
        # $4=tunel
        # $5=codehtl
        # $6=langue
        # $7=ratecode
        # $8=mkcode
        # $9=commentaire
        
            LineOpen
            CellOpen
            echo -e "<img src=\"${ROW[3]}<BR>
            alt="" style=\"float: left; margin-right: 40px;\"/>" 
            CellClose
            CellOpen
            echo -e "<p>
               <b> ${ROW[0]} | Hôtel Barrière ${ROW[1]} ${ROW[2]} </b> <br/>ANNIVERSAIRE CARRE VIP NOIRE</p>
            <p>"

        #phrase en fonction du ratecode
            case ${ROW[7]} in
                CPIC ) echo "$RATECPIC";;
                CPIRC ) echo "$RATECPIRC" ;;
            esac
            echo -e "</p>
            <p>&gt;&#160;<a href=\"https://booking.lucienbarriere.com/lbwebbooking/?h=${ROW[5]}&amp;l=${ROW[6]}&amp;rc=${ROW[7]}&amp;mk=${ROW[8]}\"><u>Réservez</u></a> ${ROW[9]} <br/> </p>"
            CellClose
            LineClose

        # restore IFS
        IFS=$OIFS
    done    
}

# ----------------------------------------------------------------------
# | Run		                              	            	           |
# ----------------------------------------------------------------------

Verif_presence_data
Selectfichier

