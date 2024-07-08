# Birthing Suite

For nixos
stow --target /etc .
when pwd = ~/dotfiles/etc

For VSCodium symlink
stow -d VSCodium -t ~/.config/VSCodium/User User
when pwd = ~/dotfiles/.config

For Everything else
stow --target ~/.config .
when pwd = ~/dotfiles/.config
