{pkgs, ...}: {
  nv = "nvim";
  em = "emacs -nw";
  lg = "lazygit";
  ls = "eza --icons -l -T -L=1";
  la = "eza --icons -agl -s type";
  cat = "bat";
  gitfetch = "onefetch";
  mux = "pgrep -vx tmux > /dev/null && \
    tmux new -d -s delete-me && \ 
    tmux run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh && \
    tmux kill-session -t delete-me && \
    tmux attach || tmux attach";
}
