{lib, ...}: {
  options = {
    modules = {
      herbstluftwm.enable = lib.mkEnableOption "Enable herbstluftwm";
    };

    default = {
      terminal = lib.mkOption {
        type = lib.types.enum ["kitty" "alacritty" "wezterm"];
        default = "kitty";
      };
      shell = lib.mkOption {
        type = lib.types.enum ["zsh" "bash" "fish"];
        default = "zsh";
      };
    };
  };
}
