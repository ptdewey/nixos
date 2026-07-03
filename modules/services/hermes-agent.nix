{ config, lib, ... }:

{
  sops.secrets.hermes = {
    format = "dotenv";
    sopsFile = ../../secrets/hermes.env;
  };

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    extraDependencyGroups = [
      "messaging"
      "matrix"
    ];
    environmentFiles = [ config.sops.secrets.hermes.path ];

    settings = {
      model = {
        provider = "custom";
        # default = "unsloth/Qwen3-Coder-Next-GGUF:Q8_0";
        # default = "unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL";
        default = "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q8_K_XL";
        base_url = "http://127.0.0.1:8080/v1";
        api_key = "123abc";
      };
      terminal = {
        backend = "local";
        cwd = "/var/lib/hermes/workspace";
        timeout = 180;
      };
      matrix = {
        require_mention = true;
        allowed_users = [
          "@pat:solanaceae.net"
        ];
        session_scope = "room";
        auto_thread = true;
        dm_mention_threads = false;
      };
    };
  };

  systemd.services.hermes-agent = {
    # Hermes drains in-flight gateway work for 180s by default and warns if
    # systemd may SIGKILL it before drain+grace can complete.
    serviceConfig.TimeoutStopSec = "210s";

    # Upstream's NixOS module still exports the deprecated MESSAGING_CWD env var.
    # terminal.cwd above is the current declarative location.
    environment.MESSAGING_CWD = lib.mkForce "";
  };
}
