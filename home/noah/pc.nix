{ config, pkgs, userSettings, systemSettings, ... }: {
  imports = [ ../../modules/home ];

  modules = { herbstluftwm.enable = false; };

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

  home.packages = with pkgs; [
    vim
    neovim
    curl
    wget
    libgcc
    zig
    vscode
    direnv
    nix-direnv
    nixfmt
  ];

  home.sessionVariables = { EDITOR = "nvim"; };

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  programs.home-manager.enable = true;
}
