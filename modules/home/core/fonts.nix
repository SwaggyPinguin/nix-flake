{
  pkgs,
  userSettings,
  ...
}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    userSettings.fontPkg
    (nerdfonts.override {fonts = [userSettings.font];})
  ];
}
