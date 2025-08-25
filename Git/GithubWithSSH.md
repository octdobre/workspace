# Using GitHub repositories with SSH



## Step 1: Create a an asymetric key pair

Create a key-pair using either the `sshkeygen` or the PuttyGen sofrware.

### a. sshkeygen

Run this command in a terminal:
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Or using a later algorithm (ED25519):

```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Or in a custom folder
```
ssh-keygen -t rsa -b 4096 -f C:\path\to\your\custom\folder\my_custom_key
```

On Windows:
- A pair of files will be created under `.../users/username/.ssh` folder.
    - `id_rsa` is the private key
    - `id_rsa.pub` is the public key

Place both keys in a secure location.

### b. PuttyGen

Generate the key with puttygen.

Without closing the app do the following:

In putty-gen select the "Conversions" menu.

Select "Export to OpenSSH Key". 

This will convert the private key from ssh.com format to OpenSSH format.

Copy the public and private key to a secure place.

## Step 2: GitHub
Open the `id_rsa.pub` with a simple text editor and copy the contents.

Open GitHub and go to `Settings->SSH Keys`. Add the contents of the public key there.

## Step 3: Setup configuration file on Windows

Create a file called `config` under the `.../users/username/.ssh` folder.

The contents should look like this.
```
Host github.com
    HostName github.com
    User <github username as seen in the profile and not email address> 
    IdentityFile C:/<path to key using forward slashes>/name_of_rsa_file
```

Example:
```
Host github.com
    HostName github.com
    User my_github_username
    IdentityFile C:/folder/id_rsa
```

## Step 4: Test the connection

Open the terminal:
```
ssh -vT git@github.com -vvv
```

-vvv is used to display verbose details.

To check if the connection can be established successfully 
look through the output of the command untill you see something like:
```
Hi <github username>! You've successfully authenticated, but GitHub does not provide shell access.
```

This log line might not appear right at the end so you have to read through it all.

## Step 5: Clone the git repo using the HTTPS method and switch to SSH

Open a terminal in the folder where the repo would be cloned.

In the github page select Clone -> HTTPS.

The url should look like `https://github.com/octdobre/ai.git`.

Clone the repo using this method.

In the github page select Clone -> SSH and copy that url to clipboard.

 It shoud look like `git@github.com:octdobre/ai.git`.

Run the following command to change the authentication type from HTTPS to SSH.
```
git remote set-url origin git@github.com:octdobre/ai.git
```

To test it out, create a commit and push it to origin.

## Optional Securing the Keys on Windows

Open a CMD terminat. A CMD TERMINAL !!!

Run this two commands in these orders.

```
icacls <path_to_private_key> /inheritance:r 
```

And then

```
icacls <path_to_private_key> /grant:r "%username%":"(R)"                                                
```

Replace only the path and keep the rest. Don't replace "username". Don't.