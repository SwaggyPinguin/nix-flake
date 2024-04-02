{ config, lib, pkgs, userSettings, ... }: {
  config = lib.mkIf (config.default.terminal == "kitty") {
    home.sessionVariables.TERMINAL = "kitty";
    programs.kitty = {
      enable = true;
      font = {
        name = userSettings.font;
        size = 11;
      };
      theme = "Gruvbox Material Dark Medium";
      shellIntegration.enableZshIntegration = true;
    };

    home.packages = with pkgs; [ kitty kitty-themes zsh ];
  };
}
