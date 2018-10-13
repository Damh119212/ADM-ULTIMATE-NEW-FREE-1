#!/bin/bash
# Bin _ Gen #OFC
SCPdir="/etc/newadm" && [[ ! -d ${SCPdir} ]] && exit
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
fun_trans () { 
local texto
local retorno
declare -A texto
SCPidioma="${SCPdir}/idioma"
[[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}
local LINGUAGE=$(cat ${SCPidioma})
[[ -z $LINGUAGE ]] && LINGUAGE=pt
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z "$(echo ${texto[$@]})" ]]; then
 retorno="$(source trans -e google -b pt:${LINGUAGE} "$@"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
 if [[ $retorno = "" ]];then
 retorno="$(source trans -e bing -b pt:${LINGUAGE} "$@"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
 fi
 if [[ $retorno = "" ]];then 
 retorno="$(source trans -e yandex -b pt:${LINGUAGE} "$@"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
 fi
echo "texto[$@]='$retorno'"  >> /etc/texto-adm
echo "$retorno"
else
echo "${texto[$@]}"
fi
}
link_bin="https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-ULTIMATE-NEW-FREE/master/Install/generadorcc.py"
[[ ! -e /usr/bin/generadorcc.py ]] && wget -O /usr/bin/generadorcc.py ${link_bin} > /dev/null && chmod +x /usr/bin/generadorcc.py
msg -ama "$(fun_trans "GERADOR DE BINS OFICIAL")"
msg -bar
msg -ne "$(fun_trans "Digite a bin"): " && read UsrBin
while [[ ${#UsrBin} -lt 16 ]]; do
UsrBin+="x"
done
msg -ne "$(fun_trans "Quantas Bins Quer Gerar"): " && read GerBin
[[ $GerBin != +([0-9]) ]] && GerBin=10
[[ -z $GerBin ]] && GerBin=10
msg -bar
python /usr/bin/generadorcc.py -b ${UsrBin} -u ${GerBin} -d -c
msg -bar