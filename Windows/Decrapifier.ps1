Write-Host "Uninstalling Crap Windows Store Apps"

Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
Get-AppxPackage -Name king.com.CandyCrushFriends  | Remove-AppxPackage
Get-AppxPackage -Name king.com.FarmHeroesSaga |  Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage
Get-AppxPackage *microsoft.office.onenote* | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
Get-AppxPackage Microsoft.People | Remove-AppxPackage
Get-AppxPackage *xboxapp* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxOneSmartGlass | Remove-AppxPackage
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
Get-ProvisionedAppxPackage -Online | Where-Object { $_.PackageName -match "xbox" } | ForEach-Object { Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $_.PackageName }
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage *zunevideo* | Remove-AppxPackage
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedbackHub| Remove-AppxPackage
#----------------------------------------------------------------------------------------------------------

#Disable some of the new features of Windows 10, such as forcibly installing apps you don't want, and the new annoying animation for first time login.
Write-Host "Disable some of the new features of Windows 10, such as forcibly installing apps you don't want, and the new annoying animation for first time login."
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\' -Name 'CloudContent'
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableWindowsConsumerFeatures' -PropertyType DWord -Value '1' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableSoftLanding' -PropertyType DWord -Value '1' -Force

#Uninstall Cortana, Disable Cortana, and disable any kind of web search or location settings
Write-Host "Uninstall Cortana, Disable Cortana, and disable any kind of web search or location settings"
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\' -Name 'Windows Search'
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -PropertyType DWord -Value '0' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowSearchToUseLocation' -PropertyType DWord -Value '0' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'DisableWebSearch' -PropertyType DWord -Value '1' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'ConnectedSearchUseWeb' -PropertyType DWord -Value '0' -Force
Set-ItemProperty -Path  "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 

#Disable data collection and telemetry settings.
Write-Host "Disable data collection and telemetry settings."
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'SmartScreenEnabled' -PropertyType String -Value 'Off' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -PropertyType DWord -Value '0' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -PropertyType DWord -Value '0' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -PropertyType DWord -Value '0' -Force

#Disable Windows Defender submission of samples and reporting.
Write-Host "Disable Windows Defender submission of samples and reporting."
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\' -Name 'Spynet'
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' -Name 'SpynetReporting' -PropertyType DWord -Value '0' -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' -Name 'SubmitSamplesConsent' -PropertyType DWord -Value '2' -Force

#Disabling Windows Feedback Experience program
Write-Output "Disabling Windows Feedback Experience program"
$Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
If (Test-Path $Advertising) {      Set-ItemProperty $Advertising Enabled -Value 0     }

$Period = "HKCU:\Software\Microsoft\Siuf\Rules" 
If (!(Test-Path $Period)) { New-Item $Period  } Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

#Prevents bloatware applications from returning and removes Start Menu suggestions
Write-Output 'Prevents bloatware applications from returning and removes Start Menu suggestions'               
Write-Output "Adding Registry key to prevent bloatware apps from returning"
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
If (!(Test-Path $registryPath)) {  New-Item $registryPath  }
Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

If (!(Test-Path $registryOEM)) { New-Item $registryOEM }
Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0   

#Preping mixed Reality Portal for removal    
Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
$Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
If (Test-Path $Holo) { Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 }

#Disables Wi-fi Sense
Write-Output "Disabling Wi-Fi Sense"
$WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
$WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
$WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
If (!(Test-Path $WifiSense1)) {  New-Item $WifiSense1  }
Set-ItemProperty $WifiSense1  Value -Value 0 
If (!(Test-Path $WifiSense2)) { New-Item $WifiSense2 }
Set-ItemProperty $WifiSense2  Value -Value 0 
Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 

#Disabling People icon on Taskbar
Write-Output "Disabling People icon on Taskbar"


#----------------------------------------------------------------------------------------------------------
Write-Host 'Disabling services added in Creators Update,  Fall Creators Update, April 2018 Update, Anniversary Update'
$services = @(
    # See https://virtualfeller.com/2017/04/25/optimize-vdi-windows-10-services-original-anniversary-and-creator-updates/

    # Connected User Experiences and Telemetry used in UWP apps and XBOX games most
    'DiagTrack',

    # Data Usage service
    'DusmSvc',

    # Peer-to-peer windows updates
    'DoSvc',

    # AllJoyn Router Service (IoT related)
    'AJRouter',

    # SSDP Discovery (UPnP)
    'SSDPSRV',
    'upnphost',

    # Superfetch or page file or virtual memmory
    'SysMain',

    # http://www.csoonline.com/article/3106076/data-protection/disable-wpad-now-or-have-your-accounts-and-private-data-compromised.html
    'iphlpsvc',  #IPV6 Required Service
    'WinHttpAutoProxySvc',   # Proxy for WinHTTP applications

    # Black Viper 'Safe for DESKTOP' services.
	#
    # See http://www.blackviper.com/service-configurations/black-vipers-windows-10-service-configurations/
    'tzautoupdate',     #Auto Time Zone Updated
    'AppVClient',       #Component that runs virtualized applications on user devices
    'RemoteRegistry',   #Enables remote users to modify registry settings on your computer
    #'RemoteAccess',    #Remote Access Service (RAS) provides remote access capabilities to client applications on computers running Windows.
    'shpamsvc',         #Manages profiles and accounts on a SharedPC configured device.
    'SCardSvr',         #Manages access to smart cards read by your computer
    'UevAgentService',  #User Experience Virtualization Service
    'ALG',              #Provides support for 3rd party protocol plug-ins for Internet Connection Sharing.
    'PeerDistSvc',      #This service caches network content from peers on the local subnet.
    #'NfsClnt',          #Client for NFS service,Using the NFS protocol, you can transfer files between computers running Windows and other non-Windows operating systems, such as Linux or UNIX.
    'dmwappushservice', #Routes Wireless Application Protocol (WAP) Push messages received by the device and synchronizes Device Management sessions.
    'MapsBroker',       #Maps Manager service
    'lfsvc',            #This service monitors the current location of the system and manages geofences (a geographical location with associated events). If you turn off this service, applications will be unable to use or receive notifications for geolocation or geofences.
    #'HvHost',             #Offers performance counters to the hypervisor
    #'vmickvpexchange',    #Provides a mechanism to exchange data between the virtual machine and the operating system running on the physical computer.
    #'vmicguestinterface', #Provides an interface for the Hyper-V host to interact with specific services running inside the virtual machine.
    #'vmicshutdown',       #Provides a mechanism to shut down the operating system of this virtual machine from the management interfaces on the physical computer.
    #'vmicheartbeat',      #Monitors the state of this virtual machine by reporting a heartbeat at regular intervals. 
    #'vmicvmsession',      #Provides a mechanism to manage virtual machine with PowerShell via VM session without a virtual network.
    #'vmicrdv',            #Provides a platform for communication between the virtual machine and the operating system running on the physical computer. 
    #'vmictimesync',       #Synchronizes the system time of this virtual machine with the system time of the physical computer.
    #'vmicvss',            #Coordinates the communications that are required to use Volume Shadow Copy Service to back up applications and data on this virtual machine
    'irmon',              #Detects other Infrared devices that are in range and launches the file transfer application. 
    'SharedAccess',       #Provides network address translation, addressing, name resolution and/or intrusion prevention services for a home or small office network.
    'MSiSCSI',            #Manages Internet SCSI (iSCSI) sessions from your computer to remote iSCSI target devices.
    'SmsRouter',          #Routes messages based on rules to appropriate clients.
    'CscService',         #The Offline Files service performs maintenance activities on the Offline Files cache, responds to user logon and logoff events, 
    'SEMgrSvc',           #Manages payments and Near Field Communication (NFC) based secure elements.
    'PhoneSvc',           #Manages the telephony state on the device.
    'RpcLocator',         #Remote Procedure Call (RPC) Locator service manages the RPC name service database.
    'RetailDemo',         #The Retail Demo service controls device activity while the device is in retail demo mode.
    'SensorDataService',  #Delivers data from a variety of sensors.
    #'SensrSvc',           #Monitors various sensors in order to expose data and adapt to system and user state. If this service is stopped or disabled, the display brightness will not adapt to lighting conditions.
    'SensorService',      #A service for sensors that manages different sensors' functionality. Manages Simple Device Orientation (SDO) and History for sensors.
    'ScDeviceEnum',       #Creates software device nodes for all smart card readers accessible to a given session. If this service is disabled, WinRT APIs will not be able to enumerate smart card readers.
    'SCPolicySvc',        #Allows the system to be configured to lock the user desktop upon smart card removal.
    'SNMPTRAP',           #Receives trap messages generated by local or remote Simple Network Management Protocol (SNMP) agents and forwards the messages to SNMP management programs running on your computer.
    #'TabletInputService', #!!!! WONT MAKE WINDOWS TERMINAL WORK. The Tablet PC Input Service (TabletInputService) enables Tablet PC pen-and-ink functionality,
    'WFDSConSvc',
    'FrameServer',        #Enables multiple clients to access video frames from camera devices.
    'wisvc',              #Provides infrastructure support for the Windows Insider Program. This service must remain enabled for the Windows Insider Program to work
    'icssvc',             #Provides the ability to share a cellular data connection with another device.
    'WinRM',              #A Windows-native built-in remote management protocol in its simplest form that uses Simple Object Access Protocol to interface with remote computers and servers, as well as Operating Systems and applications.
    'WwanSvc',            #This service manages mobile broadband (GSM & CDMA) data card/embedded module adapters and connections by auto-configuring the networks.
    'XblAuthManager',     #Provides authentication and authorization services for interacting with Xbox Live.
    'XblGameSave',        #This service syncs save data for Xbox Live save enabled games.
    'XboxNetApiSvc'       #Xbox Live Networking Service
)
foreach ($service in $services) {
    Set-Service $service -StartupType Disabled
}


Write-Host 'Disabling optional features...'
$features = @(
    #'MediaPlayback',
    'SMB1Protocol',
    'Xps-Foundation-Xps-Viewer',
    'WorkFolders-Client',
    'WCF-Services45',
    'NetFx4-AdvSrvs',
    'Printing-Foundation-Features',
    'Printing-PrintToPDFServices-Features',
    'Printing-XPSServices-Features',
    'MSRDC-Infrastructure',
    'MicrosoftWindowsPowerShellV2Root',
    'Internet-Explorer-Optional-amd64'
)
foreach ($feature in $features) {
    Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
}

winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe
winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe
winget uninstall Microsoft.MSPaint_8wekyb3d8bbwe
winget uninstall Microsoft.Microsoft3DViewer_8wekyb3d8bbwe
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe
winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe
winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe
winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe
winget uninstall Microsoft.People_8wekyb3d8bbwe
winget uninstall Microsoft.SkypeApp_kzf8qxf38zg5c
winget uninstall Microsoft.Wallet_8wekyb3d8bbwe
winget uninstall Microsoft.WindowsCamera_8wekyb3d8bbwe
winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe
winget uninstall Microsoft.WindowsMaps_8wekyb3d8bbwe
winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe
winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe
winget uninstall Microsoft.XboxApp_8wekyb3d8bbwe
winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe
winget uninstall  Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe
winget uninstall  Microsoft.YourPhone_8wekyb3d8bbwe
winget uninstall  Microsoft.ZuneMusic_8wekyb3d8bbwe
winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe
winget uninstall SpotifyAB.SpotifyMusic_zpdnekdrzrea0
winget uninstall  microsoft.windowscommunicationsapps_8wekyb3d8bbwe
winget uninstall  Microsoft.GetHelp_8wekyb3d8bbwe
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe