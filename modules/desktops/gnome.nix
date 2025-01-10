# Gnome setup
{ pkgs, ... }:
{
  # Enable/disable X11
  services.xserver.enable = true;

  # Enable gnome
  services.xserver.desktopManager.gnome.enable = true;

  # Install packages and extensions
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
  ];

  environment.gnome.excludePackages = with pkgs; [
    orca
    geary
    gnome-tour
    gnome-user-docs
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-maps
    gnome-logs
    gnome-music
    gnome-weather
    gnome-connections
    simple-scan
    totem
    yelp
    gnome-software
  ];
}
