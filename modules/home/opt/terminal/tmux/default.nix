{
  config,
  lib,
  pkgs,
  ...
}: let
  shell = config.default.shell;
in {
  config = lib.mkIf config.modules.tmux.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      shell = pkgs.${shell} + "/bin/${shell}";
      terminal = "screen-256color";
      keyMode = "vi";
      mouse = true;
      baseIndex = 1;
      clock24 = true;
      historyLimit = 10000;
      escapeTime = 1;

      plugins = with pkgs; [
        tmuxPlugins.sensible
        # tmuxPlugins.gruvbox
        tmuxPlugins.tmux-fzf
        tmuxPlugins.better-mouse-mode

        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim "session"
            set -g @resurrect-strategy-nvim "session"
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '10'
            set -g @continuum-boot 'on'
          '';
        }
      ];

      extraConfig = ''
        # split panes using | and -, make sure they open in the same path
        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"
        bind H split-window -v -p 20 -c "#{pane_current_path}"

        unbind '"'
        unbind %

        # open new windows in the current path
        bind c new-window -c "#{pane_current_path}"

        # reload config file
        bind r source-file ~/.config/tmux/tmux.conf

        unbind p
        bind p previous-window

        # don't rename windows automatically
        set -g allow-rename off

        # Use Alt-arrow keys without prefix key to switch panes
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # renumber windows when a window is closed
        set -g renumber-windows on

        # loud or quiet?
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        setw -g monitor-activity off
        set -g bell-action none

        # source theme file
        source-file ~/.config/tmux/theme.conf
      '';
    };

    programs.fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };

    home.packages = with pkgs; [
      tmux
    ];

    # set tmux theme file
    home.file = {
      ".config/tmux/theme.conf" = {
        source = ./themes/gruvbox-material-soft.conf;
      };
    };
  };
}
