{
  config,
  lib,
  pkgs,
  ...
}: {
  services.emacs = lib.mkIf config.emacs.enable {
    enable = true;
    package = pkgs.emacs29; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
}
