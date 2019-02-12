## TODO (nice to haves)

* ✡️ in the prompt (see https://github.com/JanDeDobbeleer/oh-my-posh/issues/128)
* be able to cd ~/links/project/etc.
* Get ligatures and true color working nicely in Alacritty

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
* Manually add path
* Change font in alacritty.yml (~\AppData\Roaming\alacritty\alacritty.yml - not part of dotfiles yet, see https://github.com/jwilm/alacritty/issues/2108)
* Merge supplied `install-alacritty-neovim-context.reg` to get context menus

**Powershell config**
* notepad++ $PROFILE
* add config below

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
```
* Add SSH keys: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
* Make sure SSH is all good (might only need to add passphrase once for ssh agent?)

**Clone this repo to ~/dotfiles**
* cd ~/
* git clone git@github.com:dakom/dotfiles.git

**nvim config**
* Set environment variable `XDG_CONFIG_HOME = ~/dotfiles/.config` (probably use windows path e.g. C:\Users\David\dotfiles\.config)
* pip install pynvim
* npm install -g neovim
* merge the included `install-neovim-context.reg` to get the context menus
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


## powershell profile

```
# Increase history
$MaximumHistoryCount = 10000

# Produce UTF-8 by default
$PSDefaultParameterValues["Out-File:Encoding"]="utf8"

$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Show selection menu for tab
Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete


# Helper Functions
#######################################################

function uptime {
	Get-WmiObject win32_operatingsystem | select csname, @{LABEL='LastBootUpTime';
	EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
}

function reload-profile {
	& $profile
}

function find-file($name) {
	ls -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | foreach {
		$place_path = $_.directory
		echo "${place_path}\${_}"
	}
}

function print-path {
	($Env:Path).Split(";")
}

function unzip ($file) {
	$dirname = (Get-Item $file).Basename
	echo("Extracting", $file, "to", $dirname)
	New-Item -Force -ItemType directory -Path $dirname
	expand-archive $file -OutputPath $dirname -ShowProgress
}


# Unixlike commands
#######################################################

function df {
	get-volume
}

function sed($file, $find, $replace){
	(Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function sed-recursive($filePattern, $find, $replace) {
	$files = ls . "$filePattern" -rec
	foreach ($file in $files) {
		(Get-Content $file.PSPath) |
		Foreach-Object { $_ -replace "$find", "$replace" } |
		Set-Content $file.PSPath
	}
}

function grep($regex, $dir) {
	if ( $dir ) {
		ls $dir | select-string $regex
		return
	}
	$input | select-string $regex
}

function grepv($regex) {
	$input | ? { !$_.Contains($regex) }
}

function which($name) {
	Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value) {
	set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
	ps $name -ErrorAction SilentlyContinue | kill
}

function pgrep($name) {
	ps $name
}

function touch($file) {
	"" | Out-File $file -Encoding ASCII
}

function sudo {
	$file, [string]$arguments = $args;
	$psi = new-object System.Diagnostics.ProcessStartInfo $file;
	$psi.Arguments = $arguments;
	$psi.Verb = "runas";
	$psi.WorkingDirectory = get-location;
	[System.Diagnostics.Process]::Start($psi) >> $null
}

# https://gist.github.com/aroben/5542538
function pstree {
	$ProcessesById = @{}
	foreach ($Process in (Get-WMIObject -Class Win32_Process)) {
		$ProcessesById[$Process.ProcessId] = $Process
	}

	$ProcessesWithoutParents = @()
	$ProcessesByParent = @{}
	foreach ($Pair in $ProcessesById.GetEnumerator()) {
		$Process = $Pair.Value

		if (($Process.ParentProcessId -eq 0) -or !$ProcessesById.ContainsKey($Process.ParentProcessId)) {
			$ProcessesWithoutParents += $Process
			continue
		}

		if (!$ProcessesByParent.ContainsKey($Process.ParentProcessId)) {
			$ProcessesByParent[$Process.ParentProcessId] = @()
		}
		$Siblings = $ProcessesByParent[$Process.ParentProcessId]
		$Siblings += $Process
		$ProcessesByParent[$Process.ParentProcessId] = $Siblings
	}

	function Show-ProcessTree([UInt32]$ProcessId, $IndentLevel) {
		$Process = $ProcessesById[$ProcessId]
		$Indent = " " * $IndentLevel
		if ($Process.CommandLine) {
			$Description = $Process.CommandLine
		} else {
			$Description = $Process.Caption
		}

		Write-Output ("{0,6}{1} {2}" -f $Process.ProcessId, $Indent, $Description)
		foreach ($Child in ($ProcessesByParent[$ProcessId] | Sort-Object CreationDate)) {
			Show-ProcessTree $Child.ProcessId ($IndentLevel + 4)
		}
	}

	Write-Output ("{0,6} {1}" -f "PID", "Command Line")
	Write-Output ("{0,6} {1}" -f "---", "------------")

	foreach ($Process in ($ProcessesWithoutParents | Sort-Object CreationDate)) {
		Show-ProcessTree $Process.ProcessId 0
	}
}

# Aliases
#######################################################

function pull () { & get pull $args }
function checkout () { & git checkout $args }

del alias:gc -Force
del alias:gp -Force

Set-Alias -Name gc -Value checkout
Set-Alias -Name gp -Value pull

# Extra goodies
#######################################################
Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'
Import-Module oh-my-posh
Set-Theme Agnoster
#$DefaultUser = '✡️'
$DefaultUser = 'dakom'


# https://github.com/dahlbyk/posh-git/issues/583#issuecomment-402711469
[System.Environment]::SetEnvironmentVariable("SSH_AUTH_SOCK", $null)
[System.Environment]::SetEnvironmentVariable("SSH_AGENT_PID", $null)

# Start SSH 
# Start-SshAgent

```
