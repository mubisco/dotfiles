$USER_NAME=mubisco
declare -a CONFIG_FOLDERS=('nvim', 'phpactor', 'tmux')
# ==== TMUX PLUGINS INSTALL =====
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ----- USER SECTION -----
echo "Copying files..."
mkdir /home/mubisco/.config
mkdir /home/mubisco/Projects
cd /home/mubisco/Projects
git clone https://github.com/mubisco/dotfiles
cp -rvf /home/mubisco/Projects/dotfiles/config/* /home/mubisco/.config

#ln -s ~/Projects/dotfiles/config/nvim ~/.config/nvim 
#ln -s ~/Projects/dotfiles/config/phpactor ~/.config/phpactor 

cd /home/mubisco
echo "Setting up oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp -f /home/mubisco/Projects/dotfiles/gitconfig /home/mubisco/.gitconfig
composer global require squizlabs/php_codesniffer

echo "Setting up neovim..."
python3 -m pip install --user --upgrade pynvim jedi dbgp pylint pep8 jedi-language-server flake8 mypy
nvim +':PlugInstall --sync' +qa

cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
chown -R mubisco:mubisco ./yay-git
cd yay-git
su mubisco -c "makepkg -si"

sudo yay -Sy --noconfirm nerd-fonts-fantasque-sans-mono zsh-syntax-highlighting \
  zsh-autosuggestions zsh-theme-powerlevel10k-git via-bin google-chrome

cp -f /home/mubisco/Projects/dotfiles/zshrc /home/mubisco/.zshrc
source /home/mubisco/.zshrc

echo "Remember to close this console session and run p10k configure"
