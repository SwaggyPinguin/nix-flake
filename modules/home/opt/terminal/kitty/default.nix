{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.default.terminal == "kitty") {
    home.sessionVariables.TERMINAL = "kitty";
    programs.kitty = {
      enable = true;
      font = {
        name = userSettings.font;
        package = userSettings.fontPkg;
        size = 11;
      };
      theme = "Gruvbox Material Dark Medium";
      shellIntegration.enableZshIntegration = true;
      settings = {
        "enable_audio_bell" = false;
        "mouse_hide_wait" = 2;
        "remember_window_size" = "yes";
        "background_opacity" = "0.8";
        "background_blur" = 8;
      };
    };

    home.packages = with pkgs; [kitty kitty-themes zsh];
  };
}
