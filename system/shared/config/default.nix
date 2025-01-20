{
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
	# ./services.nix 
	./sound.nix
  ];

  system = {
    stateVersion = systemSettings.stateVersion;
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nix = {
    # Fix nix path
    nixPath = [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "nixos-config=$HOME/.config/nix/system/${systemSettings.hostname}/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

    # Ensure nix flakes are enabled
    # package = pkgs.nixFlakes;
    settings.experimental-features = ["nix-command" "flakes"];

    # Garbage collect
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader = {
    # systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
    };
  };

  # define groups
  # optionally add user to group -> users.groups.plocate.members = [ ... ];
  users.groups = {
    plocate = {};
  };

  # Timezone and locale
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.defaultLocale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # Default shell
  environment.shells = with pkgs; [(pkgs.${userSettings.shell})];
  users.defaultUserShell = pkgs.${userSettings.shell};
  programs.${userSettings.shell}.enable = true;

  fonts = {
    packages = with pkgs; [(nerd-fonts.${userSettings.fontPkg})];
    fontDir.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
