# WSL

### Enable WSL Pre-Windows 11

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

### Useful Commands

View installed **WSL** distros.

`wsl --list --verbose`

Terminate a running distro to free up ram.

`wsl -t <DistributionName>`

Set version of distro to WSL2.

`wsl --set-version Ubuntu 2`

Set Default.

`wsl --setdefault <DistributionName>`

Export.

`wsl --export Ubuntu D:\backup\ubuntu.tar`

Unregister. It will remove it.

`wsl --unregister Ubuntu`

Import.

`wsl --import Ubuntu D:\wsl\ D:\backup\ubuntu.tar`

You can navigate inside a WSL Distro using Explorer.

`\\wsl$\Ubuntu`

### Port Forwarding from a WSL instance

**WSL** instances are like `virtual machines`. Once a **WSL** instance is opened `ports` are not forwarded by default. 
If there is an intention to run a service on a **WSL** instance and be able to access it from the **Windows** `localhost`, `port` forwarding is required, as with a `VM` running on **Hyper-V**.

Here are some commands to help with `port` forwarding:

Get the `IP` address of the default `ethernet interface` from the **WSL** instance. Run this command in the **WSL** `shell`.

```
ip address
```

The output:

```
...
6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7b:c4:66 brd ff:ff:ff:ff:ff:ff
    inet 172.27.151.37/20 brd 172.27.159.255 scope global eth0
```

The desired `interface` is `eth0`. 

Create a `proxy interface`, assing the `connectaddress` as the `ip` and forward the desired `port`.
```
netsh interface portproxy add v4tov4 listenport=8000 listenaddress=0.0.0.0 connectport=8000 connectaddress=172.27.151.37
```
To clean up, remove the `proxy` and free the `port`.

```
netsh interface portproxy delete v4tov4 listenport=8000 listenaddress=0.0.0.0
```

Check if the `proxy` and `ports` are still used.

```
netsh interface portproxy show v4tov4
```


### Documentation :books:
* :link:[WSL2](https://www.sitepoint.com/wsl2/ "WSL2")