{
  description = "A very basic flake of SwaggyPinguin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Doom Emacs
    emacs-pin-nixpkgs.url = "nixpkgs/f72123158996b8d4449de481897d855bc47c7bf6";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "emacs-pin-nixpkgs";

    nix-straight.url = "github:librephoenix/nix-straight.el/pgtk-patch";
    nix-straight.flake = false;
    nix-doom-emacs.inputs.nix-straight.follows = "nix-straight";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "kamino"; # TODO: make dynamic
      stateVersion = "23.11";
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
      editor = "nvim";
      extraEditors = ["emacs"];
      browser = "google-chrome";
    };

    # create patched nixpkgs
    nixpkgs-patched = (import nixpkgs {system = systemSettings.system;}).applyPatches {
      name = "nixpkgs-patched";
      src = nixpkgs;
      patches = [./modules/patches/emacs-no-version-check.patch];
    };

    pkgs = import nixpkgs-patched {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    pkgs-emacs = import inputs.emacs-pin-nixpkgs {
      system = systemSettings.system;
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
          inherit pkgs-emacs;
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
    };
  };
}
