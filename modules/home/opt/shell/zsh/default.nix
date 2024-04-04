{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.default.shell == "zsh") {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = import ../aliases.nix {};
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      # dotDir = ".config/zsh";

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = ["git" "aliases" "docker"];
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    home.packages = with pkgs; [oh-my-zsh zoxide eza];
  };
}
