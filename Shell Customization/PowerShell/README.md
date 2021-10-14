# Shell Customization

## Table of Contents
[**Powershell**](#PowerShell)
  * [**1 - Installation**](#Installation)
  * [**2 - Customization**](#Customization)

## PowerShell 

### Installation 
---
1. Open a PowerShell window and run these commands:
   
    ```
    Install-Module posh-git -Scope CurrentUser
    Install-Module oh-my-posh -Scope CurrentUser
    ```

2. Install CaskaydiaCove NF (Nerd Font) from Nerd Fonts.

3. Install Git for Windows.

5. Type `echo $profile` in a PowerShell window and find out the location of the
   profile. If profile doesnt exist type `nodepad $profile` and it should 
   create a default one if it doesnt exist.

    Example: 
    ```
    C:\Users\octdo\Documents\WindowsPowerShell\
    Microsoft.PowerShell_profile.ps1
    ```
    This is where the powershell profiles need to be copied.

6. Copy the `.omp.json` theme to the themes folder.

   Can be found in example: 
   ```
   C:\Users\octdo\Documents\WindowsPowerShell\Modules\oh-my-posh\5.7.1\themes
   ```

7. Open Windows Terminal and open the settings json. Then copy over the settings
   json from here to there.



### Customization
---
* Adding a font to a settings section

    In the settings json section add this section:

    ```
    "font": 
        {
            "face": "CaskaydiaCove NF"
        },
    ```

* To view availeble Oh-My-Posh Themes
    `Get-PoshThemes`
* Setting a Oh-My-Posh Theme from existing ones
    `Set-PoshPrompt -Theme paradox`


* Example template of a prompt
    ```
    OS LOGO > FUll path > Git branch >  <username < k8s context :: k8s namespace
                                                    machine < memory usage < time 
    ```

* Creating a new Profile
    a) Create a new `Microsoft.PowerShell_profile.ps1`, or copy this one. 
    Remember to rename it.

    b) Create a new Oh-My-Posh theme. Reference the theme inside the 
    Powershell profile.

    c) Create a new Windows Terminal profile section and reference the 
    PowerShell profile like so:
    ```
    "commandline": "powershell.exe -noexit -noprofile -f %USERPROFILE%\\Documents\\WindowsPowerShell\\<insert here ps profile>.ps1",
    ```
    d) Reference correct PowerShell icon in the profile:
    ```
    "icon":"ms-appx:///ProfileIcons/{61c54bbd-c2c6-5271-96e7-009a87ff44bf}.png"
    ```





   






