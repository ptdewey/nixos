{ config, pkgs, ... }:
{
  imports = [ ./wayland-wm.nix ];

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    hyprland-qtutils
    hyprlock
  ];

  programs.hyprland.enable = true;
}
