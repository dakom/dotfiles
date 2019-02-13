## TODO (nice to haves)

* Get powershell (and hence alacritty?) to work with proper unicode
* be able to cd ~/links/project/etc.
* Get ligatures and true color working nicely in Alacritty (e.g. to open nvim)

## Steps

**Install core things w/o Chocolatey** 
* Dropbox
* Adobe Cloud, 
* Chocolatey itself
* drivers


**Install things w/ Chocolatey**
* Chrome
* git
* poshgit
* neovim
* node
* yarn
* python
* pip
* slack
* vlc
* fzf
* ripgrep
* nodepad++

**Install things not on Chocolatey yet**
* Alacritty

**Alacritty config**
* Manually put in Program Files\Alacritty
* Manually add path to environment
* copy contents from [windows-files/alacritty/alacritty.yml] to the destination (~\AppData\Roaming\alacritty\alacritty.yml - not part of dotfiles yet, see https://github.com/jwilm/alacritty/issues/2108)
* Merge [windows-files/alacritty/install-alacritty-neovim-context.reg] to get context menus

**Powershell config**
* Copy [windows-files/powershell-profile.ps1] to $PROFILE (e.g. ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1)

**Oh-My-Posh config**
* copy [windows-files/oh-my-posh/David.psm1] to $ThemeSettings.MyThemesLocation (e.g. C:\Program Files\WindowsPowerShell\Modules\oh-my-posh\2.0.245\Themes)

**SSH Config**
* Add SSH keys: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
* Make sure SSH is all good (might only need to add passphrase once for ssh agent?)
* Set ssh-agent to start manually... I think, might need to double-check that

**Git config**
* Do the following:
```
git config --global user.email "your@email.com"
git config --global user.name "Your Name"
git config --global push.default simple
git config --global core.ignorecase false
# The above are generic, the following are strictly windows-only
git config --global core.sshCommand "'C:\WINDOWS\System32\OpenSSH\ssh.exe'"
git config --global core.autocrlf true
git config --global core.editor "C:\\tools\\neovim\\Neovim\\bin\\nvim-qt.exe"
```

**Clone this repo to ~/dotfiles**
* cd ~/
* git clone git@github.com:dakom/dotfiles.git
* Set environment variable `XDG_CONFIG_HOME = ~/dotfiles/.config` (probably use windows path e.g. C:\Users\David\dotfiles\.config)

**Neovim config**
* pip install pynvim
* npm install -g neovim
* merge [windows-files/neovim/install-neovim-context.reg] to get the context menus
* Install all the Neoclide extensions via `:CocInstall` e.g. `:CocInstall coc-json coc-css coc-tsserver coc-rls coc-yaml`
* add environment var: `FZF_DEFAULT_COMMAND` to `'rg --files --hidden --glob "!.git/*"'`

**Setup key mapping**
* use SharpKeys

## References

**Chocolatey**
* https://github.com/felixrieseberg/windows-development-environment

**Posh-git**
* https://github.com/dahlbyk/posh-git/issues/583#issuecomment-402711469

**More git + powershell stuff**
* https://hodgkins.io/ultimate-powershell-prompt-and-git-setup#posh-git-and-ssh-agent
* https://blog.frankfu.com.au/2018/12/15/ssh-on-windows-10-1803/
* https://taraksharma.com/supercharging-powershell-with-hyper-oh-my-posh-posh-git/

**Fonts**
* https://github.com/ryanoasis/nerd-fonts
(used FiraCode... or was it FiraCode mono retina something or other)