{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # if kitty is not working try this
    # nixgl.url = "github:nix-community/nixGL";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    # nixgl,
    ...
  }: let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "herbstnix";
      stateVersion = "23.11";
    };

    userSettings = {
      username = "noah";
      name = "noah";
      email = "noahdahms@gmail.com";
      font = "JetBrainsMono Nerd Font";
      fontPkg = pkgs.jetbrains-mono;
    };

    pkgs = import nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
      # overlays = [ nixgl.overlay ];
    };
  in {
    formatter.${systemSettings.system} = pkgs.alejandra;

    settings.experimental-features = ["nix-command" "flakes"];

    # usage: 'home-manager switch --flake .#noah@pc'
    homeConfigurations = {
      "noah@pc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [./home/noah/pc.nix];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
}
