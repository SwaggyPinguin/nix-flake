{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.default.terminal == "ghostty") {
    home.sessionVariables.TERMINAL = "ghostty";
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      installVimSyntax = true;
      installBatSyntax = true;
      settings = {
        # "font-family" = "JetBrains Mono Nerd Font";
        "font-family" = userSettings.nerdFont;
        "font-size" = 11;
        "clipboard-trim-trailing-spaces" = true;
        "clipboard-paste-protection" = true;
        "copy-on-select" = true;
      };
      themes = "GruvboxDark";
    };

    home.packages = with pkgs; [ghostty];

    # home.file = {
    #   ".config/ghostty".source = ../../../dotfiles/.config/ghostty;
    # };
  };
}
