{ pkgs, userSettings, ... }: {
  home.packages = with pkgs; [ git ];

  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
    extraConfig = {
      core = {
        editor = "nvim";
        fileMode = true;
      };
      credential.helper = "cache --timeout=86400";
    };
  };

  programs.lazygit.enable = true;
}
