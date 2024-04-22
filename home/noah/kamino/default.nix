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
