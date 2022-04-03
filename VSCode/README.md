# Visual Studio Code Customization

### Start VSCode with Specific Extensions
Due to the fact that **VSCode** does not provide a straightforward way to enable specific extensions per workspace, I have created a set of `scripts` to help with this problem.

According to this documentation, [Advanced CLI Commands](https://code.visualstudio.com/docs/editor/command-line#Advanced%20CLI%20options "Advanced CLI Commands"),
you can start a lightweight and focused instance of VSCode with a specific set of extensions by providing the command line argument `--extensions-dir <dir>` to the **VSCode CLI** aka `code`.

Although the extensions reside in `%USERPROFILE%\.vscode\extensions`, individual ones can be copied to a specific folder. 

* `CreateContainerTools.ps1` creates a folder in `%USERPROFILE%\.vscode`
and downloads a set of extensions good for working with `containers`.

* `StartVSCodeWithContainerTools.ps1` can be placed in a workspace that deals with **Docker** containers. Simply run it from that folder and it will open a **VSCode** instance with the extensions from the previous script.


### Missing 'Open in VSCode' option from context menus in Windows

* In case you installed `VSCode` and forgot to fill the _'Add VSCode to conext menu'_
checkboxes in the wizard.
* Check the version of the `VSCode` installed because paths might differ!
* Run the script `AddVSCodeToContextMenu.reg` to add the context menu items.


### Remote SSH with RSA Key :key:

You can use **VSCode** to connect to a remote machine and edit `files` and `folders` on that machine.:eyeglasses:

:exclamation:Make sure you have installed the `Remote Development` extension pack.:exclamation:

Make sure :exclamation: you have the `id_rsa` file in the `C:/Users/myuser/.ssh` folder 
otherwise check this :point_right: :link: [Tutorial](https://github.com/octdobre/linux/blob/main/SSH/README.md#logging-in-with-rsa-keyskeykeywindows-side 'Create RSA Key') on how to create it.

Now run `Remote-SSH: Add New SSH Host...` command in `VSCode` to add the host entry
```
ssh -i ~/.ssh/config myremoteuser@192.168.1.100
```
This will create a file called `config` in the `C:/Users/myuser/.ssh` folder.

Contents of `config` should be like this:
```
Host 192.168.1.100
  HostName 192.168.1.100 
  User myremoteuser   
```

With `id_rsa` and `config` file setup run  `Remote-SSH: Connect to SSH Host...`
and start hacking! :eyeglasses::computer:

:point_right: :link: [More Here](https://code.visualstudio.com/docs/remote/ssh#:~:text=The%20Visual%20Studio%20Code%20Remote,anywhere%20on%20the%20remote%20filesystem. 'VSCode SSH')


### VSCode Important Folders
* `%APPDATA%\Code\User` - Location of User Data
* `%APPDATA%\Code\User\workspaceStorage` - Location of individual workspace settings
    * `workspace.json` is a `JSON` file that contains the `URI` of the workspace folder. 
	* `state.vscdb` (and `state.vscdb.backup`) are **SQLite3** files that contain the workspace information
* `%USERPROFILE%\.vscode\extensions` - Location of extensions




