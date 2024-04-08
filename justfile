_default:
    just --list

# Installation of Nix and setup of Nix the Nix flake
setup profile="pc": 
	@echo Installing Nix...
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
	nix run nixpkgs#just -- install {{ profile }}

# Nix flake check
check:
    nix flake check

# Install flake and Home-Manager
install profile="pc":
	@echo Installing Home-Manager and setting up home configuration...	
	nix run nixpkgs#home-manager -- build --flake '.#noah@{{ profile }}' switch

# Update and switch flake
update profile="pc":
	@echo Updating flake and home configuration...
	nix flake update && just home {{ profile }}

# Home-Manager switch, default is pc
home profile="pc":
	@echo Rebuilding home configuration...
	home-manager switch --flake '.#noah@{{ profile }}'

# NixOS switch, default is pc
rebuild profile="pc":
	@echo Rebuilding system configuration...
	sudo nixos-rebuild switch --flake '.#{{ profile }}'
