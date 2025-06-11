{ inputs, pkgs, ... }:
let
  mediaplayer = import ./extras/waybar-mediaplayer/mediaplayer.nix {pkgs = pkgs; };
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in {
  qt.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    swaybg
    xclip
    networkmanagerapplet
    bluez
    libsForQt5.qt5.qtgraphicaleffects
    grim
    slurp
    scowl
    wofi
    pulseaudio
    playerctl
    cava
    material-symbols
    material-icons
    weather-icons
    wl-clipboard
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qttools
    kdePackages.qtdeclarative

    mediaplayer
    quickshell
  ];

  environment.variables.QML2_IMPORT_PATH = "${quickshell}/lib/qt-5.15.16/qml";
}
