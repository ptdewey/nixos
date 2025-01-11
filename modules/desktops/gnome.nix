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

    # Extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator

    # GTK theming
    yaru-theme
    bibata-cursors
  ];

  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          "cursor-theme" = "Bibata-Modern-Classic";
          "font-name" = "IosevkaPatrick Nerd Font 16";
          "document-font-name" = "IosevkaPatrick Nerd Font 11";
          "monospace-font-name" = "IosevkaPatrick Nerd Font 10";
          "color-scheme" = "prefer-dark";
          "clock-format" = "12h";
          "gtk-theme" = "Yaru-sage-dark";
          "icon-theme" = "Yaru-sage-dark";
          "enable-hot-corners" = false;
        };
        "org/gnome/desktop/peripherals/mouse" = {
          "accel-profile" = "flat";
          "natural-scroll" = false;
          "speed" = -0.19650655021834063;
        };
        "org/gnome/desktop/sound" = {
          event-sounds = false;
        };
        "org/gnome/desktop/wm/keybindings" = {
          "close" = "['<Shift><Super>q']";
          "move-to-workspace-1" = "['<Shift><Super>1']";
          "move-to-workspace-2" = "['<Shift><Super>2']";
          "move-to-workspace-3" = "['<Shift><Super>3']";
          "move-to-workspace-4" = "['<Shift><Super>4']";
          "switch-input-source" = "@as []";
          "switch-input-source-backward" = "@as []";
          "switch-to-workspace-1" = "['<Super>1']";
          "switch-to-workspace-2" = "['<Super>2']";
          "switch-to-workspace-3" = "['<Super>3']";
          "switch-to-workspace-4" = "['<Super>4']";
        };
      };
    }];
  };

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
