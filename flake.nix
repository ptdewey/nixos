{
  description = "Patricks NixOS System Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    glide.url = "github:ptdewey/glide-browser-flake";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    workmux = {
      url = "github:raine/workmux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hermes-agent = {
      url = "github:NousResearch/hermes-agent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations =
        let
          commonModules = [
            ./modules/common.nix
            ./modules/services/local-observability.nix
          ];
        in
        {
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
              ./modules/desktops/niri.nix
              ./modules/games/minecraft.nix
              ./modules/games/steam.nix
              # ./modules/games/lutris.nix
              ./modules/apps/discord.nix

              {
                nixpkgs.hostPlatform = "x86_64-linux";
              }
            ];
          };

          callisto = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = commonModules ++ [
              ./hosts/callisto/configuration.nix
              # ./modules/desktops/gdm.nix
              ./modules/desktops/tuigreet.nix
              ./modules/desktops/niri.nix
              ./modules/apps/discord.nix
              ./modules/desktops/river.nix

              {
                nixpkgs.overlays = [ ];
                nixpkgs.hostPlatform = "x86_64-linux";
              }
            ];
          };

          luna = inputs.nixpkgs-stable.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              nixpkgs = inputs.nixpkgs-stable;
            };
            modules = [
              # Don't include common module on Luna
              ./hosts/luna/configuration.nix
              ./modules/utilities/jellyfin.nix
              ./modules/utilities/forgejo.nix

              { nixpkgs.hostPlatform = "x86_64-linux"; }
            ];
          };

          calypso = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/calypso/configuration.nix
              ./modules/services/hermes-agent.nix

              inputs.sops-nix.nixosModules.sops
              inputs.hermes-agent.nixosModules.default

              {
                nixpkgs.overlays = [ ];
                nixpkgs.hostPlatform = "x86_64-linux";
              }
            ];
          };
        };
    };
}
