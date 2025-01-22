{
  config,
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;
    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      input = {
        keyboard.xkb.layout = "us";
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus = true;
        workspace-auto-back-and-forth = true;
      };
      output = {
        "Virtual-1" = {
          scale = 1.0;
          mode = {
            width = 1600;
            height = 920;
            # refresh = null;
          };
          position = {
            x = 0;
            y = 0;
          };
        };
      };
    };
  };
}
