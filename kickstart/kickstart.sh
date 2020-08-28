#####Ahtapot BSGS Kickstart kurulum öncesi işlemleri kolaylaştırıcı uygulamadır. 
#####kickstart.sh v1.0
#####Yardım için ./kickstart.sh --help

#!/bin/bash
source kickstart.ini
source kickstart.shlib

doNothing=0;
while [ -n "$1" ]; do
    case "$1" in
        -h | --help | h)
            Help
            exit
            ;;
        -i | --info | --information | i)
            echo "Ahtapot BSGS MYS'nin hızlı kurulumu için geliştirilmiş bash scripttir."
            exit;;
        -v | --version | v)
            echo "Ahtapot BSGS hızlı kurulum aracı Kickstart v1.0"
           exit;;
        -n)
            doNothing=1;
            shift
            ;;
        -* | *)
            echo "HATA tanımlanamayan parametre"
            break
                ;;
    esac
done

#####rootkontrol
rootkontrol

####dialoginstall
dialoginstall

#####distupgrade ve update
distupgrade

#####ahtapot ve pardus repoları eklendi
sourceslist_change

#####makina hostname değiştiriliyor
hostname_change

#####ahtapot_mys indirme veya kurulması
#ahtapot_mys_indir
ahtapot_mys_guncel

#####ssh dizini oluşturma
ssh_directory

#####keylerin dizinini oluşturma
keys_directory

#####anahtarların oluşturulması
anahtar_olusturma

#####anahtarların imzalanması
anahtar_imzalama

#####ssh içerisinde id_rsa oluşturulması
id_rsa_create

#####authorized_keys kontrol edin, paylaşılan ssh anahtarlarını ekleyin
authorized_keys_kontrol

#chmod 700 ~/.ssh/authorized_keys
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#echo -e "\e[93m [kickstart : id_rsa anahtarı authorized keys dosyasına eklendi. --[başarılı] ] ********************** \e[0m"
#chmod 400 ~/.ssh/authorized_keys
#chmod 700 ~/.ssh/

machine_reboot

