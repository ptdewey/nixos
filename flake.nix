{
  description = "Patricks NixOS System Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, hyprland-qtutils, ... }@inputs: {
    nixosConfigurations = let
      # define common modules shared between systems
      commonModules = [
        ./modules/common.nix
      ];
    in {
      # fix nix-path issues
      nix.registry.nixpkgs.flake = nixpkgs;
      environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
      nix.settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

      # define different systems
      europa = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/europa/configuration.nix
          ./modules/desktops/gnome.nix

          { nixpkgs.hostPlatform = "x86_64-linux"; }
        ];
      };

      callisto = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/callisto/configuration.nix
          ./modules/desktops/sddm-theme.nix

          { nixpkgs.hostPlatform = "x86_64-linux"; }
        ];
      };
    };
  };
}
