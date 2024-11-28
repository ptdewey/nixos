{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.enable = true;
  # networking.wireguard.interfaces = {
  #   wg0 = {
  #     ips = [""]
  #   };
  # };
  networking.wg-quick.interfaces.wg0.configFile = "/home/patrick/wireGuardShare.conf";
}
