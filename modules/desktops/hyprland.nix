{ config, pkgs, ... }:
{
  imports = [ ./wayland-wm.nix ];

  environment.systemPackages = with pkgs; [
    hyprland-qtutils
    hyprlock
  ];

  programs.hyprland.enable = true;
}
