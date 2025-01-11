# Gnome setup
{ pkgs, ... }:
{
  services.xserver = {
    # Enable/disable X11
    enable =  true;

    # Enable gnome
    desktopManager.gnome.enable = true;

    # Enable gdm
    displayManager.gdm.enable = true;
  };

  # Install packages and extensions
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator
    yaru-theme
  ];

  # Udev service for systray
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # exclude default gnome packages
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
