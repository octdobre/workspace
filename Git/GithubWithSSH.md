# Using GITHUB repositories with SSH



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

On Windows:
- A pair of files will be created under `.../users/username/.ssh` folder.
    - `id_rsa` is the private key
    - `id_rsa.pub` is the public key

Place both keys in a secure location.

### b. PuttyGen

Generate the key with puttygen.

Use the converted to convert the private key to OpenSSH format and copy the key to a secure place.

## Step 2: GitHub
Open the `id_rsa.pub` with a simple text editor and copy the contents.

Open GitHub and go to `Settings->SSH Keys`. Add the contents to the public key there.

## Step 3: Setup configuration file on Windows

Create a file called `config` under the `.../users/username/.ssh` folder.

The contents should look like this.
```
Host github.com
    HostName github.com
    User <github username>
    IdentityFile C:/<path to key using forward slashes>
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