# Download Extensions and Container Tools Folder
$extensionsArray = [System.Collections.ArrayList]::new()
$extensionsArray.Add("ms-azuretools.vscode-docker")
$extensionsArray.Add("ms-vscode-remote.remote-containers")
$extensionsArray.Add("ms-vscode-remote.remote-ssh")
$extensionsArray.Add("ms-vscode-remote.remote-ssh-edit")
$extensionsArray.Add("ms-vscode-remote.remote-wsl")
$extensionsArray.Add("ms-vscode-remote.vscode-remote-extensionpack")

function DownloadExtensionAndCopyToFolder(){

    param(
        [Parameter()]
        [String] $ExtensionId,
        [Parameter()]
        [String] $SpecificExtensionsFolder
    )

    $pathToVSCode = "$env:USERPROFILE\.vscode"
    $pathToVSCodeExtensions = "$pathToVSCode\extensions"

    code --install-extension $ExtensionId

     Write-Host $ExtensionId
     Write-Host $SpecificExtensionsFolder

    #find folder of extension
    $foundFolder = Get-ChildItem -Path $pathToVSCodeExtensions -Directory  | Where-Object { $_.FullName.Contains($ExtensionId) } | Select-Object FullName -First 1

    Write-Host  $foundFolder.FullName

    $extensionPacksFolder = "$pathToVSCode\extension-packs"
    if (-not(Test-Path -Path $extensionPacksFolder)) { 
        md $extensionPacksFolder }
    if (-not(Test-Path -Path "$extensionPacksFolder\$SpecificExtensionsFolder")) { 
        md "$extensionPacksFolder\$SpecificExtensionsFolder"
    } 
       

    if (-not(Test-Path -Path "$extensionPacksFolder\$SpecificExtensionsFolder\$ExtensionId")){
        Xcopy /E /I $foundFolder.FullName "$extensionPacksFolder\$SpecificExtensionsFolder\$ExtensionId"
    }
    
}

$extensionsArray | ForEach-Object { DownloadExtensionAndCopyToFolder -ExtensionId $_ -SpecificExtensionsFolder "container-tools"}