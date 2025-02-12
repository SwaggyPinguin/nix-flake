{
  config,
  lib,
  pkgs,
  ...
}: {
  # inspired from https://github.com/linuxmobile/kaku/ nushell.nix

  config = lib.mkIf (config.default.shell == "nushell") {
    programs.nushell = {
      enable = true;
      plugins = with pkgs.nushellPlugins; [
        skim
        query
        gstat
        highlight
        polars
      ];

      environmentVariables = {
        SHELL = "${pkgs.nushell}/bin/nu";
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
      };

      extraConfig = let
        conf = builtins.toJSON {
          show_banner = false;
          edit_mode = "vi";

          ls.clickable_links = true;
          # rm.always_trash = true;

          table = {
            mode = "rounded";
            index_mode = "always";
            header_on_separator = false;
          };

          cursor_shape = {
            vi_insert = "line";
            vi_normal = "block";
          };

          display_errors = {
            exit_code = false;
          };

          menus = [
            {
              name = "completion_menu";
              only_buffer_difference = false;
              marker = "? ";
              type = {
                layout = "columnar"; # list, description
                columns = 4;
                col_padding = 2;
              };
              style = {
                text = "magenta";
                selected_text = "blue_reverse";
                description_text = "yellow";
              };
            }
          ];
        };

        completions = let
          completion = name: ''
            source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
          '';
        in
          names:
            builtins.foldl'
            (prev: str: "${prev}\n${str}") ""
            (map completion names);
      in ''
        $env.config = ${conf};

        ${completions ["git" "nix" "man" "rg"]}

        source ${pkgs.nu_scripts}/share/nu_scripts/modules/formats/from-env.nu

        def fcd [] {
          let dir = (fd --type d | sk | str trim)
          if ($dir != "") {
            cd $dir
          }
        }

        def installed [] {
          nix-store --query --requisites /run/current-system/ | parse --regex '.*?-(.*)' | get capture0 | sk
        }

        def installedall [] {
          nix-store --query --requisites /run/current-system/ | sk | wl-copy
        }

        def search [term: string] {
          nix search nixpkgs --json $term | from json | values | select pname description
        }
      '';

      # shellAliases = import ../aliases.nix {inherit pkgs;};
      shellAliases = {
        nv = "nvim";
        lg = "lazygit";
        l = "eza --icons -l -T -L=1";
        ll = "eza --icons -agl -s type";
        gitfetch = "onefetch";
      };
    };

    programs.eza.enableNushellIntegration = true;
    # programs.starship.enableNushellIntegration = true;

    # add this if defaultShell can't be managed with nix (non-nixos systems)
    # autostart zsh
    programs.bash = {
      enable = true;
      shellAliases = import ../aliases.nix {inherit pkgs;};
      # initExtra = "exec zsh";
    };

    home.packages = with pkgs; [nushell];
  };
}
