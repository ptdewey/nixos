{ pkgs, ... }:
let
  discord-sandboxed = pkgs.buildFHSEnv {
    name = "discord";
    targetPkgs = pkgs: [ pkgs.discord ];
    runScript = "discord";
    extraBwrapArgs = [ "--unshare-pid" "--unshare-uts" ];
  };
in { environment.systemPackages = [ discord-sandboxed ]; }
