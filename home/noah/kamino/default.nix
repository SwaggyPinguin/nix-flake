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
    p10k.enable = true;
    tmux.enable = true;
    step-cli.enable = false;
    wireguard.enable = false;
    emacs.enable = builtins.elem "emacs" userSettings.extraEditors;
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

  home.packages = with pkgs; [];

  programs.home-manager.enable = true;
}
