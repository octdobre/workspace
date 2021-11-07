$specificExtensionPack = "container-tools"
$extensionPacks = "$env:USERPROFILE\.vscode\extension-packs\$specificExtensionPack"
$userData = "$env:APPDATA\Code\User"

code . --extensions-dir $extensionPacks --user-data-dir $userData

Exit