{lib, ...}: {
  options = {
    emacs.enable = lib.mkEnableOption "Enable emacs";
  };
}
