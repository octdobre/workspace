# Shell Customization

## Table of Contents
[**Powershell**](#PowerShell)
  * [**1 - Examples**](#Examples)
  * [**2 - Installation**](#Installation)
  * [**3 - Customization**](#Customization)

[**FAQ**](#FAQ)

[**Documentation**](#Documentation)

## PowerShell 

### Examples

_Baller Shell_

<h1 align="center">
<img src="images/baller-shell.gif" />
</h1>

_Fire Shell_

<h1 align="center">
<img src="images/fire-shell.png" alt="Nerd Fonts Logo" />
</h1>

### Installation 

1. Open a `PowerShell` window and run these commands:
   
    ```
    Install-Module posh-git -Scope CurrentUser
    Install-Module oh-my-posh -Scope CurrentUser
    ```
    In case you cannot run these commands check the [FAQ](#FAQ) section.

2. Install CaskaydiaCove NF (**Nerd Font**) from **Nerd Fonts**.

3. Install **Git for Windows**.

5. Type `echo $profile` in a `PowerShell` window and find out the location of the
   profile. If the profile doesn't exist type `code $profile` and it should 
   create a default one if it doesn't exist, otherwise it opens it.

    Example: 
    ```
    C:\Users\octdo\Documents\WindowsPowerShell\
    Microsoft.PowerShell_profile.ps1
    ```
    This is where the `PowerShell` profiles need to be copied.

6. Copy the `.omp.json` theme to the themes folder.

   Can be found in example: 
   ```
   C:\Users\octdo\Documents\WindowsPowerShell\Modules\oh-my-posh\5.7.1\themes
   ```

7. Open **Windows Terminal** and open the settings json. Then copy over the settings
   `json` from here to there.
   
### Customization

* Adding a _font_ to a settings section

    In the settings `json` section add this section:

    ```
    "font": 
        {
            "face": "CaskaydiaCove NF"
        },
    ```

* To view available **Oh-My-Posh** Themes
    `Get-PoshThemes`
* Setting a **Oh-My-Posh** Theme from existing ones
    `Set-PoshPrompt -Theme paradox`


* Example template of a prompt
    ```
    OS LOGO > FUll path > Git branch >  <username < k8s context :: k8s namespace
                                                    machine < memory usage < time 
    ```

* Creating a new Profile

    a) Create a new `Microsoft.PowerShell_profile.ps1`, or copy this one. 
    Remember to rename it.

    b) Create a new **Oh-My-Posh** theme. Reference the theme inside the 
    `Powershell` profile.

    c) Create a new **Windows Terminal** profile section. Remember to generate a new `GUID` for the profile Id. 
    
    d) Reference the `PowerShell` profile like so:
    ```
    "commandline": "powershell.exe -noexit -noprofile -f %USERPROFILE%\\Documents\\WindowsPowerShell\\<insert here ps profile>.ps1",
    ```
    e) Reference correct `PowerShell` icon in the profile:
    ```
    "icon":"ms-appx:///ProfileIcons/{61c54bbd-c2c6-5271-96e7-009a87ff44bf}.png"
    ```

## FAQ 


* Cannot execute `Powershell` scripts!

    To enable execution of unsigned `PowerShell` scripts.
    ```
    Set-ExecutionPolicy Bypass -Scope Process
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted
    ```

## Documentation 
* [CascadiaCore-Original-Font](https://github.com/microsoft/cascadia-code "CascadiaCore-Original-Font")
* [Nerd Fonts](https://www.nerdfonts.com/ "Nerd Fonts")
* [Oh-My-Posh](https://ohmyposh.dev/ "Oh-My-Posh")
* [PowerLine-Extra-Symbols](https://github.com/ryanoasis/powerline-extra-symbols "PowerLine-Extra-Symbols")
* [Windows-Terminal-Powerline-Docs](https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup "Windows-Terminal-Powerline-Docs")
* [Pretty-Prompt-By-Hanselman](https://www.hanselman.com/blog/how-to-make-a-pretty-prompt-in-windows-terminal-with-powerline-nerd-fonts-cascadia-code-wsl-and-ohmyposh "Pretty-Prompt-By-Hanselman")


   






