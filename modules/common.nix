{ pkgs, ... }:

{
  imports = [];

  # add missing dynamic libs (do not include in environment.systemPackages)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ sqlite ];
}
