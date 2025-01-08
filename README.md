# Installation

## Install Nix

The first thing you need to do is installing nix. After the the installation of Nix you can go on with the next steps.

To install nix run the following command in your terminal.

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Clone the repository

After the installation of nix you have to clone this repository.

```bash
nix --extra-experimental-features "nix-command flakes" run nixpkgs#git -- clone https://github.com/SwaggyPinguin/nix-flake.git ~/.config/nix
```

## Setup and manage configuration

The following commands can be used to setup and install this configuration.

Go into the cloned repository folder and run this command to install home manager with the current configuration inside the flake.
To get an overview of all possible commands run this command.

```bash
# if you have `just` installed
just 
# or 
just --list

# without `just` installed
nix run nixpkgs#just -- --list
```

Listing all commands will look like this:
`NOTE` The following commands require `just` to be installed (it will be installed after completing the setup.

```bash
just --list
Available recipes:
    check                # Nix flake check
    home profile="pc"    # Home-Manager switch, default is pc
    install profile="pc" # Install flake and Home-Manager
    rebuild profile="pc" # NixOS switch, default is pc
    setup profile="pc"   # Installation of Nix and setup of Nix the Nix flake
    update profile="pc"  # Update and switch flake
```

You can provide an optional host to choose which configuration should be installed. The default value is `pc`.

```bash
# with default value
nix run nixpkgs#just -- setup

# whith a specific host
nix run nixpkgs#just -- setup pc
```

To rebuild the home configuration you can run:

```bash
just home # you can provide an optional host to choose the configuration
```
