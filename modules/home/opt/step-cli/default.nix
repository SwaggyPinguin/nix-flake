{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.step-cli.enable {
    home.packages = with pkgs; [step-cli];
  };
}
