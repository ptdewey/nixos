{ pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "callisto";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.patrick = {
    isNormalUser = true;
    description = "Patrick Dewey";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    # packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    # nemo
    nautilus
    wofi
    curl
    cacert
    firefox
    # firefox-unwrapped
    firefox-devedition
    kitty
    gcc
    fd
    feh
    htop
    killall
    lm_sensors
    tmux
    unzip
    tree
    acpi
    fzf
    go
    ripgrep
    brightnessctl
    pulseaudio
    copyq
    waybar
    swaybg
    scowl
    discord
    zsh
    wl-clipboard
    xclip
    networkmanagerapplet
    gnumake
    bluez
    swayfx
    hyprlock
    grim
    slurp
    python312
    libsForQt5.qt5.qtgraphicaleffects
    spotify
    tinymist
    wezterm
    rustup
    # fuzzel
    inputs.hyprland-qtutils.packages."${pkgs.system}".default # fix hyprland popup
  ];

  programs.hyprland.enable = true;
  # programs.niri.enable = true;

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  # };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  services.power-profiles-daemon.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.patrick.shell = pkgs.zsh;

  programs.steam = {
    enable = true;
  };

  environment.wordlist = {
    enable = true;
    lists = {
      WORDLIST = [ "${pkgs.scowl}/share/dict/words.txt" ];
    };
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # tailscale
  services.tailscale.enable = true;
  systemd.services.tailscaled.after = ["systemd-networkd-wait-online.service"];

  # bluetooth things
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Docker (rootless)
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # environment.variables = {
  #   LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.extraHosts = ''
    10.0.0.71 luna
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}