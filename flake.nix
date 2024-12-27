{
  description = "Patricks NixOS System Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
  };

  outputs = { self, nixpkgs, hyprland-qtutils, ... }@inputs: {
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
      # fix nix-path issues
      nix.registry.nixpkgs.flake = nixpkgs;
      environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
      nix.settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

      # define different systems
      callisto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
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
