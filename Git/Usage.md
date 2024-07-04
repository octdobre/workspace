# Git usage, tips and tricks

Git is a distributed version control system (DVCS) designed for speed, data integrity, and support for non-linear workflows.

 It operates by maintaining a complete history of changes in a local repository, allowing for efficient branching and merging.


## Repositories

Create a local repository:
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

# Merging

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