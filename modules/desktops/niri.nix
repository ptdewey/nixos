{ config, pkgs, ... }:
{
  imports = [ ./wayland-wm.nix ];

  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    swaylock
    fuzzel
    xwayland-run
  ];

  systemd.user.services = {
    swaybg = {
      description = "Wallpaper Service";
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/Pictures/wallpapers/ferns.png";
        Restart = "on-failure";
      };
    };
  };
}
