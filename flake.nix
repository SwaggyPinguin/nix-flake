{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "herbstnix";
        stateVersion = "23.11";
      };

      userSettings = {
        username = "noah";
        name = "noah";
        email = "noahdahms@gmail.com";
      };

      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
    in {
      formatter.${systemSettings.system} = pkgs.nixfmt;

      settings.experimental-features = [ "nix-command" "flakes" ];

      homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
}
