{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    waybar
    swaybg
    wl-clipboard
    xclip
    networkmanagerapplet
    bluez
    libsForQt5.qt5.qtgraphicaleffects
    grim
    slurp
    copyq
    scowl
    wofi
  ];
}
