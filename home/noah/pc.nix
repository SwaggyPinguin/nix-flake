{
  config,
  pkgs,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [../../modules/home ../shared];

  modules = {
    herbstluftwm.enable = false;
    p10k.enable = true;
    tmux.enable = true;
    step-cli.enable = false;
    wireguard.enable = false;
  };

  default = {
    shell = "zsh";
    terminal = "kitty";
  };

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = systemSettings.stateVersion;
    enableNixpkgsReleaseCheck = false;
  };

  home.packages = with pkgs; [];

  home.sessionVariables = {EDITOR = "nvim";};

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  programs.home-manager.enable = true;
}
