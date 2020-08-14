#!/bin/sh

#github desktop
echo adding github desktop public key...
wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo apt-key add -
wait
echo adding desktop repo...
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'
wait
echo installing github desktop...
sudo apt install github-desktop
wait
#install gdebi
echo installing gdebi...
sudo apt install gdebi
wait
#install visual studio code
echo installing vscode via terminal...
wget -O ~/Downloads/code_1.48.0-1597304990_arm64.deb https://code.visualstudio.com/docs/?dv=linux64_deb
sudo gdebi ~/Downloads/code_1.48.0-1597304990_arm64.deb
wait
#install terminus
echo installing terminus via terminal...
wget -O ~/Downloads/tilix_1.7.7-1ubuntu2_amd64.deb http://mirrors.kernel.org/ubuntu/pool/universe/t/tilix/tilix_1.7.7-1ubuntu2_amd64.deb
sudo gdebi ~/Downloads/tilix_1.7.7-1ubuntu2_amd64.deb
wait
echo installing discord canary via terminal...
wget -O ~/Downloads/discord-canary-0.0.105.deb https://discordapp.com/api/download/canary?platform=linux/
sudo gdebi ~/Downloads/discord-canary-0.0.105.deb
#install Figma design studio
echo adding Figma repo...
wait
sudo add-apt-repository ppa:chrdevs/figma
echo updating apt repos...
sudo apt update
echo installing Figma...
sudo apt install figma-linux-beta -y
wait
#install checkra1n
echo adding apt repo
Add our APT repo: echo "deb https://assets.checkra.in/debian /" | sudo tee -a /etc/apt/sources.list
wait
echo adding checkra1n public key
Add our public key: sudo apt-key adv --fetch-keys https://assets.checkra.in/debian/archive.key
wait
echo updating apt repos
sudo apt update
wait
echo installing checkra1n package
sudo apt install checkra1n
wait
#install alva design studio
echo cding into Downloads folder...
cd ~/Downloads
wait
echo correcting permissions to Alva...
chmod a+x ./Alva-0.9.1.AppImage
echo running Alva
./Alva-0.9.1.AppImage