{
  description = "Patricks NixOS System Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # fix nix-path issues
    nix.registry.nixpkgs.flake = nixpkgs;
    environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
    nix.settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

    nixosConfigurations = let
      # define common modules shared between systems
      commonModules = [
        # can also include module files here
        # ./modules/r-env.nix

        # ({ pkgs, ... }: {
        #     nixpkgs.overlays = [ neovim-nightly-overlay.overlay ];
        # })
      ];
    in {
      # define different systems
      callisto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ [
          ./configuration.nix
          ./packages/default.nix
          ./modules/sddm-theme.nix
          ./modules/wireguard.nix
          # ./hosts/callisto/hardware-extras.nix
          # ./hosts/callisto/default.nix
          # ./modules/default.nix
        ];
      };
    };
  };
}
