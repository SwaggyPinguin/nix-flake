{
  config,
  lib,
  pkgs,
  ...
}: let
  repo = pkgs.fetchFromGitHub {
    owner = "SwaggyPinguin";
    repo = "doom-emacs";
    rev = "main";
    # get sha256 nix-prefetch-url --unpack https://github.com/example/repo/archive/main.tar.gz
    sha256 = "132iykmmfijy7sy3jsc8bv4fc5shhv9ng4sg89m2sjrv2ajpzqmd";
  };
in {
  config = lib.mkIf config.modules.emacs.enable {
    home.file.".doom.d" = {
      source = ./doom;
      recursive = true;
      onChange = "${pkgs.writeShellScript "doom-change" ''
        nix-shell -p git --run '
          export PATH="${pkgs.emacs29}/bin:$PATH"
          DOOM="$HOME/.emacs.d"

          if [ ! -d "$DOOM" ]; then
            echo "Cloning Doom-Emacs to $DOOM ..."
            git clone --depth 1 https://github.com/doomemacs/doomemacs $DOOM
            $DOOM/bin/doom --force install
          fi

          echo "Syncing Doom-Emacs"
          $DOOM/bin/doom --force sync
        '
      ''}";
    };

    # home.packages = with pkgs; [emacs29];
    programs.emacs = {
      enable = true;
      package = pkgs.emacs29;
    };

    services.emacs = {
      enable = true;
      client = {
        enable = true;
        arguments = ["-c" "-a" "emacs"];
      };
      package = pkgs.emacs29;
    };
  };
}
