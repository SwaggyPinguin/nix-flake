{
  config,
  lib,
  pkgs,
  ...
}: let
  zsh = config.default.shell == "zsh";
  p10k = config.modules.p10k.enable;
in {
  config = lib.mkIf (zsh && p10k) {
    programs.zsh.plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}
