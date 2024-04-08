{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.wireguard.enable {
    home.packages = with pkgs; [
      wireguard-tools
      wg-netmanager
    ];
  };
}
