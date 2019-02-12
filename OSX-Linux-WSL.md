# David's Vim Config

## BASICS 

* on OSX use `brew`, on Windows use WSL (via [wsl-terminal](https://github.com/goreliu/wsl-terminal))
* Clone this repo into `~/.config/nvim`
* Install Vim-Plug
* On OSX, set iTerm2 to use Control key. Set Karabiner to swap command and control for everything _Except_ iTerm/terminal
* On Windows, download [win32yank](https://github.com/equalsraf/win32yank) (the 64-bit version in releases), put it in `wsl-terminal` folder, then [symlink it on the WSL side](https://github.com/neovim/neovim/wiki/FAQ) (yes, symlink an exe from WSL). For example `sudo ln -s /mnt/c/Program\ Files/wsl-terminal/win32yank.exe /usr/bin/win32yank`
* Install Python3 and Pip3
* Install Node/NPM (optionally via nvm)
* Install Yarn
* Run :checkhealth in neovim and resolve all problems (pip install pynvim, npm install neovim)
* Run :UpdateRemotePlugins in vim
* Install `rg` (RipGrep)
* Install `fzf`
* Add to ~/.bash_profile: or ~/.bash_rc: `export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'`

## Compile from source (optional)

1. Download

```
git clone git@github.com:vim/vim.git
```

2. Remove existing

```
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

sudo rm -rf /usr/local/share/vim /usr/bin/vim
```
3. Install libs

```
sudo apt-get install python3-dev liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev
```

4. Checkinstall (optional - didn't use)

```
sudo apt-get install checkinstall
(then maybe run it in vim dir?
```

5. Configure

```
./configure --enable-multibyte --enable-perlinterp=dynamic --enable-rubyinterp=dynamic --with-ruby-command=/usr/bin/ruby --enable-pythoninterp=dynamic --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu --enable-python3interp --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu --enable-luainterp --with-luajit --enable-cscope --enable-gui=auto --with-features=huge --with-x --enable-fontset --enable-largefile --disable-netbeans --with-compiledby="dakom" --enable-fail-if-missing
```

6. Build

```
make
```

7. Install

```
sudo make install
```

DONE!
More tips ([here](https://gist.github.com/odiumediae/3b22d09b62e9acb7788baf6fdbb77cf8)
