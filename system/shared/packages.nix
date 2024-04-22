{
  pkgs,
  userSettings,
  ...
}: {
  # System packages
  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
    (pkgs.${userSettings.shell})
    git
    fzf
    gnugrep
    ripgrep
    cryptsetup # used for disk encryption
    home-manager
    alacritty
  ];
}
