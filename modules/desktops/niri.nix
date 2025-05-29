{ config, pkgs, ... }:
{
  imports = [ ./wayland-wm.nix ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    swaylock
    fuzzel
  ];

  programs.niri.enable = true;
}
