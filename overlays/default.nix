{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (import ./sf-mono-liga.nix {inherit inputs;})
  ];
}
