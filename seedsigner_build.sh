#!/bin/sh

# Latest modification: 20211001
# This script is meant to automatically/interactively build SeedSigner
# SD cards while also removing un-needed files/GPG keys.
# Please ensure you are connected to the internet before running this
# script as it will try to update and install dependencies via "apt-get".

# Clear the screen (to make it easier to focus on the build process) and move to the home directory to start.
clear && cd .. && echo "Moved to the home directory and starting the build process..."
sleep 3s

# Enable the camera
echo "Enabling camera..."
sleep 1s
sudo echo "" >> /boot/config.txt
sudo echo "start_x=1" >> /boot/config.txt
sudo echo "gpu_mem=128" >> /boot/config.txt
sleep 2s
if grep -q 'start_x=1\|gpu_mem=128' /boot/config.txt
	then echo "Camera enabled..."
	sleep 3s
	else echo "Error: Camera may not be enabled, please run 'sudo raspi-config' after this script is finished to ensure the camera is enabled..."
	sleep 10s
fi

# Enable SPI
echo "Enabling SPI..."
sleep 1s
sudo sed -i "s/#dtparam=spi=on/dtparam=spi=on/g" /boot/config.txt
if grep -q '#dtparam=spi=on' /boot/config.txt
	then echo "Error: SPI may not be enabled, please run 'sudo raspi-config' after this script is finished to ensure SPI is enabled..."
	sleep 10s
	else echo "SPI enabled..."
	sleep 3s
fi

# Change the localization
echo "Changing localization..."
sleep 1s
echo "Please choose your language prefrence, English [e], French [f], German [g], Italian, [i], Portuguese (European) [pe], Portuguese (Brazilian) [pb], Spanish (Castilian) [sc], Spanish (Mexican) [sm], Spanish (Venezuelan) [sv], Arabic (United Arab Emeriates) [uae], Arabic (Iraq) [ai], Arabic (Saudi Arabian) [asa], Chinese (Hong Kong) [chk], Chinese (Mainland China) [cmc]"
read localvar
if  [ $localvar = e ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# en_US.UTF-8 UTF-8.*/en_US.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# en_US ISO-8859-1.*/en_US ISO-8859-1/g" /etc/locale.gen
	export LANG=en_US.UTF-8
	export LANGUAGE=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
elif [ $localvar = f ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# fr_FR.UTF-8 UTF-8.*/fr_FR.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# fr_FR ISO-8859-1.*/fr_FR ISO-8859-1/g" /etc/locale.gen
	export LANG=fr_FR.UTF-8
	export LANGUAGE=fr_FR.UTF-8
	export LC_ALL=fr_FR.UTF-8
elif [ $localvar = g ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# de_DE.UTF-8 UTF-8.*/de_DE.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# de_DE ISO-8859-1.*/de_DE ISO-8859-1/g" /etc/locale.gen
	export LANG=de_DE.UTF-8
	export LANGUAGE=de_DE.UTF-8
	export LC_ALL=de_DE.UTF-8
elif [ $localvar = i ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# it_IT.UTF-8 UTF-8.*/it_IT.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# it_IT ISO-8859-1.*/it_IT ISO-8859-1/g" /etc/locale.gen
	export LANG=it_IT.UTF-8
	export LANGUAGE=it_IT.UTF-8
	export LC_ALL=it_IT.UTF-8
elif [ $localvar = pe ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# pt_PT.UTF-8 UTF-8.*/pt_PT.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# pt_PT ISO-8859-1.*/pt_PT ISO-8859-1/g" /etc/locale.gen
	export LANG=pt_PT.UTF-8
	export LANGUAGE=pt_PT.UTF-8
	export LC_ALL=pt_PT.UTF-8
elif [ $localvar = pb ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# pt_BR.UTF-8 UTF-8.*/pt_BR.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# pt_BR ISO-8859-1.*/pt_BR ISO-8859-1/g" /etc/locale.gen
	export LANG=pt_BR.UTF-8
	export LANGUAGE=pt_BR.UTF-8
	export LC_ALL=pt_BR.UTF-8
elif [ $localvar = sc ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# es_ES.UTF-8 UTF-8.*/es_ES.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# es_ES ISO-8859-1.*/es_ES ISO-8859-1/g" /etc/locale.gen
	export LANG=es_ES.UTF-8
	export LANGUAGE=es_ES.UTF-8
	export LC_ALL=es_ES.UTF-8
elif [ $localvar = sm ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# es_MX.UTF-8 UTF-8.*/es_MX.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# es_MX ISO-8859-1.*/es_MX ISO-8859-1/g" /etc/locale.gen
	export LANG=es_MX.UTF-8
	export LANGUAGE=es_MX.UTF-8
	export LC_ALL=es_MX.UTF-8
elif [ $localvar = sv ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# es_VE.UTF-8 UTF-8.*/es_VE.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# es_VE ISO-8859-1.*/es_VE ISO-8859-1/g" /etc/locale.gen
	export LANG=es_VE.UTF-8
	export LANGUAGE=es_VE.UTF-8
	export LC_ALL=es_VE.UTF-8
elif [ $localvar = uae ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# ar_AE.UTF-8 UTF-8.*/ar_AE.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# ar_AE ISO-8859-6.*/ar_AE ISO-8859-6/g" /etc/locale.gen
	export LANG=ar_AE.UTF-8
	export LANGUAGE=ar_AE.UTF-8
	export LC_ALL=ar_AE.UTF-8
elif [ $localvar = ai ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# ar_IQ.UTF-8 UTF-8.*/ar_IQ.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# ar_IQ ISO-8859-6.*/ar_IQ ISO-8859-6/g" /etc/locale.gen
	export LANG=ar_IQ.UTF-8
	export LANGUAGE=ar_IQ.UTF-8
	export LC_ALL=ar_IQ.UTF-8
elif [ $localvar = asa ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# ar_SA.UTF-8 UTF-8.*/ar_SA.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# ar_SA ISO-8859-6.*/ar_SA ISO-8859-6/g" /etc/locale.gen
	export LANG=ar_SA.UTF-8
	export LANGUAGE=ar_SA.UTF-8
	export LC_ALL=ar_SA.UTF-8
elif [ $localvar = chk ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# zh_HK.UTF-8 UTF-8.*/zh_HK.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# zh_HK BIG5-HKSCS.*/zh_HK BIG5-HKSCS/g" /etc/locale.gen
	export LANG=zh_HK.UTF-8
	export LANGUAGE=zh_HK.UTF-8
	export LC_ALL=zh_HK.UTF-8
elif [ $localvar = cmc ]
then
	sudo sed -i "s/^en_GB.UTF-8 UTF-8.*/# en_GB.UTF-8 UTF-8/g" /etc/locale.gen
	sudo sed -i "s/^# zh_CN.UTF-8 UTF-8.*/zh_CN.UTF-8 UTF-8/g" /etc/locale.gen
	#sudo sed -i "s/^# zh_CN.GBK GBK.*/zh_CN.GBK GBK/g" /etc/locale.gen
	export LANG=zh_CN.UTF-8
	export LANGUAGE=zh_CN.UTF-8
	export LC_ALL=zh_CN.UTF-8
else echo "failed to set the locale, please run 'sudo raspi-config' after this script is finished to set the locale..."
sleep 10s
fi
sudo locale-gen && echo "Localization changed..."
sleep 3s

# This removes unnecessary code and gpg key.
# https://www.reddit.com/r/linux/comments/1bu0t1/microsoft_repo_installed_on_all_raspberry_pis/
echo "Removing Microsoft code and GPG key..."
sleep 1s
sudo rm -f -v /etc/apt/sources.list.d/vscode.list
sudo rm -f -v /etc/apt/trusted.gpg.d/microsoft.gpg

# Update and install dependencies.
echo "Updating and installing dependencies..."
sleep 2s
u=0
until [ "$u" -ge 5 ]
do sudo apt-get update && break && echo "Updated..."
u=$((u+1))
sleep 10s
done

# Download the dependencies, until the variable is equal to or greater than 5.

echo "Installing wiringpi..."
sleep 2s
a=0
until [ "$a" -ge 5 ]
do sudo apt-get install -y wiringpi && break
a=$((a+1))
sleep 10s
done
echo "Done..."

echo "Installing python3-pip..."
sleep 2s
b=0
until [ "$b" -ge 5 ]
do sudo apt-get install -y python3-pip && break
b=$((b+1))
sleep 10s
done
echo "Done..."

echo "Installing python3-numpy..."
sleep 2s
c=0
until [ "$c" -ge 5 ]
do sudo apt-get install -y python3-numpy && break
c=$((c+1))
sleep 10s
done
echo "Done..."

echo "Installing python-pil..."
sleep 2s
d=0
until [ "$d" -ge 5 ]
do sudo apt-get install -y python-pil && break
d=$((d+1))
sleep 10s
done
echo "Done..."

echo "Installing libopenjp2-7..."
sleep 2s
e=0
until [ "$e" -ge 5 ]
do sudo apt-get install -y libopenjp2-7 && break
e=$((e+1))
sleep 10s
done
echo "Done..."

echo "Installing ttf-mscorefonts-installer..."
sleep 2s
f=0
until [ "$f" -ge 5 ]
do sudo apt-get install -y ttf-mscorefonts-installer && break
f=$((f+1))
sleep 10s
done
echo "Done..."

echo "Installing git..."
sleep 2s
g=0
until [ "$g" -ge 5 ]
do sudo apt-get install -y git && break
g=$((g+1))
sleep 10s
done
echo "Done..."

echo "Installing python3-opencv..."
sleep 2s
h=0
until [ "$h" -ge 5 ]
do sudo apt-get install -y python3-opencv && break
h=$((h+1))
sleep 10s
done
echo "Done..."

echo "Installing libzbar0..."
sleep 2s
i=0
until [ "$i" -ge 5 ]
do sudo apt-get install -y libzbar0 && break
i=$((i+1))
sleep 10s
done
echo "Done..."

echo "Installing python3-picamera..."
sleep 2s
j=0
until [ "$j" -ge 5 ]
do sudo apt-get install -y python3-picamera && break
j=$((j+1))
sleep 10s
done
echo "Done..."

echo "Installing libatlas-base-dev..."
sleep 2s
k=0
until [ "$k" -ge 5 ]
do sudo apt-get install -y libatlas-base-dev && break
k=$((k+1))
sleep 10s
done
echo "Done..."

echo "Installing qrencode..."
sleep 2s
l=0
until [ "$l" -ge 5 ]
do sudo apt-get install -y qrencode && break
l=$((l+1))
sleep 10s
done
echo "Done..."

echo "Dependencies installed..."
sleep 3s

# Install the C library for Broadcom BCM 2835.
echo "Installing the C library for Broadcom BCM 2835..."
sleep 2s

m=0
until [ "$m" -ge 5 ]
do wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz && break
m=$((m+1))
sleep 10s
done
echo "Library downloaded..."
sleep 3s

n=0
until [ "$n" -ge 5 ]
do tar zxvf bcm2835-1.60.tar.gz && break
n=$((n+1))
sleep 10s
done

echo "configuring..."
sleep 1s
cd bcm2835-1.60/ && sudo ./configure
sleep 3s
sudo make && sudo make check && sudo make install && echo "Library installed..."
sleep 2s
cd .. && echo "Removing the bcm2835 tar file..."
sleep 2s
sudo rm -v bcm2835-1.60.tar.gz
sleep 2s

# Set up Virtaul env.
o=0
echo "Setting up a virtual env..."
sleep 1s
until [ "$o" -ge 5 ]
do sudo pip3 install virtualenvwrapper && break
o=$((o+1))
sleep 10s
done
sleep 2s
echo '' >> /home/pi/.profile && echo 'export WORKON_HOME=$HOME/.envs' >> /home/pi/.profile && echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3' >> /home/pi/.profile && echo 'source /home/pi/.local/bin/virtualenvwrapper.sh' >> /home/pi/.profile && echo "Virtual env. set up..."
sleep 3s

# Create the virtual env.
p=0
echo "Creating the virtual env..."
sleep 1s
until [ "$p" -ge 5 ]
do source ~/home/pi/.profile
sleep 2s
mkvirtualenv --python=python3 seedsigner-env && break && echo "Created the Virtual env..."
p=$((p+1))
sleep 10s
done
sleep 3s

# Download SeedSigner.
echo "Downloading SeedSigner..."
sleep 1s
git clone https://github.com/SeedSigner/seedsigner && echo "SeedSigner software downloaded..."
sleep 3s

# Install SeedSigner python dependencies.
echo "Installing SeedSigner Python dependencies..."
sleep 1s
cd seedsigner && echo "Changed to SeedSigner dir..."
sleep 2s
sudo pip3 install -r requirements.txt && echo "Dependencies installed..."

# Configure system to run at boot.
echo "Configuring system to run at boot..."
sleep 1s
#cd /etc/systemd/system/
#touch seedsigner.service
echo '[Unit]' >> /etc/systemd/system/seedsigner.service
echo 'Description=SeedSigner' >> /etc/systemd/system/seedsigner.service
echo '' >> /etc/systemd/system/seedsigner.service
echo '[Service]' >> /etc/systemd/system/seedsigner.service
echo 'User=pi' >> /etc/systemd/system/seedsigner.service
echo 'WorkingDirectory=/home/pi/seedsigner/src/' >> /etc/systemd/system/seedsigner.service
echo 'ExecStart=/usr/bin/python3 main.py' >> /etc/systemd/system/seedsigner.service
echo 'Restart=always' >> /etc/systemd/system/seedsigner.service
echo '' >> /etc/systemd/system/seedsigner.service
echo '[Install]' >> /etc/systemd/system/seedsigner.service
echo 'WantedBy=multi-user.target' >> /etc/systemd/system/seedsigner.service
cd && echo "System configured to run at boot..."
sleep 3s

# Enable the SeedSigner service on boot.
echo "Enabling the SeedSigner service on boot..."
sleep 1s
sudo systemctl enable seedsigner.service
sleep 2s

# Check to see that the seedsigner service is running.
if systemctl is-active seedsigner.service
then
	echo "SeedSigner service is enabled..."
	sleep 2s
else
	echo "Service may not be enabled..."
	sleep 3s
fi

# (Optional) modify system swap config to disable virtual memory.
echo "Disabling virtual memory..."
sleep 1s
sudo sed -i "s/CONF_SWAPSIZE=100/CONF_SWAPSIZE=0/g" /etc/dphys-swapfile && echo "Virtual memory disabled..."
sleep 3s

# (Optional) Change the User password.
#echo "Change the user password..."
#sleep 2s
#passwd

# Reboot options.
echo "If working on a seperate RPI please enter [1], if on the device you plan to use for your SeedSigner please enter [0]" 
read powervar

if [ $powervar = 1 ]
then
	sudo shutdown --poweroff now
else
	echo "Rebooting..."
	sleep 2s
	sudo reboot
fi
exit
