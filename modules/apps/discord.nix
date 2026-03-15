{ pkgs, ... }:
let
  discord-sandboxed = pkgs.writeShellScriptBin "discord" ''
    exec ${pkgs.bubblewrap}/bin/bwrap \
      --ro-bind /nix /nix \
      --ro-bind /run/current-system /run/current-system \
      --ro-bind /etc /etc \
      --bind /tmp /tmp \
      --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
      --bind "$HOME/.config/discord" "$HOME/.config/discord" \
      --bind "$HOME/Downloads" "$HOME/Downloads" \
      --dev /dev \
      --proc /proc \          # you can --ro-bind or restrict further
      --unshare-pid \         # hides other PIDs
      --unshare-uts \
      -- ${pkgs.discord}/bin/discord "$@"
  '';
in { environment.systemPackages = [ discord-sandboxed ]; }
