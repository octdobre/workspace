# Script modified to work with 'winget import' and json files
#Usage  .\WindowsSandboxBootstrap.ps1 myWingetImportJson.json  -Script myPowerShellScript.ps1  -ScriptBlock { Write-Host "HelloWorld" }  -MapFolder "C:\SomePathToAFolder"
#Or     .\WindowsSandboxBootstrap.ps1 myWingetImportJson.json                  --> install tools with Winget
#Or     .\WindowsSandboxBootstrap.ps1 -Script .\myPowerShellScript.ps1         --> run the ps script
#Or     .\WindowsSandboxBootstrap.ps1 -ScriptBlock { Write-Host "HelloWorld" } --> run the ps script block
#Or     .\WindowsSandboxBootstrap.ps1 -MapFolder "C:\SomePathToAFolder"        --> map the folder


Param(
  [Parameter(Position = 0, HelpMessage = "The Manifest to install in the Sandbox.")]
  [String] $Manifest,
  [Parameter(HelpMessage = "The script to run in the Sandbox.")]
  [String] $Script,
  [Parameter(HelpMessage = "The script to run in the Sandbox.")]
  [ScriptBlock] $ScriptBlock,
  [Parameter(HelpMessage = "The folder to map in the Sandbox.")]
  [String] $MapFolder = $pwd
)

$ErrorActionPreference = "Stop"

$mapFolder = (Resolve-Path -Path $MapFolder).Path

if (-Not (Test-Path -Path $mapFolder -PathType Container)) 
{
  Write-Error -Category InvalidArgument -Message 'The provided MapFolder is not a folder.'
}

# Check if install json exists

if (-Not [String]::IsNullOrWhiteSpace($Manifest)) 
{
  Write-Host '--> Checking existance of manifest'

  if (-Not (Test-Path -Path $Manifest)) 
  {
    throw [System.IO.DirectoryNotFoundException]::new('The Manifest does not exist.')
  }
}

# Check if script exists

if (-Not [String]::IsNullOrWhiteSpace($Script)) 
{
  Write-Host '--> Checking existance of input script'

  if (-Not (Test-Path -Path $Script)) 
  {
    throw [System.IO.DirectoryNotFoundException]::new('The input script does not exist.')
  }
}


# Check if Windows Sandbox is enabled

if (-Not (Get-Command 'WindowsSandbox' -ErrorAction SilentlyContinue)) 
{
    Write-Error -Category NotInstalled -Message @'
    Windows Sandbox does not seem to be available. Check the following URL for prerequisites and further details:
    https://docs.microsoft.com/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview

    You can run the following command in an elevated PowerShell for enabling Windows Sandbox:
    $ Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM'
'@
}

# Close Windows Sandbox if errors detected

$sandbox = Get-Process 'WindowsSandboxClient' -ErrorAction SilentlyContinue
if ($sandbox) 
{
  Write-Host '--> Closing Windows Sandbox'

  $sandbox | Stop-Process
  Start-Sleep -Seconds 5

  Write-Host
}
Remove-Variable sandbox

# Initialize Temp Folder. Winget installer and dependencies will be downloaded here

$tempFolderName = 'SandboxTest'
$tempFolder = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath $tempFolderName

New-Item $tempFolder -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

# Set dependencies

$apiLatestUrl = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$WebClient = New-Object System.Net.WebClient

function Get-LatestUrl 
{
  ((Invoke-WebRequest $apiLatestUrl -UseBasicParsing | ConvertFrom-Json).assets | Where-Object { $_.name -match '^Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle$' }).browser_download_url
}

function Get-LatestHash 
{
  $shaUrl = ((Invoke-WebRequest $apiLatestUrl -UseBasicParsing | ConvertFrom-Json).assets | Where-Object { $_.name -match '^Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.txt$' }).browser_download_url

  $shaFile = Join-Path -Path $tempFolder -ChildPath 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.txt'
  $WebClient.DownloadFile($shaUrl, $shaFile)

  Get-Content $shaFile
}

# Hide the progress bar of Invoke-WebRequest
$oldProgressPreference = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'

$desktopAppInstaller = 
@{
  fileName = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
  url      = $(Get-LatestUrl)
  hash     = $(Get-LatestHash)
}

$ProgressPreference = $oldProgressPreference

$vcLibsUwp = 
@{
  fileName = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
  url      = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
  hash     = 'A39CEC0E70BE9E3E48801B871C034872F1D7E5E8EEBE986198C019CF2C271040'
}

$dependencies = @($desktopAppInstaller, $vcLibsUwp)

# Clean temp directory

Get-ChildItem $tempFolder -Recurse -Exclude $dependencies.fileName | Remove-Item -Force -Recurse

if (-Not [String]::IsNullOrWhiteSpace($Manifest)) 
{
  Copy-Item -Path $Manifest -Recurse -Destination $tempFolder
}

# Download dependencies for Winget

Write-Host '--> Checking dependencies'

$desktopInSandbox = 'C:\Users\WDAGUtilityAccount\Desktop'

foreach ($dependency in $dependencies) 
{
  $dependency.file = Join-Path -Path $tempFolder -ChildPath $dependency.fileName
  $dependency.pathInSandbox = Join-Path -Path $desktopInSandbox -ChildPath (Join-Path -Path $tempFolderName -ChildPath $dependency.fileName)

  # Only download if the file does not exist, or its hash does not match.
  if (-Not ((Test-Path -Path $dependency.file -PathType Leaf) -And $dependency.hash -eq $(Get-FileHash $dependency.file).Hash)) 
  {
    Write-Host @"
    - Downloading:
      $($dependency.url)
"@

    try 
    {
      $WebClient.DownloadFile($dependency.url, $dependency.file)
    }
    catch 
    {
      #Pass the exception as an inner exception
      throw [System.Net.WebException]::new("Error downloading $($dependency.url).",$_.Exception)
    }
    if (-not ($dependency.hash -eq $(Get-FileHash $dependency.file).Hash)) 
    {
      throw [System.Activities.VersionMismatchException]::new('Dependency hash does not match the downloaded file')
    }
  }
}

Write-Host

# Create Bootstrap script
# Creating Update-EnvironmentVariables function
# Installing Winget

# See: https://stackoverflow.com/a/22670892/12156188
$bootstrapPs1Content = @'
function Update-EnvironmentVariables {
  foreach($level in "Machine","User") {
    [Environment]::GetEnvironmentVariables($level).GetEnumerator() | % {
        # For Path variables, append the new values, if they're not already in there
        if($_.Name -match 'Path$') {
          $_.Value = ($((Get-Content "Env:$($_.Name)") + ";$($_.Value)") -split ';' | Select -unique) -join ';'
        }
        $_
    } | Set-Content -Path { "Env:$($_.Name)" }
  }
}


'@

$bootstrapPs1Content += @"
Write-Host @'
--> Installing WinGet

'@
Add-AppxPackage -Path '$($desktopAppInstaller.pathInSandbox)' -DependencyPath '$($vcLibsUwp.pathInSandbox)'

Write-Host @'

Tip: you can type 'Update-EnvironmentVariables' to update your environment variables, such as after installing a new software.

'@


"@

# Add Winget install command to the bootstrap script

if (-Not [String]::IsNullOrWhiteSpace($Manifest)) 
{
  $manifestFileName = Split-Path $Manifest -Leaf
  $manifestPathInSandbox = Join-Path -Path $desktopInSandbox -ChildPath (Join-Path -Path $tempFolderName -ChildPath $manifestFileName)

  $bootstrapPs1Content += @"
Write-Host @'

--> Configuring Winget
'@
winget settings --Enable LocalManifestFiles

Write-Host @'`n
--> Installing the Manifest  $manifestFileName

'@
winget import '$manifestPathInSandbox'

Write-Host @'

--> Refreshing environment variables
'@
Update-EnvironmentVariables


"@
}

# Add the content of the input script to the bootstrap script
# to be ran inside the sandbox

if (-Not [String]::IsNullOrWhiteSpace($Script)) 
{
  $scriptContent = Get-Content -Path $Script

  $bootstrapPs1Content += @"
Write-Host @'

--> Running the following script:

{
$scriptContent
}

'@

$scriptContent

"@
}

if (-Not [String]::IsNullOrWhiteSpace($ScriptBlock)) 
{

  $bootstrapPs1Content += @"
Write-Host @'

--> Running the following script block:

{
$ScriptBlock
}

'@

$ScriptBlock

"@
}

$bootstrapPs1Content += @"
Write-Host
"@

$bootstrapPs1FileName = 'Bootstrap.ps1'
$bootstrapPs1Content | Out-File (Join-Path -Path $tempFolder -ChildPath $bootstrapPs1FileName)

# Create Wsb file

$bootstrapPs1InSandbox = Join-Path -Path $desktopInSandbox -ChildPath (Join-Path -Path $tempFolderName -ChildPath $bootstrapPs1FileName)
$mapFolderInSandbox = Join-Path -Path $desktopInSandbox -ChildPath (Split-Path -Path $mapFolder -Leaf)

$sandboxTestWsbContent = @"
<Configuration>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>$tempFolder</HostFolder>
      <ReadOnly>true</ReadOnly>
    </MappedFolder>
    <MappedFolder>
      <HostFolder>$mapFolder</HostFolder>
    </MappedFolder>
  </MappedFolders>
  <LogonCommand>
  <Command>PowerShell Start-Process PowerShell -WindowStyle Maximized -WorkingDirectory '$mapFolderInSandbox' -ArgumentList '-ExecutionPolicy Bypass -NoExit -NoLogo -File $bootstrapPs1InSandbox'</Command>
  </LogonCommand>
</Configuration>
"@

$sandboxTestWsbFileName = 'SandboxTest.wsb'
$sandboxTestWsbFile = Join-Path -Path $tempFolder -ChildPath $sandboxTestWsbFileName
$sandboxTestWsbContent | Out-File $sandboxTestWsbFile

Write-Host @"
--> Starting Windows Sandbox, and:
    - Mounting the following directories:
      - $tempFolder as read-only
      - $mapFolder as read-and-write
    - Installing WinGet
    - Configuring Winget
"@

if (-Not [String]::IsNullOrWhiteSpace($Manifest)) 
{
  Write-Host @"
    - Installing the Manifest $manifestFileName
    - Refreshing environment variables
"@
}

if (-Not [String]::IsNullOrWhiteSpace($Script)) 
{
  Write-Host @"
    -------------------------------
    - Running the following script:

    - $Script
    With Content:
    {
      $scriptContent
    }
"@
}

if (-Not [String]::IsNullOrWhiteSpace($ScriptBlock)) 
{
  Write-Host @"
    -------------------------------
    - Running the following script block:

    {
     $ScriptBlock
    }
"@
}



Write-Host

WindowsSandbox $SandboxTestWsbFile