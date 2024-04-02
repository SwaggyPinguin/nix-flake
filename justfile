_default:
    just --list

# Nix flake check
check:
    nix flake check

# Home-Manager switch, default is pc
home profile="pc":
    home-manager switch --flake '.#noah@{{ profile }}'

# NixOS switch, default is pc
rebuild profile="pc":
    sudo nixos-rebuild switch --flake '.#{{ profile }}'