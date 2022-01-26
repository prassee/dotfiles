function linkFiles
    ln -s -f -n /data/sysConfigs/projectile ~/.projectile
    ln -s -f -n /data/sysConfigs/gitconfig ~/.gitconfig
    ln -s -f -n /data/sysConfigs/gitignore ~/.gitignore
    sudo ln -s -f -n /data/sysConfigs/hosts  /etc/hosts
    sudo ln -s -f -n /data/sysConfigs/xorg.conf /etc/X11/xorg.conf
    ln -s -f -n /data/sysConfigs/tmux.conf ~/.tmux.conf
    ln -s -f -n /data/sysConfigs/auto.properties ~/.freemind/auto.properties
    ln -s -f -n /data/sysConfigs/Xresources ~/.Xresources
    ln -s -f -n /data/sysConfigs/zathurarc ~/.config/zathura/zathurarc
    ln -s -f -n /data/sysConfigs/leafpadrc ~/.config/leafpad/leafpadrc
    ln -s -f -n /data/sysConfigs/pcmanfm.conf ~/.config/pcmanfm/default/pcmanfm.conf
    ln -s -f -n /data/sysConfigs/dunstrc ~/.config/dunst/dunstrc
    ln -s -f -n /data/sysConfigs/config.fish ~/.config/fish/config.fish
    ln -s -f -n /data/sysConfigs/ssh ~/.ssh
    mv ~/.emacs.d/elpa /tmp/
    rm -rf ~/.emacs.d
    mkdir ~/.emacs.d
    mv /tmp/elpa ~/.emacs.d/
    ln -s -f -n /data/sysConfigs/init.el ~/.emacs.d/init.el
    ln -s -f -n /data/sysConfigs/lisp ~/.emacs.d/lisp
    ln -s -f -n /data/sysConfigs/persistent-scratch ~/.emacs.d/.persistent-scratch
    ln -s -f -n /data/sysConfigs/i3 ~/.config/i3
end
