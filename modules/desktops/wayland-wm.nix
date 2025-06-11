{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
    swaybg
    xclip
    networkmanagerapplet
    bluez
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

    (import ./extras/waybar-mediaplayer/mediaplayer.nix {pkgs = pkgs; })
    inputs.quickshell.packages.${pkgs.system}.default
  ];
}
