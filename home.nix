{ pkgs, userSettings, systemSettings, ... }: {
  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = systemSettings.stateVersion;
    enableNixpkgsReleaseCheck = false;
  };

  imports = [ ./modules ./modules/git.nix ];

  modules = { herbstluftwm.enable = true; };

  home.packages = with pkgs; [ vim neovim curl wget libgcc zig ];

  home.sessionVariables = { EDITOR = "nvim"; };

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  programs.home-manager.enable = true;
}
