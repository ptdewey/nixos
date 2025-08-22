{ lib, pkgs, config, ... }: 

{
services.forgejo = {
    enable = true;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.pdewey.com";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "http://10.0.0.71/"; 
        HTTP_PORT = 11975;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = true; 
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      # Sending emails is completely optional
      # You can send a test email from the web UI at:
      # Profile Picture > Site Administration > Configuration >  Mailer Configuration 
      # mailer = {
      #   ENABLED = true;
      #   SMTP_ADDR = "mail.pdewey.com";
      #   FROM = "noreply@pdewey.com";
      #   USER = "noreply@pdewey.com";
      # };
    };
    mailerPasswordFile = config.age.secrets.forgejo-mailer-password.path;
  };
}
