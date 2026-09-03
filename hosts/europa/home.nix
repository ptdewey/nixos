{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;

    users.patrick = {
      home = {
        homeDirectory = "/home/patrick";
        stateVersion = "26.11";
        username = "patrick";
      };

      imports = [ inputs.dotfiles.homeModules.patrick ];

      programs.home-manager.enable = true;
    };
  };
}
