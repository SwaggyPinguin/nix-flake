{
  config,
  pkgs,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [../../../modules/home ../../shared];

  modules = {
    herbstluftwm.enable = false;
    niri.enable = true;
    p10k.enable = false;
    tmux.enable = false;
    step-cli.enable = false;
    wireguard.enable = false;
    gtk.enable = builtins.hasAttr "theme" userSettings && userSettings.theme != "";
  };

  default = {
    shell = userSettings.shell;
    terminal = "kitty";
  };

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = systemSettings.stateVersion;
    enableNixpkgsReleaseCheck = false;
  };

  home.packages = with pkgs; [ niri ];

  programs.home-manager.enable = true;
}
