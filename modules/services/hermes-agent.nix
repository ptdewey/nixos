{ config, ... }:

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
      model.default = "openai/gpt-5.5";
      terminal = {
        backend = "local";
        timeout = 180;
      };
      matrix = {
        require_mention = true;
        session_scope = "room";
        auto_thread = true;
        dm_mention_threads = false;
      };
    };
  };
}
