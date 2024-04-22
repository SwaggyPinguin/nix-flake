{pkgs, ...}: {
  home.packages = with pkgs; [
    # element-desktop
    alejandra
    curl
    direnv
    fd
    findutils
    gcc
    gnugrep
    gnumake
    just
    libgcc
    libvterm
    mercurial
    neovim
    nh
    nix-direnv
    nixfmt-classic
    nodePackages_latest.nodejs
    nodePackages_latest.prettier
    php
    pipx
    plocate
    prettierd
    python3
    ripgrep
    rustup
    unzip
    vim
    vscode
    wget
    zip
    yarn
    zig
  ];
}
