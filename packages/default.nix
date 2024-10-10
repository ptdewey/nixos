{ config, pkgs, ... }:
{
  imports = [];

  environment.systemPackages = with pkgs; [
    luajit
    love
    tiled
  ];
}
