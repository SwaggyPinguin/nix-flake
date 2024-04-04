{pkgs, ...}: {
  nv = "nvim";
  lg = "lazygit";
  ls = "eza --icons -l -T -L=1";
  la = "eza --icons -agl -s type";
  mux = "pgrep -vx tmux > /dev/null && \
		tmux new -d -s delete-me && \
		tmux run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh && \
		tmux kill-session -t delete-me && \
		tmux attach || tmux attach";
}
