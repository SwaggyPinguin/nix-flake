_default:
    just --list

# Nix flake check
check:
    nix flake check

# Install flake and Home-Manager
install profile="pc":
    nix run nixpkgs#home-manager -- build --flake '.#noah@{{ profile }}' switch

# Update and switch flake
update profile="pc":
    nix flake update && just home {{ profile }}

# Home-Manager switch, default is pc
home profile="pc":
    home-manager switch --flake '.#noah@{{ profile }}'

# NixOS switch, default is pc
rebuild profile="pc":
    sudo nixos-rebuild switch --flake '.#{{ profile }}'