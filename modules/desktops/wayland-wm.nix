{ config, inputs, pkgs, ... }:
let
  mediaplayer = import ./extras/waybar-mediaplayer/mediaplayer.nix { pkgs = pkgs; };
in {
  environment.systemPackages = with pkgs; [
    waybar
    swaybg
    xclip
    networkmanagerapplet
    bluez
    libsForQt5.qt5.qtgraphicaleffects
    grim
    slurp
    copyq
    scowl
    wofi
    pulseaudio
    playerctl
    mediaplayer

    inputs.quickshell.packages."x86_64-linux".default
  ];
}
