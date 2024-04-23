{
  config,
  lib,
  pkgs,
  inputs,
  pkgs-emacs,
  ...
}: {
  imports = [
    inputs.nix-doom-emacs.hmModule
  ];

  config = lib.mkIf config.modules.emacs.enable {
    programs.doom-emacs = {
      enable = true;
      emacsPackage = pkgs-emacs.emacs29-pgtk;
      doomPrivateDir = ./doom.d;
    };

    # programs.emacs = {
    #   enable = true;
    #   package = pkgs.emacs;
    #   # extraConfig = '''';
    # };

    home.packages = with pkgs-emacs; [
    ];

    # home.file.".emacs.d/config.el" = {
    #   source = "~/.config/doom/config.el";
    #   recursive = true;
    # };

    # home.file.".emacs.d/init.el" = {
    #   source = "~/.config/doom/init.el";
    #   recursive = true;
    # };

    # home.file.".emacs.d/packages.el" = {
    #   source = "~/.config/doom/packages.el";
    #   recursive = true;
    # };

    # home.file.".emacs.d/custom.el" = {
    #   source = "~/.config/doom/custom.el";
    #   recursive = true;
    # };
  };
}
