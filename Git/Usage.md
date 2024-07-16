# Git usage, tips and tricks

Git is a distributed version control system (DVCS) designed for speed, data integrity, and support for non-linear workflows.

 It operates by maintaining a complete history of changes in a local repository, allowing for efficient branching and merging.


## Repositories

### Create a local repository

Create a folder and open the command line in that folder:
```
git init
```

Clone existing repository from another source:
```
git clone <repo url>
```
To clone without creating a folder:
```
git clone <repo url> .
```

Clone a repository and set a specific branch as active:
```
git clone --branch <branch_name> <remote repository url> . 
```

### Create a local pointing to a remote

Create folder and:
```
git init
```
Set the remote origin:
```
git remote add origin <urlhere>
```
Pull the branch:
```
git pull
```
You must checkout the master branch(or whatever is it called in your repo):
```
git checkout master
```

## Commits

The common git workflow is as follows:
* Check the status of which files are added to the commit pool:
```
git status
```

* Add files to the current commit changes pool:
```
git add SomeTxtFile.txt
```

* Commit the changes (Don't forget to add a message!):
```
git commit -m "Added SomeTxtFile.txt"
```

* Fetch changes from remote(commits, history, refs)
```
git fetch
```

* Push the changes into the repository:
```
git pull
```

### Remove
Remove local changes from the unstaged pool that have not yet been staged(added to stage pool):
```
git restore .
```
Demote changes from staged pool to unstaged pool:
```
git restore --staged .
```

### Reset

### Revert

The `git revert` command is used to create a new commit that undoes the changes introduced by a previous commit.
Starting history:
```
A -- B -- C -- D -- E (HEAD)
```

Run `git revert C`

This action will create a new commit that undoes the changes made by commit C:

The new history:
```
A -- B -- C -- D -- E -- C' (HEAD)
```

Typical flow:
```
git log
git revert CommitId
git add .
git commit
```

## Branches

View all remote branches:
```
git fetch --all
git branch -r
```

Change to another branch(it becomes active):
```
git checkout <branch_name>
```

Create new branch from existing one(and make it active):
```
git checkout -b <new branch> <existing>
```

Create branch locally from remote branch:
```
git checkout -b <branch_name>  origin/<branch_name>
```

Push a locally created branch to remote:
```
git push origin <branch_name>
```

### View current working branch
Navigate to the `.git` folder:
```
cd .git
```
View the contents of the HEAD file:
```
cat HEAD
```
View the commit Id:
```
cat refs/heads/<branch_name>
```

## Merging

### Resolving conflicts

Pull the master branch:
```
git pull origin master
```
Diff the files:
```
git diff <filename>
```
Merge the files in a text editor and save.

Commit the changes:
```
git commit -m "<insert message here>"
```

### Tools

To view if there are changes:
```
git status
```
To view the content of the changes:
```
git diff
```
To show changes between HEAD and current:
```
git diff HEAD <current_branch>
```
To show changes between any two branches:
```
git diff <to_compare_to_branch_name> <current_branch>
```
To show changes between any two commits:
```
git diff <commit_id_1> <commit_id_2>
```
To view pretty changes:
```
git log -pretty=oneline
```
View and step through history:
```
git blame  <filename>
```
View history for a specific area in a file:
```
git blame -L <starting line, ending line>  <filename>
git blame -L 5,1  file1.txt
```

## Configuration

Show current user:
```
git config user.email
```

Show gitconfig values
```
git config --list --show-origin --show-scope
```

### Replace remote origin

```
git remote set-url origin <copy this from either the HTTPS or the SSH textboxes>      
```

## Troubleshooting

View history:
```
git log
```

Use `q` to get out of the menu.


## Documentation


:point_right::link:[GIT Cheat Sheet](https://d3c33hcgiwev3.cloudfront.net/SspDywPOSySKQ8sDzrskYA_e4f25a0bc3f44a89a282db515ce821e1_github-git-cheat-sheet.pdf?Expires=1721174400&Signature=Yyfwpx8BWXrHgK2MdY63rOQJvgjsCCUQDc6N99f~rZGPYoAJAWC3CJY9fugDm4gVYKT8Uu~SoS1gAcqI3XLTX~oULiFAji9tl7Xxypl4l5cSE6b8yrXPgV56xs01U~tkDa-Kmni6VzykTjSl3aEyDW2OBQwPmAW2H4G772gjQq0_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A)

[Git cheat sheet](https://education.github.com/git-cheat-sheet-education.pdf)

[Git patterns and antipatterns](https://www.youtube.com/watch?v=t_4lLR6F_yk)

[Linus Tovals on Git](https://www.youtube.com/watch?v=4XpnKHJAok8)