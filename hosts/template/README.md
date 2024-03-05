# Template config

## Adding new hosts

### Setup

Start by creating a directory for the new host, and copying the template files from this directory to it.

Then register the new configuration file in this repository's root flake.

### Configuring the new host

On the new host, first ensure that you are connected to the internet.
Networkmanager and related tools should come pre-installed.

Next, plug in an authentication key, enter a nix shell with the appropriate packages, and clone the nixos configuration repository:

_Note: I use a yubikey to add a pre-existing ssh key. You may have to create a new one if you are using a private repository, or fetch any other required packages._

```sh
nix-shell -p git # enter shell with git installed
eval $(ssh-agent) # Start ssh agent
ssh-add -K # Add key
git clone git@github.com:Bliztle/.nixos.git # Clone configuration repository
cd .nixos # Enter repository to allow git commands
cp /etc/nixos/hardware-configuration.nix hosts/<host name>/ # Copy hardware configuration to repo
git add -A # Need to stage the hardware configuration to allow flake to compile. Otherwise it will not be able to find it.
```

Your new host should now be good to go. Just compile your system and reboot.

```sh
sudo nixos-rebuild switch --flake ~/.nixos/#<host name>
sudo reboot now
```
