{
  description = "Patricks NixOS System Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
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
          # ./modules/sddm-theme.nix
          # ./hosts/callisto/hardware-extras.nix
          # ./hosts/callisto/default.nix
          # ./modules/default.nix
        ];
      };
    };
  };
}
