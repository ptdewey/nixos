{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprland-qtutils
    hyprlock
  ];

  programs.hyprland.enable = true;
}
