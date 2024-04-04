{pkgs, ...}: {
  home.packages = with pkgs; [
    vim
    neovim
    vscode
    element-desktop
    curl
    wget
    libgcc
    zig
    direnv
    nix-direnv
    nixfmt-classic
    alejandra
    just
  ];
}
