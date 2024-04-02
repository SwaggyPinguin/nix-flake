{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.modules.herbstluftwm.enable {
    xsession = {
      windowManager.herbstluftwm = let
        mod = "Mod4";
        withModKey = lib.mapAttrs' (key: lib.nameValuePair "${mod}-${key}");
      in {
        enable = true;
        tags = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
        settings = {
          window_gap = 5;
          frame_padding = 0;
        };
        keybinds = withModKey {
          Shift-q = "quit";
          Shift-r = "reload";
          Shift-c = "close";
          Shift-Return = ''spawn "${"Terminal:-alacritty"}" -t Alacritty'';
        };
        mousebinds = withModKey {
          B1 = "move";
          B2 = "zoom";
          B3 = "resize";
        };
      };
    };
  };
}
