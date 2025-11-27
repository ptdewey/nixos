{
  description = "Patricks NixOS System Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";  
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = let commonModules = [ ./modules/common.nix ];
    in {
      # fix nix-path issues
      nix.registry.nixpkgs.flake = nixpkgs;
      environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
      nix.settings.nix-path =
        nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

      # define different systems
      europa = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/europa/configuration.nix
          ./modules/desktops/gnome.nix
          ./modules/desktops/niri.nix
          ./modules/games/minecraft.nix
          ./modules/games/steam.nix

          { nixpkgs.hostPlatform = "x86_64-linux"; }
        ];
      };

      callisto = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/callisto/configuration.nix
          ./modules/desktops/gdm.nix
          ./modules/desktops/niri.nix
          # ./noctalia.nix

          { nixpkgs.hostPlatform = "x86_64-linux"; }
        ];
      };

      luna = inputs.nixpkgs-stable.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          nixpkgs = inputs.nixpkgs-stable;
        };
        modules = [ # Don't include common module on Luna
          ./hosts/luna/configuration.nix
          ./modules/utilities/jellyfin.nix
          ./modules/utilities/forgejo.nix

          { nixpkgs.hostPlatform = "x86_64-linux"; }
        ];
      };
    };
  };
}
