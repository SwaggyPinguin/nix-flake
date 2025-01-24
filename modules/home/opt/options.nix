{lib, ...}: {
  options = {
    modules = {
      herbstluftwm.enable = lib.mkEnableOption "Enable herbstluftwm";
      niri.enable = lib.mkEnableOption "Enable niri wm";
      p10k.enable = lib.mkEnableOption "Enable Powerlevel10k for zsh";
      tmux.enable = lib.mkEnableOption "Enable tmux";
      step-cli.enable = lib.mkEnableOption "Enable step-cli";
      wireguard.enable = lib.mkEnableOption "Enable wireguard";
      emacs.enable = lib.mkEnableOption "Enable emacs";
      gtk.enable = lib.mkEnableOption "Enable gtk themes";
    };

    default = {
      terminal = lib.mkOption {
        type = lib.types.enum ["kitty" "alacritty" "wezterm" "ghostty"];
        default = "kitty";
      };
      shell = lib.mkOption {
        type = lib.types.enum ["zsh" "bash" "fish" "nushell"];
        default = "zsh";
      };
    };
  };
}
