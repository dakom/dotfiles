# Symbolic Links vs. Shortcuts

Note that windows shortcuts are not symlinks!

To create symlinks, use `mklink` (available in elevated command prompt, not powershell, or enabled via dev tools, see https://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/)

Everything is a bit disorganized, and more like latest notes. e.g. now that Windows Terminal is a thing all the ConEMU stuff isn't relevent - but is still maintained below as a reference.


# New Notes

## Media Creation Tools

https://www.microsoft.com/en-us/software-download/windows10

Scroll down (Download Tool Now - not Update Now)

## Git config
* Do the following:
```
git config --global user.email "your@email.com"
git config --global user.name "Your Name"
git config --global push.default simple
git config --global core.ignorecase false
# The above are generic, the following are strictly windows-only
git config --global core.sshCommand "'C:\WINDOWS\System32\OpenSSH\ssh.exe'"
git config --global core.autocrlf true
config --global core.editor "'C:/Program Files/Neovim/bin/nvim-qt.exe'"
```


## SSH

(these steps might not be necessary anymore...)

1.  Add SSH keys: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
2. Set ssh-agent to start automatically (in windows services: OpenSSH agent)
3. Make sure SSH is all good (might only need to add passphrase once for ssh agent?)

## Config
1. Clone this repo to `~/dotfiles`
2. cd ~/
3. git clone git@github.com:dakom/dotfiles.git
4. Set environment variable `XDG_CONFIG_HOME = ~/dotfiles/.config` (probably use windows path e.g. C:\Users\David\dotfiles\.config)

## Fonts
* https://github.com/ryanoasis/nerd-fonts (firacode)


## Terminal / Powershell / etc.

1. Install Windows Terminal from the [Store](https://aka.ms/terminal)
2. Install PowerShell 7 from [Github releases](https://github.com/PowerShell/PowerShell/releases) (artifacts/msi)
3. UseFileMenu Tools or install [context menus](https://github.com/lextm/windowsterminal-shell) (might need to manually launch powershell 7 and install from there first)
4. Copy/paste [windows-files/terminal/settings.json]
5. Install posh-git and oh-my-posh
   * `Install-Module posh-git -Scope CurrentUser`
   * `Install-Module oh-my-posh -Scope CurrentUser`
6. Set profiles.defaults.fontFace to "FuraCode Nerd Font" in Terminal settings.json
7. Copy [windows-files/powershell/Microsoft.PowerShell_profile.ps1](windows-files/powershell/Microsoft.PowerShell_profile.ps1) to $PROFILE (e.g. ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1)
8. Copy [windows-files/oh-my-posh/David.psm1](windows-files/oh-my-posh/David.psm1) to $ThemeSettings.MyThemesLocation (e.g. C:\Program Files\PowerShell\Modules\oh-my-posh\2.0.245\Themes)
   * if weird stuff - make sure the theme and powershell profile are saved to utf-8 w/ bom (use notepad++)

## FileMenu Tools

This is a paid app.. import [windows-files/filemenu/filemenu-tools.ini]

## Setup key mapping
1. use SharpKeys - import [windows-files/sharp-keys/sharp-keys.skl]

## Paid Windows Extensions
1. Groupy: https://www.stardock.com/products/groupy/
2. FileMenu Tools

## Free Windows Extensions
1. DnGrep: http://dngrep.github.io/

## Vim

1. Install neovim
2. Install neovide: https://github.com/Kethku/neovide (perhaps build first - by installing CMake and LLVM and putting those in the path)
3. Copy neovide to neovim bin folder (and put it on path)
4. note plugin directory is ~/.local/share/nvim/plugged
5. pip install pynvim
6. npm install -g neovim
7. add environment var: `FZF_DEFAULT_COMMAND` to `'rg --files --hidden --glob "!.git/*"'`
8. Neoclide - https://github.com/neoclide/coc.nvim
9. :CocInstall coc-json coc-css coc-tsserver coc-rust-analyzer coc-yaml


## VSCode

1. symlink (not shortcut!) settings.json and keybindings.json in vscode/ to their equivilents in %APPDATA%\Code\User

## Python

1. Install python 3
2. install pip (via choco? winget?)
3. If problems - try renaming python37\python.exe to python3.exe
4. try installing pip locally through there and get-pip.py (available in web search)

## OpenSSL

1. visit https://slproweb.com/products/Win32OpenSSL.html (yes, the site says win32 but it has win64 msi)
2. after installing, add C:\Program Files\OpenSSL-Win64\bin to path
3. add C:\Program Files\OpenSSL-Win64 to OPENSSL_DIR env var

## Postgres
  1. install via the regular installer
  2. make sure that both of the postgres `bin` and `lib` dirs are on the PATH

If just using this for client libs (not for server, i.e. planning to use docker) make sure to manually disable the service at startup.

Otherwise there will be a port conflict [and it might not even show up in logs](https://github.com/sameersbn/docker-postgresql/issues/112#issuecomment-579712540)

# Other apps

1. Always try to first search via `winget search [name]` and install there. 
2. If there's a naming conflict, use `--exact`
3. As a last resort - separate installers

----
# Old Reference
## Steps

**Install core things w/o Chocolatey** 
* Terminal / PowerShell
* Chocolatey itself
* Office
* Adobe Cloud
* Nvidia GameReady
* Dropbox
* oh-my-posh (maybe poshgit module too even though it's also on choco?)
* SharpKeys: https://github.com/randyrants/sharpkeys/releases
* Rust (and C++ windows build tools as a pre-requisite)
* other drivers

**Install things w/ Chocolatey**
* ConEmu
* Chrome
* git
* poshgit
* neovim
* node (nodejs.install)
* yarn
* python
* python2
* pip
* slack
* gitter
* vlc
* fzf
* ripgrep
* nodepad++
* gcloudsdk (might need python2 to be higher in path??)

**Install things w/ npm**
* npm-upgrade
* firebase-tools

**ConEmu config**
* Set to use powershell
* Change powershell launch config to powershell.exe -NoLogo
* Change theme to Babun
* ConEmu.xml is here in [windows-files/conemu](windows-files/conemu)
* Use ConEmu settings -> Integration to register context menu
  * {powershell} -cur_console:n



**Neovim config**





## References

**Chocolatey**
* https://github.com/felixrieseberg/windows-development-environment

**Posh-git**
* https://github.com/dahlbyk/posh-git/issues/583#issuecomment-402711469

**More git + powershell stuff**
* https://hodgkins.io/ultimate-powershell-prompt-and-git-setup#posh-git-and-ssh-agent
* https://blog.frankfu.com.au/2018/12/15/ssh-on-windows-10-1803/
* https://taraksharma.com/supercharging-powershell-with-hyper-oh-my-posh-posh-git/

