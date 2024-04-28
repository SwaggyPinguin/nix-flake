{
  pkgs,
  userSettings,
  ...
}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (pkgs.${userSettings.fontPkg})
    sf-mono-liga-bin
    (nerdfonts.override {fonts = [userSettings.font];})
  ];
}
