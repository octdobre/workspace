# DevContainers



Deep-Dive 👉 🔗 [VSCode DevContainers](https://code.visualstudio.com/docs/remote/create-dev-container "VSCode DevContainers")

## TLDR
:rocket: **Zero-to-Hero**   

* Install **Docker-Desktop** :point_right: `winget install docker`
* Install **VSCode**      :point_right:  `winget install vscode`
* Install **VSCode** extension `Remote Development` :point_right: `code --install-extension ms-vscode-remote.vscode-remote-extensionpack`
* Install **devcontainer CLI** :point_right: `npm install -g @vscode/dev-container-cli`
* Throwing in a script to add a context menu when right clicking inside the folder :point_right: `AddDevcontainerCLIContextMenu.ps1`


## :stew: Pre cooked devcontainer configurations

**Configurations** folder contains `.devcontainer` examples for various workspaces 
ready with required :hammer:toolkits and extensions. 

Copy one to your workspace and use the context menu to open directly in a **DevContainer**.


## :boom: Mixing them all together

<h1 align="left">
<img src="images/devcontainer.gif" alt="DevcontainerGif"/>
</h1>

## :floppy_disk: Using Volumes

With **VSCode** you can `"Clone Repo to Volume"` and manage the workspaces with **Docker** `Volumes` instead of handling folders on disk. 

If you use the functionality `"Clone Repo to Volume"` you can find the volumes
in Windows navigating to `\\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes`

Below is an example of how to use `"Clone Repo to Volume"` and possibly a bug.

[![Clone Repo in Volume does not override if volume already exists](https://img.youtube.com/vi/79wq_V7dr84/0.jpg)](https://www.youtube.com/watch?v=79wq_V7dr84)


## :books: Documentation

🔗 [Using Docker containers in VS Code](https://www.youtube.com/watch?v=PGsMy75ffPM 'Using Docker containers in VS Code')

🔗 [GitHub Issue on "Clone Repo in Volume"](https://github.com/microsoft/vscode-remote-release/issues/5453 'GitHub Issue on "Clone Repo in Volume')
