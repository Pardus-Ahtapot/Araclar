#!/bin/bash

#kickstart.sh version0.1
#Sunucu_ismi_değiştirme
hostname=$(cat /etc/hostname)
echo "Sunucu adınız: $hostname"

#read -r -p "Sunucu adınızı değiştirmek istediğinizden emin  misiniz? [E/H] " cevap
echo -n "Sunucu adınızı değiştirmek istiyor musunuz? (e/h)? "
read cevap
	if [ ! "$cevap" = "${cevap#[Hh]}" ] ;then
		echo "Sunucu adınız: $hostname"
	else
                echo "Yeni sunucu adınızı giriniz: "
                read newhostname
                sudo sed -i "s/$hostname/$newhostname/g" /etc/hosts
                sudo sed -i "s/$hostname/$newhostname/g" /etc/hostname
                echo "Yeni sunucu adınız: $newhostname"
	fi
#read -s -n  -p "Sunucuyu yeniden başlatmak için bir tuşa basınız."
#sudo reboot
#set -e

#ahtapot-mys paketinin insdirilmesi
sudo apt-get download ahtapot-mys
sudo apt install ./ahtapot-mys*
#sudo apt-get install ahtapot-mys

#.ssh_dizin_kontrol
if [ ! -d ~/.ssh2 ]; then
	mkdir -p ~/.ssh2/
fi

#anahtarlar dizin kontrol
if [ ! -d ~/anahtarlar ]; then
	mkdir -p ~/anahtarlar/
fi

echo "Uzaktan bağlantı için gerekli anahtarlarınız oluşturuluyor..."
#anahtarların oluşturulması
ssh-keygen -f ahtapotops -N "" -f ~/anahtarlar/ahtapotops
ssh-keygen -f ahtapot_ca -N "" -f ~/anahtarlar/ahtapot_ca
ssh-keygen -f git -N "" -f ~/anahtarlar/git
ssh-keygen -f myshook -N "" -f ~/anahtarlar/myshook
ssh-keygen -f gdyshook -N "" -f ~/anahtarlar/gdyshook
ssh-keygen -f fw_kullanici -N "" -f ~/anahtarlar/fw_kullanici
echo "ssh-keygen ile anahtarlar oluşturuldu. --[başarılı]"

#anahtarların imzalanması
ssh-keygen -s ~/anahtarlar/ahtapot_ca -I ahtapotops@ahtapot.com -n ahtapotops -O no-agent-forwarding -O no-port-forwarding -O no-x11-forwarding ~/anahtarlar/ahtapotops.pub
ssh-keygen -s ~/anahtarlar/ahtapot_ca -I ahtapotops@ahtapot.com -n ahtapotops -O no-agent-forwarding -O no-port-forwarding -O no-x11-forwarding ~/anahtarlar/git.pub
ssh-keygen -s ~/anahtarlar/ahtapot_ca -I ahtapotops@ahtapot.com -n ahtapotops -O permit-port-forwarding -O permit-x11-forwarding -O force-command="/var/opt/gdysgui/gdys-gui.py" ~/anahtarlar/fw_kullanici.pub
ssh-keygen -s ~/anahtarlar/ahtapot_ca -I ahtapotops@ahtapot.com -n ahtapotops -O no-port-forwarding -O no-x11-forwarding -O force-command="sudo touch /var/run/firewall" ~/anahtarlar/gdyshook.pub
ssh-keygen -s ~/anahtarlar/ahtapot_ca -I ahtapotops@ahtapot.com -n ahtapotops -O no-port-forwarding -O no-x11-forwarding -O force-command="sudo touch /var/run/state" ~/anahtarlar/myshook.pub
echo "ssh-keygen ile ahtapot_ca tarafından anahtarlar imzalandı --[başarılı]"

if [ ! -f ~/.ssh2/id_rsa.pub ]; then
#        ssh-keygen -t rsa -N "" -f ~/.ssh2/id_rsa
# 	ssh-keygen -f ahtapotops -N "" -f ~/.ssh2/id_rsa
	cp ~/anahtarlar/ahtapotops ~/.ssh2/id_rsa
	cp ~/anahtarlar/ahtapotops.pub ~/.ssh2/id_rsa.pub
#        echo "ssh-keygen çalıştırıldı --[başarılı]"
fi

#authorized_keys kontrol edin, paylaşılan ssh anahtarlarını ekleyin
if [ ! -f ~/.ssh2/authorized_keys ]; then
        touch ~/.ssh2/authorized_keys
        echo " ~/.ssh/authorized_keys dosyası oluşturuldu. --[başarılı]"
fi
chmod 700 ~/.ssh2/authorized_keys
cat ~/.ssh2/id_rsa.pub >> ~/.ssh2/authorized_keys
echo "id_rsa anahtarı authorized keys dosyasına eklendi. --[başarılı]"
chmod 400 ~/.ssh2/authorized_keys
chmod 700 ~/.ssh2/

set +e
read -s -n -p "Makinanızı yeniden başlatmak için bir tuşa basınız."
#read -p "Makinanızı yeniden başlatmak için bir tuşa basınız."
sudo reboot
