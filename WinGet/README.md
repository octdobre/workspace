# WinGet Install Scripts

### Windows Sandbox Bootstrap Script

Use this script to test out `winget` install scripts and commands
inside a fresh install of **Windows** using the **WindowsSandbox feature**.

Usage Example:
```
#Full   .\WindowsSandboxBootstrap.ps1 myWingetImportJson.json  -Script myPowerShellScript.ps1  -ScriptBlock { Write-Host "HelloWorld" }  -MapFolder "C:\SomePathToAFolder"
#Or     .\WindowsSandboxBootstrap.ps1 myWingetImportJson.json                  --> install tools with Winget
#Or     .\WindowsSandboxBootstrap.ps1 -Script .\myPowerShellScript.ps1         --> run the ps script
#Or     .\WindowsSandboxBootstrap.ps1 -ScriptBlock { Write-Host "HelloWorld" } --> run the ps script
#Or     .\WindowsSandboxBootstrap.ps1 -MapFolder "C:\SomePathToAFolder"        --> map the folder
```

You can run the script without arguments and it will just install `winget` inside **WindowsSandbox**.