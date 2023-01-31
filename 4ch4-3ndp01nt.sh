#/bin/bash
banner()
{
echo -e "\e[5;32m"
echo '==================================================================================================='
echo '======  =========  =========  ===============   =============  ========      =====  ==============='
echo '=====   =========  ========   =============   =   ===========  =======   ==   ===   ==============='
echo '====    =========  =======    ============   ===   ==========  =======  ====  ====  ===========  =='
echo '===  =  ====   ==  ======  =  =================   ==  = =====  =    ==  ====  ====  ====  = ==    ='
echo '==  ==  ===  =  =    ===  ==  ===        ====    ===     ==    =  =  =  ====  ====  ====     ==  =='
echo '=  ===  ===  ====  =  =  ===  =================   ==  =  =  =  =  =  =  ====  ====  ====  =  ==  =='
echo '=         =  ====  =  =         ==========   ===   =  =  =  =  =    ==  ====  ====  ====  =  ==  =='
echo '======  ===  =  =  =  ======  =============   =   ==  =  =  =  =  ====   ==   ====  ====  =  ==  =='
echo '======  ====   ==  =  ======  ===============   ====  =  ==    =  =====      ===      ==  =  ==   ='
echo '==================================================================================================='
echo ""
echo "By Carlos Tuma - Bl4dsc4n - 4ch4-3ndpoint-versão 0.1"
echo ""
echo "Ps. Nao faca teste em dominio sem permissao."
echo -e "\e[0m"
}

banner2()
{
echo -e "\e[5;32m"
echo ""
echo "Use: ./4ch4-3ndp01nt.sh url.txt enpoint.txt NOME-PASTA-SAIDA s"
echo ""
echo " s = silent n = normal"
echo -e "\e[0m"

}

dep()
{
#echo "Testando dependenciais"
echo ""
if ! [[ -e ~/$1 ]];then echo "Arquivo url ~/$1 nao existe";banner;exit;else echo "" >/dev/null;fi
if ! [[ -e ~/$2 ]];then echo "Arquvivo enpoint ~/$2 nao existe";banner;exit;else echo "" >/dev/null;fi
if [[ -z ~/$3 ]];then echo "Nome da Pasta de saida necessario";banner;exit;else echo "" >/dev/null;fi
if ! [[ -e /usr/bin/anew ]];then banner;echo "Faltando pacote anew para funcionar";exit;else echo "" >/dev/null;fi
if ! [[ -e /usr/bin/httprobe ]];then banner; echo "Faltando pacote httprobe para funcionar";exit;else echo "" >/dev/null;fi
if ! [[ -e /usr/bin/httpx ]];then echo banner; "Faltando pacote httpx para funcionar";exit;else echo "" >/dev/null;fi
}

dep
mkdir ~/SAIDA-$3
cd ~/SAIDA-$3


if [[ -z $4 ]]
then
    banner
    banner2
    exit;
elif [[ $4 == s ]];
then
    echo "Modo Silent"
#    dep
    echo ""
    echo "Servidores Ativos"
    for ii in $(cat $1);do echo $ii | httprobe | sort -u | anew ativos-$3.txt;done
    echo ""
    echo "Enumerando Endpoint"
    for i in $(cat $2);do cat ativos-$3.txt | httpx -silent -title -path "$i" -sc -td | anew resultado-$3.txt;done
elif [[ $4 == n ]];
then
    banner
    echo""
    echo "Modo Normal"
#    dep
    echo ""
    echo "Servidores Ativos"
    for ii in $(cat $1);do echo $ii | httprobe | sort -u | anew ativos-$3.txt;done
    echo ""
    echo "Enumerando Endpoint"
    for i in $(cat $2);do cat ativos-$3.txt | httpx -silent -title -path "$i" -sc -td | anew resultado-$3.txt;done
else
   banner
   banner2
fi
