{ pkgs, userSettings, systemSettings, ... }:
{
	home = {
		username = userSettings.username;
		homeDirectory = "/home/" + userSettings.username;
		stateVersion = systemSettings.stateVersion;
		enableNixpkgsReleaseCheck = false;
	};

	home.packages = with pkgs; [
		vim
		neovim
		curl
		wget
		libgcc
		zig
	];

	# TODO: move to extra file
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

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	xdg.enable = true;
	xdg.mime.enable = true;
	xdg.mimeApps.enable = true;

	programs.home-manager.enable = true;
}
