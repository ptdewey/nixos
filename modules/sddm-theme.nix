# sddm theme
{ config, lib, pkgs, ... }:

let
    sddmTheme = pkgs.stdenv.mkDerivation {
        name = "sddm-theme";
        src = pkgs.fetchFromGitHub {
                owner = "Keyitdev";
                repo = "sddm-astronaut-theme";
                rev = "468a100460d5feaa701c2215c737b55789cba0fc";
                sha256 = "1h20b7n6a4pbqnrj22y8v5gc01zxs58lck3bipmgkpyp52ip3vig";
                # owner = "MarianArlt";
                # repo = "sddm-sugar-dark";
                # rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
                # sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
        };
        installPhase = ''
            mkdir -p $out
            cp -R ./* $out/
        '';
    };
in {
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${sddmTheme}";
    };
}
