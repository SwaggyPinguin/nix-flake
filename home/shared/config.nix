{
  config,
  pkgs,
  userSettings,
  ...
}: let
  mimeApps = {
    "text/html" = "${userSettings.browser}.desktop";
    "x-scheme-handler/http" = "${userSettings.browser}.desktop";
    "x-scheme-handler/https" = "${userSettings.browser}.desktop";
    "x-scheme-handler/about" = "${userSettings.browser}.desktop";
    "x-scheme-handler/unknown" = "${userSettings.browser}.desktop";
    "application/xhtml+xml" = "${userSettings.browser}.desktop";
  };
in {
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    BROWSER = userSettings.browser;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Media/Music";
      videos = "${config.home.homeDirectory}/Media/Videos";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      publicShare = "${config.home.homeDirectory}/Shared";
      desktop = null;
      templates = null;
      extraConfig = {
        XDG_DEVELOPMENT_DIR = "${config.home.homeDirectory}/development";
        XDG_ORG_DIR = "${config.home.homeDirectory}/org";
      };
    };

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = mimeApps;
      associations.added = mimeApps;
    };
  };
}
