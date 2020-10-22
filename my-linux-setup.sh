#!/bin/bash
# Viviane's Development Machine Setup on PopOS
# Author: Viviane Dias

sudo apt update

# Installing build essentials
sudo apt install -y build-essential libssl-dev

# Installing vscode and my main extensions
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg
echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium
cat extensions.txt | xargs -L 1 codium --install-extension

# Install chromium browser
sudo apt install --assume-yes chromium-browser

# Install telegram 
sudo add-apt-repository ppa:atareao/telegram
sudo apt update
sudo apt install telegram

# Install slack
# sudo snap install slack --classic

# Install node version manager (nvm) with latest and lts versions
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node
nvm install --lts

# Install pnpm (package manager) 
nvm use node
npm -g i pnpm
nvm use --lts
npm -g i pnpm

# Unninstall old versions of docker
sudo apt-get remove docker docker-engine docker.io containerd runc

# Setup docker repository
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install docker engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Manage docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Setup terminal with zsh and oh-my-zsh
sudo apt install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install powerlevel10k theme
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k 

# Config zshrc with powerlevel10k theme
cat zshrc-config.txt >> ~/.zshrc

# Install Vim, curl and tilix 
sudo apt-get install -y vim curl tilix