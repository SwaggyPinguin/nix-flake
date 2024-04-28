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
      shellAliases = import ../aliases.nix {inherit pkgs;};
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

    # add this if defaultShell can't be managed with nix (non-nixos systems)
    # autostart zsh
    programs.bash = {
      enable = true;
      shellAliases = import ../aliases.nix {inherit pkgs;};
      # initExtra = "exec zsh";
    };

    home.packages = with pkgs; [oh-my-zsh zoxide];
  };
}
