#This is the Install PowerShell script
#It provides a intective way to select and automatically install a 
#series programs and tools using winget 

<#
  main layout
   - options menu -done
   - save options in a list -done
   - based on options list build json -done
   - write json to file 
   - run winget install packages.json

  secondary
    - write yes/no prompt function -done
    - write objects                -done
    - write to convert to json     -done
    - run winget based on file 
    - cleanup ? 
#>


#------------------------------------------------------------------------------------
#Program Aggregate

function CreateInstallProgram(){

    function CreatePackagesJson(){

        $SourcesArray = [System.Collections.ArrayList]::new()

        $PackagesJson = [PSCustomObject]@{
            '$schema'     = 'https://aka.ms/winget-packages.schema.2.0.json'
            CreationDate  =  Get-Date  -Format "yyyy-MM-ddTHH:mm:ssK"
            Sources       =  $SourcesArray
            WinGetVersion = '0.4.11391'
        }

        Add-Member -memberType ScriptMethod -InputObject $PackagesJson -Name "AddSource" -Value {
            param(
                $argument, 
                $identifier, 
                $name, 
                $type
            )
            
            $PackagesArray = [System.Collections.ArrayList]::new()

            $SourceOrigin = [PSCustomObject]@{
                                        Argument   = $argument
                                        Identifier = $identifier
                                        Name       = $name
                                        Type       = $type
                                    }

            $SourceObject = [PSCustomObject]@{
                                        Packages      = $PackagesArray  
                                        SourceDetails = $SourceOrigin 
                                    }

            $n= $this.Sources.Add($SourceObject )
        }

        Add-Member -memberType ScriptMethod -InputObject $PackagesJson -Name "AddWingetPackage" -Value {
            param(
                $id
            )
            
            $src = $this.Sources | Where-Object {$_.SourceDetails.Name -Match 'winget'}
            $n= $src.Packages.Add([PSCustomObject]@{  PackageIdentifier = $id })
        }

        Add-Member -memberType ScriptMethod -InputObject $PackagesJson -Name "AddMSStorePackage" -Value {
            param(
                $id
            )
            
            $src = $this.Sources | Where-Object {$_.SourceDetails.Name -Match 'msstore'}
            $n= $src.Packages.Add([PSCustomObject]@{  PackageIdentifier = $id  })
        }

        Add-Member -memberType ScriptMethod -InputObject $PackagesJson -Name "RemoveEmptySources" -Value {

            $nonEmptySources = $this.Sources | Where-Object {$_.Packages.Count -GT 0}
            $this.Sources = [System.Collections.ArrayList]::new()
            $nonEmptySources | ForEach-Object {$this.Sources.Add($_)}
        }

        $PackagesJson.AddSource("https://winget.azureedge.net/msstore",
                                "Microsoft.Winget.MSStore.Source_8wekyb3d8bbwe",
                                "msstore",
                                "Microsoft.PreIndexed.Package")

        $PackagesJson.AddSource("https://winget.azureedge.net/cache",
                                "Microsoft.Winget.Source_8wekyb3d8bbwe",
                                "winget",
                                "Microsoft.PreIndexed.Package")

        return $PackagesJson
    }

    $PackageGroups = [System.Collections.ArrayList]::new()
    $PackagesJson = CreatePackagesJson

    $InstallProgram = [PSCustomObject]@{
            PackageGroups = $PackageGroups
            PackagesJson = $PackagesJson
    }

    enum StoreTypes {
        MSStore = 0
        Winget = 1
    }   

    Add-Member -memberType ScriptMethod -InputObject $InstallProgram -Name "CreatePackageGroup" -Value {
        param(
            $packageGroupName
        )
        
        $PackagesArray = [System.Collections.ArrayList]::new()
        $PackageGroup = [PSCustomObject]@{
            PackageGroupName = $packageGroupName
            PackagesArray = $PackagesArray
        }

        Add-Member -memberType ScriptMethod -InputObject $PackageGroup -Name "AddWingetPackage" -Value {
            param(
                $id,
                $moniker
            )

            $packageDefinition = [PSCustomObject]@{
                PackageId = $id
                PackageMoniker = $moniker
                PackageStore = [StoreTypes]::Winget
            }

            $n= $this.PackagesArray.Add($packageDefinition) 

            return $this    
        }

        Add-Member -memberType ScriptMethod -InputObject $PackageGroup -Name "AddWMSStorePackage" -Value {
            param(
                $id,
                $moniker
            )

            $packageDefinition = [PSCustomObject]@{
                PackageId = $id
                PackageMoniker = $moniker
                PackageStore = [StoreTypes]::MSStore
            }

            $n= $this.PackagesArray.Add($packageDefinition)
            return $this       
        }
        
        Add-Member -memberType ScriptMethod -InputObject $PackageGroup -Name "IsSelected" -Value {
            $yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes', 'Install the above mentioned programs'    
            $no = New-Object System.Management.Automation.Host.ChoiceDescription '&No', 'Skip the above mentioned programs'
            $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
             
            $ProgramsMonikerArray = [System.Collections.ArrayList]::new()
            foreach ($program in $this.PackagesArray)
            {
                $n= $ProgramsMonikerArray.Add($program.PackageMoniker)                                       
            }
            $ProgramsListStringParam = $ProgramsMonikerArray -join ", "

            $result = $host.ui.PromptForChoice($this.PackageGroupName, $ProgramsListStringParam, $options, 0)
        
            switch ($result)
            {
                0 {
                    return  $true
                }
                1 {
                    return  $false
                }
            }
        }

        $n= $this.PackageGroups.Add($PackageGroup)
        return $PackageGroup
    }

    Add-Member -memberType ScriptMethod -InputObject $InstallProgram -Name "RunPromptQuestions" -Value {

        foreach($packageGroup in $this.PackageGroups){
            if($packageGroup.IsSelected()){
                foreach($package in $packageGroup.PackagesArray){
                    switch ( $package.PackageStore )
                    {
                        MSStore
                        {
                            $this.PackagesJson.AddWMSStorePackage($package.PackageId)
                        }
                        Winget
                        {
                            $this.PackagesJson.AddWingetPackage($package.PackageId)
                        }
                    }
                }
            }
        }

        #Remove empty package groups
        $this.PackagesJson.RemoveEmptySources()
        
        
        Clear-Host
    }

    Add-Member -memberType ScriptMethod -InputObject $InstallProgram -Name "Install" -Value {

        $this.RunPromptQuestions()
        Clear-Host
        #Write-Host "Aggregate object output:"
        Write-Host "Running winget and installing the selected programs, please wait..."
        ConvertTo-Json -depth 10 $this.PackagesJson |
            Set-Content .\Packages.json
        #Write-Host $jsonvalue 

        #Let the magic happen
        winget import ".\Packages.json"
    }

    return $InstallProgram
}
#------------------------------------------------------------------------------------

$program = CreateInstallProgram

$program.CreatePackageGroup("Security").
AddWingetPackage("DominikReichl.KeePass","KeePass")

$program.CreatePackageGroup("Communication").
AddWingetPackage("OpenWhisperSystems.Signal","Signal").
AddWingetPackage("Element.Element","Element").
AddWingetPackage("Oxen.Session","Session")

$program.CreatePackageGroup("Documents").
AddWingetPackage("7Zip.7Zip","7Zip")

$program.CreatePackageGroup("Internet").
AddWingetPackage("Google.Chrome","Google Chrome").
AddWingetPackage("qBittorrent.qBittorrent","Torrent client")

$program.CreatePackageGroup("Reinstall and cleanup").
AddWingetPackage("Rufus.Rufus","Rufus").
AddWingetPackage("CrystalIDEASoftware.UninstallTool","Uninstall Tool")

$program.CreatePackageGroup("Video").
AddWingetPackage("VideoLAN.VLC","vlc").
AddWingetPackage("clsid2.mpc-hc","MPC-HC")

$program.CreatePackageGroup("Basic Software Development").
AddWingetPackage("Microsoft.WindowsTerminal","Windows Terminal").
AddWingetPackage("Notepad++.Notepad++","Notepad++").
AddWingetPackage("Microsoft.VisualStudioCode","VSCode").
AddWingetPackage("Docker.DockerDesktop","Docker Desktop")

$program.CreatePackageGroup("Microsoft Software").
AddWingetPackage("Microsoft.OneDrive","OneDrive")

$program.CreatePackageGroup("Microsoft For Work").
AddWingetPackage("Microsoft.Teams","Microsoft Teams")

$program.CreatePackageGroup("Video Editing").
AddWingetPackage("OBSProject.OBSStudio","OBS Studio").
AddWingetPackage("OpenShot.OpenShot","OpenShot").
AddWingetPackage("HandBrake.HandBrake","HandBrake")

$program.CreatePackageGroup("Hardware related software").
AddWingetPackage("AMD.RyzenMaster","AMD RyzenMaster").
AddWingetPackage("Logitech.LGS","Logitech Gaming Software Center")

$program.CreatePackageGroup("Hardware benchmarking").
AddWingetPackage("LCrystalDewWorld.CrystalDiskMark","CrystalDiskMark")

$program.CreatePackageGroup("Gaming Platforms").
AddWingetPackage("Ubisoft.Connect","Ubisoft Connect").
AddWingetPackage("ElectronicArts.EADesktop","EADesktop").
AddWingetPackage("EpicGames.EpicGamesLauncher","Epic Games").
AddWingetPackage("Valve.Steam","Steam")

$program.CreatePackageGroup("Gaming Social").
AddWingetPackage("Discord.Discord","Discord")

$program.CreatePackageGroup("Gaming Related").
AddWingetPackage("Lexikos.AutoHotkey","AutoHotkey")

$program.CreatePackageGroup("Nvidia Bundle").
AddWingetPackage("Nvidia.GeForceExperience","Nvidia GeForceExperience").
AddWingetPackage("Nvidia.PhysX","Nvidia PhysX").
AddWingetPackage("Nvidia.Broadcast","Nvidia Broadcast")

$program.CreatePackageGroup("Gaming required DLL's").
AddWingetPackage("Microsoft.VC++2008Redist-x86","VC++2008Redist-x86").
AddWingetPackage("Microsoft.VC++2008Redist-x64","VC++2008Redist-x64").
AddWingetPackage("Microsoft.VC++2010Redist-x86","VC++2010Redist-x86").
AddWingetPackage("Microsoft.VC++2010Redist-x64","VC++2010Redist-x64").
AddWingetPackage("Microsoft.VC++2012Redist-x86","VC++2012Redist-x86").
AddWingetPackage("Microsoft.VC++2012Redist-x64","VC++2012Redist-x64").
AddWingetPackage("Microsoft.VC++2013Redist-x86","VC++2013Redist-x86").
AddWingetPackage("Microsoft.VC++2013Redist-x64","VC++2013Redist-x64")


$program.Install()


#------------------------------------------------------------------------------------