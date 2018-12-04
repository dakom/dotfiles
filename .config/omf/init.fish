set fish_user_paths $fish_user_paths "$HOME/.cargo/bin"
set -Ux FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!.git/*\""
bass source /usr/share/nvm/init-nvm.sh 
