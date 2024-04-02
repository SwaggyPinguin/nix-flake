# Installation

## Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Clone the repository

```bash
git clone https://github.com/SwaggyPinguin/nix-flake.git
```

## Install Home-Manager with the Flake

```bash
nix build '.#homeConfigurations."noah@pc".activationPackage'
./result/activate
rm -rf result/activate

# or run
nix run nixpkgs#home-manager -- build --flake .#noah@pc switch
```

### Use Home-Manager

After the installation of Home-Manager use this command.

```bash
home-manager switch --flake .#noah@pc
# or
just home
```
