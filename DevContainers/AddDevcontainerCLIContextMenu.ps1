
#Create PSDrive
New-PSDrive -name HKCR -psProvider registry -root HKEY_CLASSES_ROOT

$defaultValue = "(Default)"
$contextMenuText = "Open in DevContainer"
$contextMenuFunction = '%USERPROFILE%\AppData\Roaming\Code\User\User\globalStorage\ms-vscode-remote.remote-containers\cli-bin\devcontainer.cmd open'
$devcontainerPath = 'devcontainer'

#This will make it appear when you right click INSIDE a folder
New-Item "HKCR:\Directory\Background\shell\$devcontainerPath"
New-ItemProperty -Path HKCR:\Directory\Background\shell\devcontainer  -Name $defaultValue -PropertyType String -Value $contextMenuText

New-Item "HKCR:\Directory\Background\shell\$devcontainerPath\command"
New-ItemProperty -Path HKCR:\Directory\Background\shell\devcontainer\command -Name $defaultValue -Value $contextMenuFunction -Type ExpandString

#Distroy PsDrive
Remove-PSDrive HKCR