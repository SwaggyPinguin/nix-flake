{pkgs, ...}: {
  home.packages = with pkgs; [
    vim
    neovim
    vscode
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
