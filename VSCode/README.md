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


### VSCode Important Folders
* `%APPDATA%\Code\User` - Location of User Data
* `%APPDATA%\Code\User\workspaceStorage` - Location of individual workspace settings
    * `workspace.json` is a `JSON` file that contains the `URI` of the workspace folder. 
	* `state.vscdb` (and `state.vscdb.backup`) are **SQLite3** files that contain the workspace information
* `%USERPROFILE%\.vscode\extensions` - Location of extensions