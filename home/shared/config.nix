{
  config,
  pkgs,
  userSettings,
  ...
}: {
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    DEFAULT_BROWSER = pkgs.${userSettings.browser} + "/bin/${userSettings.browser}";
  };

  xdg = {
    enable = true;
    userDirs = {
      createDirectories = true;
      music = "${config.home.homeDirectory}/Media/Music";
      videos = "${config.home.homeDirectory}/Media/Videos";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      publicShare = "${config.home.homeDirectory}/Shared";
      desktop = null;
      extraConfig = {
        XDG_DEVELOPMENT_DIR = "${config.home.homeDirectory}/development";
        XDG_ORG_DIR = "${config.home.homeDirectory}/org";
      };
    };

    mime = {
      enable = true;
      # defaultApplications = {
      #   "text/html" = "org.qutebrowser.qutebrowser.desktop";
      #   "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      #   "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      #   "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      #   "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
      # }
    };
    mimeApps.enable = true;
  };
}
