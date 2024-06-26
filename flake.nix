{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { nixpkgs, ... }:
	let systems = [ "x86_64-linux" "aarch64-linux" ];
	in {
		defaultPackage = builtins.listToAttrs (builtins.map (system: { name = system; value =
		let pkgs = import nixpkgs { inherit system; };
		in pkgs.buildGoModule {
			name = "hetk";
			src = ./.;
			vendorHash = "";
		};}) systems );

		nixosModules.hetk = ./module.nix;
	};
}
