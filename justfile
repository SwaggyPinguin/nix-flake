_default:
    just --list

# Installation of Nix and setup of Nix the Nix flake
setup profile="kamino": 
	@echo Installing Nix...
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
	nix run nixpkgs#just -- install {{ profile }}

# Nix flake check
check:
    nix flake check

# Install flake and Home-Manager
install profile="kamino":
	@echo Installing Home-Manager and setting up home configuration...	
	nix run nixpkgs#home-manager -- build --flake '.#noah@{{ profile }}' switch

# Update and switch flake
update profile="kamino":
	@echo Updating flake and home configuration...
	nh os switch --update . --hostname {{ profile }} && nix flake update && just home {{ profile }}
	# nix flake update && just home {{ profile }}

# Home-Manager switch, default is kamino
home profile="kamino":
	@echo Rebuilding home configuration...
	# home-manager switch --flake '.#noah@{{ profile }}'
	nh home switch . -c 'noah@{{ profile }}'

# NixOS switch, default is kamino
os profile="kamino":
	@echo Rebuilding system configuration...
	# sudo nixos-rebuild switch --flake '.#{{ profile }}'
	nh os switch . --hostname {{ profile }}

# Rebuild Home-Manager and OS
all profile="kamino":
	just os {{ profile }}
	just home {{ profile }}

# List installed packages with Home-Manager
packages:
	home-manager packages
