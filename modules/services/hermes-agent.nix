{ config, ... }:

{
  sops = {
    secrets."hermes.env" = {
      format = "binary";
      sopsFile = toString ../../secrets/hermes.env;
      restartUnits = [ "hermes-agent.service" ];
    };
  };

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    extraDependencyGroups = [ "matrix" ];
    environmentFiles = [ config.sops.secrets."hermes.env".path ];

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
