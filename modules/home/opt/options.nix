{lib, ...}: {
  options = {
    modules = {
      herbstluftwm.enable = lib.mkEnableOption "Enable herbstluftwm";
      p10k.enable = lib.mkEnableOption "Enable Powerlevel10k for zsh";
      tmux.enable = lib.mkEnableOption "Enable tmux";
      step-cli.enable = lib.mkEnableOption "Enable step-cli";
      wireguard.enable = lib.mkEnableOption "Enable wireguard";
      emacs.enable = lib.mkEnableOption "Enable emacs";
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
