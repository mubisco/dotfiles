$USER_NAME=mubisco
declare -a CONFIG_FOLDERS=('rofi', 'nvim', 'phpactor', 'tmux', 'powerline', 'dunst', 'flameshot')
# ==== TMUX PLUGINS INSTALL =====
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# ==== COMPOSER GLOBAL DEPENDENCIES =====
composer global require squizlabs/php_codesniffer
# ==== PYTHON DEPS =====
python3 -m pip install --user --upgrade pynvim jedi dbgp pylint pep8 jedi-language-server flake8 mypy
# ==== CLONE DOTFILES REPO =====
mkdir -p /home/mubisco/Projects
git clone https://github.com/mubisco/dotfiles /home/mubisco/Projects

# ----- USER SECTION -----
mkdir /home/mubisco/.config
cp -rvf /home/mubisco/Projects/dotfiles/config/* /home/mubisco/.config

#ln -s ~/Projects/dotfiles/config/nvim ~/.config/nvim 
#ln -s ~/Projects/dotfiles/config/phpactor ~/.config/phpactor 

cd /home/mubisco
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp -f /home/mubisco/Projects/dotfiles/gitconfig /home/mubisco/.gitconfig

nvim +':PlugInstall --sync' +qa

cd /opt/yay-git
makepkg -si

sudo yay -Sy --noconfirm nerd-fonts-fantasque-sans-mono zsh-syntax-highlighting \
  zsh-autosuggestions zsh-theme-powerlevel10k-git via-bin google-chrome \
  spotify symfony-cli

cp -f /home/mubisco/Projects/dotfiles/zshrc /home/mubisco/.zshrc
source /home/mubisco/.zshrc

echo "Remember to close this console session and run p10k configure"
