{ config, pkgs, ... }:
{
  imports = [ ./wayland-wm.nix ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    swaylock
    fuzzel
    xwayland-run
  ];

  programs.niri.enable = true;
  programs.gamescope.enable = true;
  programs.steam.gamescopeSession.enable = true;

  systemd.user.services = {
    swaybg = {
      description = "Wallpaper Service";
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/Pictures/wallpapers/evergarden.png";
        Restart = "on-failure";
      };
    };
  };
}
