#!/bin/bash
source kickstart.ini
source kickstart.shlib

hostname_change
sleep 2
#set -e

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
echo "Uzaktan bağlantı için gerekli anahtarlarınız oluşturuluyor."
anahtar_olusturma
sleep 2

#####anahtarların imzalanması
anahtar_imzalama
sleep 3

#####ssh içerisinde id_rsa oluşturulması
id_rsa_create
sleep 2
#authorized_keys kontrol edin, paylaşılan ssh anahtarlarını ekleyin
authorized_keys_kontrol
sleep 2
chmod 700 ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
echo "id_rsa anahtarı authorized keys dosyasına eklendi. --[başarılı]"
chmod 400 ~/.ssh/authorized_keys
chmod 700 ~/.ssh/
#set +e
#####makina_reboot
machine_reboot
#read -s -n -p "Makinanızı yeniden başlatmak için bir tuşa basınız."
#read -p "Makinanızı yeniden başlatmak için bir tuşa basınız."
#sudo reboot
