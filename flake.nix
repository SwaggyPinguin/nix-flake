{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "nixpkgs/nixos-23.11";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }: 
	let
		systemSettings = {
			system = "x86_64-linux";
			hostname = "herbstnix";
			stateVersion = "23.11";
		};	

		userSettings = {
			username = "noah";
			name = "noah";
			email = "noahdahms@gmail.com";
		};

		pkgs = import nixpkgs {
			system = systemSettings.system;
			config = {
				allowUnfree = true;
				allowUnfreePredicate = (_: true);
			};
		};

		pkgs-stable = import nixpkgs-stable {
			system = systemSettings.system;
			config = {
				allowUnfree = true;
				allowUnfreePredicate = (_: true);
			};
		};
	in
	{
		settings.experimental-features = [ "nix-command" "flakes" ];

		homeConfigurations = {
			user = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
				extraSpecialArgs = {
					inherit pkgs-stable;
					inherit systemSettings;
					inherit userSettings;
				};
			};
		};
  };
}
