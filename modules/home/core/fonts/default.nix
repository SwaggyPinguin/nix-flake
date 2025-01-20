{
  pkgs,
  userSettings,
  ...
}: let
  apple-fonts = pkgs.callPackage ./apple-fonts.nix {};
in {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (pkgs.${userSettings.fontPkg})
    (nerd-fonts.${userSettings.fontPkg})
    sf-mono-liga-bin
    apple-fonts
  ];
}
