{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: let
  userTheme = import ./gtk-${userSettings.theme}.nix {inherit pkgs;};
in {
  config = lib.mkIf config.modules.gtk.enable {
    gtk = {
      enable = true;
      theme = userTheme;
    };

    home.packages = with pkgs; [gtk-engine-murrine];
  };
}
