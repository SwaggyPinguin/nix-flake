{
  description = "A very basic flake of SwaggyPinguin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SFMono w/ patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "mustafar"; # TODO: make dynamic
      stateVersion = "24.11";
      timezone = "Europe/Berlin";
      locale = "de_DE.UTF-8";
      defaultLocale = "en_US.UTF-8"; # used for system language
    };

    userSettings = {
      username = "noah"; # TODO: make dynamic
      name = "Noah Dahms";
      email = "noahdahms@gmail.com";
      font = "JetBrainsMono";
      nerdFont = "JetBrainsMono Nerd Font";
      fontPkg = "jetbrains-mono";
      shell = "zsh";
      terminal = "ghostty";
      editor = "nvim";
      extraEditors = ["emacs"];
      browser = "google-chrome";
      # theme = "gruvbox";
    };

    pkgs = import nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  in {
    formatter.${systemSettings.system} = pkgs.alejandra;

    # usage: 'home-manager switch --flake .#<user@hostname>'
    homeConfigurations = {
      "noah@kamino" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [./home/noah/kamino];
        extraSpecialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };

      "noah@mustafar" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [./home/noah/mustafar];
        extraSpecialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    nixosConfigurations = {
      kamino = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        modules = [./system/kamino];
        specialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit systemSettings;
          inherit userSettings;
        };
      };

      mustafar = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        modules = [./system/mustafar];
        specialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
}
