# David's Vim Config

## BASICS 

* on OSX use `brew`, on Windows use WSL (via [wsl-terminal](https://github.com/goreliu/wsl-terminal))
* Clone this repo into `~/.config/nvim`
* Install Vim-Plug
* On OSX, set iTerm2 to use Control key. Set Karabiner to swap command and control for everything _Except_ iTerm/terminal
* On Windows, download [win32yank](https://github.com/equalsraf/win32yank) (the 64-bit version in releases), put it in `wsl-terminal` folder, then [symlink it on the WSL side](https://github.com/neovim/neovim/wiki/FAQ) (yes, symlink an exe from WSL). For example `sudo ln -s /mnt/c/Program\ Files/wsl-terminal/win32yank.exe /usr/bin/win32yank`
* Install Python3 and Pip3
* Install Node/NPM (optionally via nvm)
* NPM Install neovim, typescript, purescript, pulp, javascript-typescript-langserver, purescript-language-server (via npm)
* Run :checkhealth in neovim and resolve all problems
* Install psc-package (either via https://www.npmjs.com/package/psc-package-bin-simple or releases of regular package, not npm as of right now since it was deprecated)
* Run `./install.sh` inside the typescript plugin folder (~/.local/share/nvim/plugged/nvim-typescript)
* Run :UpdateRemotePlugins in vim
* Install `rg` (RipGrep)
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

## Windows Host (for GUI on Windows side)

**Overview**
* gvim is installed via custom build
* This repo is `~/vimfiles`
* `$MYVIMRC` is `~/_vimrc` which is a shim to load `~/vimfiles/vimrc`

**Instructions**

1a. Install via the zip containing the 64 bit version from [here](https://github.com/vim/vim-win32-installer/releases)
1b. Alternatively, install from [here](https://bintray.com/micbou/generic/vim) rather than the offical releases (currently this one is 64-bit and has the required Python compilation flags etc.)

2. Follow the same instructions as above, but substitute `~/vimfiles` for `~/.vim` and `~/_vimrc` for `~/.vimrc`

3. Note that the Python version on the system most match both in terms of version and architecture. For the version, look in `:version` from vim and find a line like **DDYNAMIC_PYTHON3_DLL=\"python36.dll\"** which tells us that it's Python 3.6. For architecture, make sure to choose 64-bit like the vim installer above. 

4. Run installer.exe in the official release to add "edit with vim" on individual files. Be careful to set "no" to the superfulous installer options

5. If "open gvim here" via context menu isn't there - save the following in a `.reg` and run it:

```

Windows Registry Editor Version 5.00


[HKEY_CLASSES_ROOT\Directory\Background\shell\Vim]
@="Open Gvim here"
"Extended"=-

[HKEY_CLASSES_ROOT\Directory\Background\shell\Vim\command]
@="C:\\Program Files\\Vim\\vim81\\gvim.exe \"%1""

[HKEY_CLASSES_ROOT\Directory\shell\Vim]
@="Open Gvim here"
"Extended"=-

[HKEY_CLASSES_ROOT\Directory\shell\Vim\command]
@="C:\\Program Files\\Vim\\vim81\\gvim.exe \"%1""

[HKEY_CLASSES_ROOT\Drive\shell\Vim]
@="Open Gvim here"
"Extended"=-

[HKEY_CLASSES_ROOT\Drive\shell\Vim\command]
@="C:\\Program Files\\Vim\\vim81\\gvim.exe \"%1""

[HKEY_CLASSES_ROOT\LibraryFolder\Background\shell\Vim]
@="Open Gvim here"
"Extended"=-

[HKEY_CLASSES_ROOT\LibraryFolder\Background\shell\Vim\command]
@="C:\\Program Files\\Vim\\vim81\\gvim.exe \"%1""
```
