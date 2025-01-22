{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    # ./binds.nix
    # ./rules.nix
  ];

  config = lib.mkIf config.modules.niri.enable {
    home.packages = with pkgs; [
      # niri
      seatd
    ];
  };
}
