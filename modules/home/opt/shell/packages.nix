{pkgs, ...}: {
  # extra packages used in ./aliases.nix
  home.packages = with pkgs; [
    bat
    eza
    onefetch
    fastfetch
  ];
}
