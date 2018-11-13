###########################################################
#
# custom profile
#
###########################################################
Set-PSReadlineOption -EditMode Emacs
Get-Module -ListAvailable | ? { $_.ModuleType -eq "Script" } | Import-Module

# inline functions, aliases and variables
function which($name) { Get-Command $name | Select-Object Definition }
function rmrf($item) { Remove-Item $item -Recurse -Force }
function mkfile($file) { "" | Out-File $file -Encoding ASCII }
function admindo($command) { runas /user:\administrator $command }

mkdir "$env:UserProfile\bin" -ErrorAction SilentlyContinue
$bin = "$env:UserProfile\bin"
