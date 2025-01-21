{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.herbstluftwm.enable {
    imports = [ 
      inputs.niri.homeModules.niri
      ./settings.nix
      # ./binds.nix
      # ./rules.nix
    ];

    home.packages = with pkgs; [kitty kitty-themes zsh];
  };
}