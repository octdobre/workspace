# Git Usage, Tips and Tricks 🚀

> **Git** is a distributed version control system (DVCS) designed for speed, data integrity, and support for non-linear workflows. It operates by maintaining a complete history of changes in a local repository, allowing for efficient branching and merging.

---

## 📁 Repositories

### Create a Local Repository

**Create a folder and open the command line in that folder:**

```bash
git init
```

**Clone existing repository from another source:**

```bash
git clone <repo-url>
```

**To clone without creating a folder:**

```bash
git clone <repo-url> .
```

**Clone a repository and set a specific branch as active:**

```bash
git clone --branch <branch-name> <remote-repository-url> .
```

### Create a Local Repo and Point to Remote Origin

**Step-by-step process:**

1. **Create folder and initialize:**
   ```bash
   git init
   ```

2. **Set the remote origin:**
   ```bash
   git remote add origin <url-here>
   ```

3. **Pull the branch:**
   ```bash
   git pull
   ```

4. **Checkout the master branch (or whatever it's called in your repo):**
   ```bash
   git checkout master
   ```

---

## 💾 Commits

### Common Git Workflow

The typical git workflow follows these steps:

1. **Check the status** of which files are added to the commit pool:
   ```bash
   git status
   ```

2. **Add files** to the current commit changes pool:
   ```bash
   git add SomeTxtFile.txt
   # Or add all files
   git add .
   ```

3. **Commit the changes** (Don't forget to add a message!):
   ```bash
   git commit -m "Added SomeTxtFile.txt"
   ```

4. **Fetch changes** from remote (commits, history, refs):
   ```bash
   git fetch
   ```

5. **Push the changes** into the repository:
   ```bash
   git push
   ```

### Remove Changes

**Remove local changes** from the unstaged pool that have not yet been staged:
```bash
git restore .
```

**Demote changes** from staged pool to unstaged pool:
```bash
git restore --staged .
```

---

## 🔄 Reset & Revert

### Reset

> **Note:** Reset section content to be added here.

### Revert

The `git revert` command is used to create a new commit that undoes the changes introduced by a previous commit.

**Starting history:**
```
A -- B -- C -- D -- E (HEAD)
```

**Run `git revert C`**

This action will create a new commit that undoes the changes made by commit C:

**The new history:**
```
A -- B -- C -- D -- E -- C' (HEAD)
```

**Typical revert flow:**
```bash
git log
git revert <CommitId>
git add .
git commit
```

---

## 🌿 Branches

### Branch Management

**View all remote branches:**
```bash
git fetch --all
git branch -r
```

**Change to another branch** (it becomes active):
```bash
git checkout <branch-name>
```

**Create new branch** from existing one (and make it active):
```bash
git checkout -b <new-branch> <existing-branch>
```

**Create branch locally** from remote branch:
```bash
git checkout -b <branch-name> origin/<branch-name>
```

**Push a locally created branch** to remote:
```bash
git push origin <branch-name>
```

### View Current Working Branch

**Navigate to the `.git` folder:**
```bash
cd .git
```

**View the contents of the HEAD file:**
```bash
cat HEAD
```

**View the commit ID:**
```bash
cat refs/heads/<branch-name>
```

---

## 🔀 Merging

### Resolving Conflicts

**Pull the master branch:**
```bash
git pull origin master
```

**Diff the files:**
```bash
git diff <filename>
```

**Merge the files** in a text editor and save.

**Commit the changes:**
```bash
git commit -m "<insert message here>"
```

---

## 🛠️ Tools & Utilities

### Status & Diff Commands

**To view if there are changes:**
```bash
git status
```

**To view the content of the changes:**
```bash
git diff
```

**To show changes between HEAD and current:**
```bash
git diff HEAD <current-branch>
```

**To show changes between any two branches:**
```bash
git diff <to-compare-to-branch-name> <current-branch>
```

**To show changes between any two commits:**
```bash
git diff <commit-id-1> <commit-id-2>
```

### History & Logging

**To view pretty changes:**
```bash
git log --pretty=oneline
```

**View and step through history:**
```bash
git blame <filename>
```

**View history for a specific area in a file:**
```bash
git blame -L <starting-line,ending-line> <filename>
# Example:
git blame -L 5,10 file1.txt
```

---

## ⚙️ Configuration

### User Configuration

**Show current user:**
```bash
git config user.email
```

**Show gitconfig values:**
```bash
git config --list --show-origin --show-scope
```

### Remote Management

**Replace remote origin:**
```bash
git remote set-url origin <copy-this-from-either-the-HTTPS-or-the-SSH-textboxes>
```

---

## 🔧 Troubleshooting

### Common Commands

**View history:**
```bash
git log
```

> **Tip:** Use `q` to exit the log viewer.

**View detailed status:**
```bash
git status --verbose
```

**Check remote connections:**
```bash
git remote -v
```

---

## 📚 Documentation & Resources

### Official Resources

- 📖 **[Git Cheat Sheet](https://d3c33hcgiwev3.cloudfront.net/SspDywPOSySKQ8sDzrskYA_e4f25a0bc3f44a89a282db515ce821e1_github-git-cheat-sheet.pdf?Expires=1721174400&Signature=Yyfwpx8BWXrHgK2MdY63rOQJvgjsCCUQDc6N99f~rZGPYoAJAWC3CJY9fugDm4gVYKT8Uu~SoS1gAcqI3XLTX~oULiFAji9tl7Xxypl4l5cSE6b8yrXPgV56xs01U~tkDa-Kmni6VzykTjSl3aEyDW2OBQwPmAW2H4G772gjQq0_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A)** - Comprehensive Git reference
- 🎓 **[Git Cheat Sheet (Education)](https://education.github.com/git-cheat-sheet-education.pdf)** - GitHub's educational Git guide
- 🎥 **[Git Patterns and Antipatterns](https://www.youtube.com/watch?v=t_4lLR6F_yk)** - Best practices video
- 🎥 **[Linus Torvalds on Git](https://www.youtube.com/watch?v=4XpnKHJAok8)** - Git creator's insights

### Additional Resources

- 📖 [Git Documentation](https://git-scm.com/doc)
- 🎓 [GitHub Learning Lab](https://lab.github.com/)
- 📝 [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)

---

<div align="center">

**Happy Coding! 🎉**

*Remember: Git is your friend, not your enemy!*

</div>