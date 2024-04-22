{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      # extraConfig = '''';
    };
  };
}
