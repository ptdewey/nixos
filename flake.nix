{
  description = "Patricks NixOS System Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay, hyprland-qtutils, ... }@inputs: {
    nixosConfigurations = let
      # define common modules shared between systems
      commonModules = [
        ./modules/common.nix
        ./packages/default.nix
      ];
    in {
      # fix nix-path issues
      nix.registry.nixpkgs.flake = nixpkgs;
      environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
      nix.settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

      # define different systems
      europa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/europa/configuration.nix
          ./modules/desktops/sddm-theme.nix
          ./modules/desktops/gnome.nix
        ];
      };

      callisto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/callisto/configuration.nix
          ./modules/desktops/sddm-theme.nix
          # ./hosts/callisto/hardware-extras.nix
        ];
      };
    };
  };
}
