{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = config.programs.nushell.enable;
    enableZshIntegration = config.programs.zsh.enable;
    # enableBashIntegration = config.programs.bash.enable;
  };

  home.packages = with pkgs; [zoxide];
}
