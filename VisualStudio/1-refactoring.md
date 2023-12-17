# Visual Studio C# Series Part 1: Formatting and Refactoring

This is a **Visual Studio** series on the most important features available for a C# developer.

## Introduction

This article talks about the tools that help the developer write new and improve existing code.

There are many confusing namings of tools inside Visual Studio and this article will explore 
what they are and what they actually do.

## Table of Contents
- [**Text Editor**](#texteditor)
- [**Code Styles**](#codestyles)
- [**Code Cleanup**](#codecleanup)
- [**IntelliSense**](#intellisense)
- [**IntelliCode**](#intellicode)
- [**Code Lens**](#codelens)
- [**Code Snippets**](#codesnippets)
- [**Roslyn Analizers**](#roslyn)
- [**Code Coverage and Metrics**](#coverage)
- [**Glossary of terms**](#glossary)
- [**Documentation**](#docu)

<a name="texteditor"></a>
## Text Editor :clipboard:

### Tabs and Spaces - `EditorConfig support` :exclamation: 
`Tools > Options > Text Editor > [C# or Visual Basic] > Tabs` 

- This setting defines the `TAB` size and if `SPACEs` should be inserted instead of `TABs`.
- It also controlls `INDENTATION`.


- **Smart indenting** (Smart indenting is the option you want, provided 
you want the cursor to be correctly indented whenever you press `ENTER` 
or the `UP` and `DOWN` arrow keys in the code. An example is when you create 
a new method called Method1() and then hit `ENTER`. You’ll notice the cursor automatically indents
itself.)

---
### Visualizing `spaces` and `special characters`

`Tools > Options > Text Editor > General > Display > View Whitespaces`

- Visualise Whitespaces, line spacing spacing
- Visualise text control characters: formatting and other non-printing characters, such as `ACK, BEL, CR, FF, LF` and` VT`.

---
### Inline Hints
`Tools > Options > Text Editor > C# > Advanced > Inline Hints`

- The type of the variable appears alongside the variable name.
- Display hints while pressing `ALT+F1`.

---
### Brace pair colorization
`Tools > Options > Text Editor > General > Display > Enable brace pair colorization`

- Colors each pair of braces differently.
---
### Scroll Bar Enhancements
`Tools > Options > Text Editor > C# > Scroll Bars`

- The scroll bar can be enhanced to preview more information like:
    * selection
    * find results
    * git changes
    * errors
    * break points
    * bookmarks
- Map-mode shows a tiny preview of the file instead of a scroll bar: `Tools > Options > Text Editor > C# > Scroll Bars > Behaviour`

---
### File Encoding / Line endings
- To set the `file encoding` or `line ending` type, the `Advanced Save Options` menu must be exposed on the menu bar.
- To do that go to `Tools > Customize > Commands > Add new command > File > Advanced Save Options`
- Other line endings setting: `Edit > Advanced > Set End of Line Sequence`
---
### Basic editing
| Combination | Description |
|---|---|
| `SHIFT + ARROW LEFT/RIGHT` | Select characters to the left and right |
| `CTRL + ARROW LEFT/RIGHT` | Move throught tokens on the same line |
| `SHIFT + ARROW UP/DOWN` | Select lines above and below |
| `CTRL + SHIFT + ARROW LEFT/RIGHT`| Selects tokens to the left and right. |

Exercise code:
```
public class Test
    {
        int first = 10;
        int second = 20;
        int third = 30;
        int lastofitskind = 40;
    }
```
---
### Box editing/selection (Column selection)

| Combination | Description |
|---|---|
| `ALT + MOUSE DRAG` | Select block |
| `SHIFT + ALT + MOUSE CLICK`| Select block by clicking start and end `caret` position |
| `SHIFT + ALT + E` | Select entire line |
| `ALT + ARROW UP/DOWN` | Move entire line or block 1 line above or below |

---
### Multi-caret editing (Dark Magic)

| Combination | Description |
|---|---|
| `SHIFT + ALT + ARROW KEYS` | Create multi-line selection one char at a time, first expand horizontally and then vertically |
| `ARROW KEYS` | (THEN) After multi line selection, move all the carets to different positions |
| `SHIFT + ARROW KEYS` | (THEN) Expand selection one char at a time |
| `CTRL + SHIFT + ARROW KEYS` | (THEN) Expand selection one token at a time |
| `ALT + MOUSE DRAG VERTICALLY` | Insert multiple carets on same column horizontally |
| `CTRL + ALT + CLICK`| Multi-caret mode, place carets at multiple positions |
| `SHIFT + ALT + LCLICK` | (THEN) Create multiple carets to paste selection |
| `SHIFT + ALT + ;` | Insert carets at all matching locations |
| `SHIFT + ALT + .` | Insert carets at next matching location |

- If Windows is changing your language when typing `ALT+SHIFT` and then go to `Advanced Keyboard Settings` and set
the key combination to `Not assigned` in the the hotkeys menu.

---
### Expand or collapse block

| Combination | Description |
|---|---|
| `ALT + SHIFT + = ` | Expand block such as regions |
| `ALT + SHIFT + -`| Collapse block |
| `CTRL + M, CTRL + M`| Expand or collapse outlining |

---
### Find
| Combination | Description |
|---|---|
| `CTRL + F ` | Opens `Quick Search` window (also replace)|
| `CTRL + H ` | Opens `Quick Replace` window (also find)|
| `CTRL + SHIFT + F`| Opens `Find and Replace` window |
| `CTRL + SHIFT + H`| Opens `Replace in files` window |
| `CTRL + T` | Opens `Code Search` window (also `Feature Search`) (All-in-one-Search)|
| `CTRL + [, CTRL + S` | Finds the open file in solution explorer |
| `SHIFT + DBL CLICK` | Opens file from git changes (changes for file must be closed) |

---
### Code Block selection
| Combination | Description |
|---|---|
| `CTRL + SHIFT + ]` | Select block from including opening bracket to including closing bracket |
| `CTRL + ]` | Find another bracket in the pair (toggle between opening and closing bracket) |

<a name="codestyles"></a>
## Code Styles :dancer:

- This section defines the most important settings related to the formatting of code. 

- Most of these settings can be configured in a `.editorconfig` file.

### Code Styles General - `EditorConfig support ` :exclamation:
`Tools > Options > Text Editor > [C# or Visual Basic] > Code Style`

- Setting preferences for the following:
    * this
    * predefined types
    * var
    * code block
    * parenthesis
    * expression
    * pattern matching
    * variable
    * null checking
    * using
    * parameter
    * new lines

- These settings can be configured to give an a warning :warning: or an error :exclamation: or to deny :no_entry: compilation.

---
### Automatically format on `typing`, `;` `}` , `return`, `paste`.
`Tools > Options > Text Editor > [C# or Visual Basic] > Code Style > Formatting > General`

- This setting controls if formatting should happen when `typing`, or inserting a `;` `}`, `return`, or `paste`.

---
### Indentation settings - `EditorConfig support ` :exclamation:
`Tools > Options > Text Editor > [C# or Visual Basic] > Code Style > Formatting > Indentation`

- This setting controls how code should be indented based on other surrounding braces.

---
### New line settings (also **Angular Brackets**) - `EditorConfig support ` :exclamation:
`Tools > Options > Text Editor > [C# or Visual Basic] > Code Style > Formatting > New Lines`

- This setting is for adjusting placement of **Angular Brackets**.

---
### Code wrapping - `EditorConfig support ` :exclamation:
`Tools > Options > Text Editor > [C# or Visual Basic] > Code Style > Formatting > Wrapping`

- This setting is for adjusting if the code should be placed on the same or a different line.

---
### `using` Directives refactoring
`Tools > Options > Text Editor > C# > Advanced > Using Directives`
- Place `System usings` at the top.
- Suggest which `using` to import.
- Add missing `usings` on paste

---
### Naming conventions for members - `EditorConfig support ` :exclamation:
`Tools > Options > Text Editor > [C# or Visual Basic] > Code Style > Naming`

- This setting is for adjusting the naming conventions of the name of members or tokens.

---

<a name="codecleanup"></a>
## Code Cleanup  :bathtub:

### Shortcuts or Keyboard Bindings

| Combination | Description |
|---|---|
| `CTRL + K, CTRl + D` | Format Entire Document |
| `CTRL + K, CTRl + F` | Format Just Selection |

---
### Profiles
`Analyze > Code Cleanup`

- `Code Cleanup` profiles can be used to apply a set of refactorings called `fixers` to a file
or the entire solution on the go.
- **Visual Studio** has 2 Code cleanup profiles that can be customized with various `fixers`.
- A `fixer` is an individual tool. Example ("Remove unused variables.")
- To use it: `Analyze > Code Cleanup > Run Code Cleanup (Profile 1,2) on Solution`
- `Code Cleanup` can also be set to run on Save: `Tools > Options > Text Editor > Code Cleanup -> Run Code Cleanup on Save`

---
### Usefull C# `fixers` for Code Cleanup

- `File`:
    * Apply file header preferences
    * Remove usings
    * Sort Usings
- `Bracers`
    * Apply parentheses preferences
    * Add required braces for single-line control statements
    * Apply expression/block body preferences
- `General`
    * Remove unused suppressions
    * Apply using directive placement preferences
    * Apply using statement preferences
    * Apply simplify boolean expression preferences
    * Apply string interpolation preferences
    * Apply compound assignment preferences
    * Apply coalesce expression preferences
    * Add `this` or `Me` qualification
    * Apply conditional expression preferences
    * Apply tuple name preferences
    * Apply inferred anonymous type member name preferences
    * Apply null checking preferences
    * Apply null propagation preferences
    * Apply `var` preferences
    * Apply inline `out` variable preferences
    * Add required braces for single-line control statements
    * Apply pattern-matching preferences
    * Apply conditional delegate call preferences
    * Remove unnecessary casts
    * Apply default(T) preferences
    * Apply new() preferences
    * Apply range preferences
    * Apply local over anonymous function preferences
    * Apply parameter null preferences
    * Apply throw expression preferences
- `Objects, Properties`
    * Apply static local function preferences
    * Add accessibility modifiers
    * Order modifiers
    * Make field readonly
    * Apply object/collection initialization parameters)
    * Remove unused parameters
    * Apply auto property preferences
    * Apply deconstruct preferences
- `Variables`
     * Remove unused variables
     * Apply unused value preferences
---
### Editor Config(Open Source)
`Tools > Options > Text Editor > General > Follow project coding conventions`

* To enable the project to use a `.editorconfig` file:

---
<a name="intellisense"></a>
## IntelliSense - Code-Completion Aid, :exclamation: Not AI Assisted Code-Completions :exclamation:

### Shortcuts or Keyboard Bindings

| Combination | Hint | Description |
|---|---|---|
| `CTRL + J` | List Members/Force **IntelliSense** | Lists all members of a object. |
| `CTRL + SHIFT + SPACE` | Parameter info | Gives information about the number, names, and types of parameters required by a method, attribute generic type parameter (in C#). Must be inside the parameter list to activate. |
| `CTRL + K, CTRL + I` | Quick Info | Displays the complete declaration for any identifier in your code. |
| `CTRL + SPACE` | Complete Word | Completes the rest of a variable name, command name, or function name after you have entered enough characters to disambiguate the term. Option to complete word by pressing semi-colon `;`. |

---
### When it's not working

- The cursor is below a code error. 
- The cursor is in a code comment.
- The cursor is in a string literal.

---
### More IntelliSense Options

`Tools > Options > Text Editor > C# > IntelliSense`

- **Completion mode**: `Tools > Options > Text Editor > Advanced`
- **Code Lens**: `Allow code lens to display current caret line`
---
### Build + IntelliSense
- One can choose to Build and scan for **Intellisense** or just build.
- In the `Error List Window > Build + IntelliSense`
---
### Quick Actions and Refactorings (light bulb :bulb: and screwdriver :pushpin:)
- Offers code refactorings.
- Select a code block and then press `CTRL + .` or `ALT + ENTER` to show a quick refactoring dropdown menu.

Common quick actions:
- Fix spelling
- Resolve git merge conflict
- Remove unnecessary code
- Add missing code
- Code transformations

---
<a name="intellicode"></a>
## IntelliCode(AI-enhanced IntelliSense) - :thumbsup: AI Assisted Code Completions :thumbsup:

- **Visual Studio** **IntelliCode** provides *artificial intelligence-enhanced* **IntelliSense** completion lists. 
- **IntelliCode** predicts the most-likely correct API to use rather 
than just presenting an alphabetical list of suggestions. 
- It uses your current code context and patterns to provide the dynamic list, variable name , method name completions;
- Whole-line completion in gray, use `Tab` to apply.
- To start viewing **IntelliCode** completions, you must build 
the project once. :exclamation:

---
### Shortcuts or Keyboard Bindings

| Combination | Description |
|---|---|
| Start typing the token, wait, then `TAB` to apply the completion | IntelliCode Whole Line Completion |
| `CTRL + ALT +.` | Apply Suggestion |
| `CTRL + ALT +,` | Next Suggestion |

---
### To Start Training a Model
` View -> Other windows -> Intellicode`
- And then click on the `I would like to train...` checkbox and more options will appear.

---
### More IntelliCode Options
`Tools > Options > IntelliCode`

---
<a name="codelens"></a>
## Code Lens :mag_right:
`Tools > Options > Text Editor > All Languages > CodeLens.`

- *You can find references to a piece of code, changes to your code, linked bugs, Azure DevOps work items, code reviews, and unit tests.* (MS Docs exerpt)

| Combination | Description |
|---|---|
| `ALT + 2` | Find code references |
| `ALT + 5` | Find last commit |
| `ALT + 6` | View commit history |
| `ALT + 7` | View DevOps related tasks |
| `SHIFT + DOUBLE LCLICK`| Code Lens Go To Actual File From Git Changes |
| `ALT + F8` | Code Lens Peek Difference(Peek UI) |

---
<a name="codesnippets"></a>
## Code Snippets :scroll:

| Combination | Description |
| ---  | --- |
| `CTRL + K, CTRL + B` | Code Snippets Manager |
| `CTRL + K, CTRL + X` | Code Snippets Insert | 
| `CTRL + K, CTRL + S` | Code Snippets Surround | 

- There are 2 types of snippets:
    * extension
    * surround-with
- Access from the menu bar: `Edit > IntelliSense > Insert Snippet`
- Access from the context-menu: `Snippet > Insert Snippet`
- Code snippets have a short-form keyword.
- Type the keyword and press `TAB` twice.

---
<a name="roslyn"></a>
## Roslyn Analyzers :microscope: - `EditorConfig support ` :exclamation:

### Code Analysis

- Can be installed as nuget packages, and can be configured using `.editorconfig`.
- `Code Quality` are high level code analyzers which look for performance issues, security issues
or design issues.
- `Code Style` are low level analyzers to maintain code style in the codebase.

- An analyzer has 2 parts:
    * analysis part which can also be configured in the `.editorconfig` to produce errors or warnings
    * refactoring part which can offer Quick Actions to refactor the code

---
<a name="coverage"></a>
## Code Metrics
`Analyze > Calculate Code Metrics`

- **Roslyn Analyzers** can also be used to produce code metrics.
- Common code metrics:
    * Maintainability index
    * Cyclomatic complexity
    * Depth of inheritance
    * Coupling

---
## Code Coverage :straight_ruler:

- Shows how much code is covered by tests. **Visual Studio** highlights code that is covered.
- To analyze: `Test > Analyze Code Coverage for All Tests.`
- To show: `Code Coverage Results Window > Show Code Coverage Coloring`

---
## Other hotkeys :fire: :key:

| Combination | Description |
| ---  | --- |
| `CTRL + HOVER 2 SEC + LCLICK` | Go To Definition |
| `CTRL + SHIFT + V` | Show clipboard history |
| `CTRL + TAB`| IDE Navigator |

---
<a name="glossary"></a>
## Glossary of terms :book:

- **Visual Studio** namings can be confusing. Here is a glossary of feature names and what they do?

- `Inline hints`: The type of the variable appears alongside the variable name.
- `Box editing`: Selecting a box or characters inside a text editor.
- `Multi-caret editing`: Positioning multiple carets inside the text editor.
- `Code Styles`: Options in Visual Studio for text editing.
- `Code Cleanup`: A functionality to set and apply a set of code fixes to a document.
- `Code Cleanup Fixer`: An individual code fix.
- `Code Cleanup Profiles`: A set of code fixes that can be applied in one go.
- `EditorConfig`: An external file and open source format to define code fixes. Fixes can be applied with the `Code Cleanup` functionality.
- `IntelliSense`: Code-Aid for auto-completions and code introspection. Not AI-assisted Code Completions :exclamation:
- `Code-Completion`: Also known as **IntelliSense**.
- `Quick Actions and Refactorings`: Offers inline code refactoring recommendations.
- `IntelliCode`: Offers AI-Assisted code completions. Can build a model based on your entire codebase. :thumbsup:
- `Code Lens`: Offers versioning information about code: commits, work items, history.
- `Code Snippets`: Quick code writing through the form of complete-able code examples.
- `Roslyn Analyzers`: Libraries and framework for code introspection and refactoring suggestions.
- `Code Analysis`: A Roslyn-based library to analyze code and offer refactoring suggestions 
- `Code Metrics`: Measuring code complexity.
- `Code Coverage`: Measuring code lines covered by tests.

---
<a name="docu"></a>
## Documentation :books:

:link: [Text Editor](https://learn.microsoft.com/en-us/visualstudio/ide/reference/options-text-editor-general?view=vs-2022)

:link:[Text Editing Shoftcuts](https://docwiki.embarcadero.com/RADStudio/Alexandria/en/Visual_Studio_Keyboard_Shortcuts)

:link:[IntelliSense](https://learn.microsoft.com/en-us/visualstudio/ide/using-intellisense?view=vs-2022)

:link:[Common quick actions](https://learn.microsoft.com/en-us/visualstudio/ide/common-quick-actions?view=vs-2022&tabs=csharp)

:link:[IntelliCode](https://visualstudio.microsoft.com/services/intellicode/)

:link:[Inline Hints](https://bartwullems.blogspot.com/2021/12/visual-studio-2022inline-hints.html)

:link:[Code tyle options and code cleanup](https://learn.microsoft.com/en-us/visualstudio/ide/code-styles-and-code-cleanup?view=vs-2022)

:link:[Code Lens](https://learn.microsoft.com/en-us/visualstudio/ide/find-code-changes-and-other-history-with-codelens?view=vs-2022)

:link:[Code Snippets Overview](https://learn.microsoft.com/en-us/visualstudio/ide/code-snippets?view=vs-2022)

:link:[Code Snipper Creation](https://learn.microsoft.com/en-us/visualstudio/ide/walkthrough-creating-a-code-snippet?view=vs-2022)

:link:[Visual Studio Text Editing](https://www.meziantou.net/visual-studio-tips-and-tricks-multi-line-and-multi-cursor-editing.htm)

:link:[Rosly Code Analyzers Editorconfig](https://www.mytechramblings.com/posts/configure-roslyn-analyzers-using-editorconfig/)

:link:[Rosly Code Analyzers Code Analysis](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview?tabs=net-7)

:link:[Rosly Code Analyzers Code Metrics](https://learn.microsoft.com/en-us/visualstudio/code-quality/how-to-generate-code-metrics-data?view=vs-2022)

:link:[Code Coverage](https://learn.microsoft.com/en-us/visualstudio/test/using-code-coverage-to-determine-how-much-code-is-being-tested?view=vs-2022&tabs=csharp)

:link:[VS Productivity Tips](https://learn.microsoft.com/en-us/visualstudio/ide/csharp-developer-productivity?view=vs-2022)

:link:[VS Productivity Shortcuts](https://learn.microsoft.com/en-us/visualstudio/ide/productivity-shortcuts?view=vs-2022)