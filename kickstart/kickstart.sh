#!/bin/bash
source kickstart.ini
source kickstart.shlib

#####distupgrade ve update
distupgrade
sleep 2

#####ahtapot ve pardus repoları eklendi
sourceslist_change
sleep 2

#####makina hostname değiştiriliyor
hostname_change
sleep 2

#####ahtapot_mys indirme veya kurulması
#ahtapot_mys_indir
ahtapot_mys_guncel
sleep 2

#####ssh dizini oluşturma
ssh_directory
sleep 2

#####keylerin dizinini oluşturma
keys_directory
sleep 2

#####anahtarların oluşturulması
anahtar_olusturma
sleep 2

#####anahtarların imzalanması
anahtar_imzalama
sleep 3

#####ssh içerisinde id_rsa oluşturulması
id_rsa_create
sleep 2

#####authorized_keys kontrol edin, paylaşılan ssh anahtarlarını ekleyin
authorized_keys_kontrol
sleep 2

#chmod 700 ~/.ssh/authorized_keys
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#echo -e "\e[93m [kickstart : id_rsa anahtarı authorized keys dosyasına eklendi. --[başarılı] ] ********************** \e[0m"
#chmod 400 ~/.ssh/authorized_keys
#chmod 700 ~/.ssh/

machine_reboot

