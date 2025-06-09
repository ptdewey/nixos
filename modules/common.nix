{ inputs, pkgs, ... }:

{
  # Common package list
  environment.systemPackages = with pkgs; [
    git
    tokei
    wget
    gcc
    curl
    go
    rustup
    fzf
    ripgrep
    tree
    tmux
    unzip
    lm_sensors
    fd
    htop
    killall
    oh-my-posh
    lsd
    tree-sitter
    nodejs
    fastfetch
    python312
    gnumake
    xan
    csvlens
    jq
    oh-my-posh
    lshw
    vlc
    gnupg
    feh
    zathura
    fx
    glow
    websocat
    pandoc
    inputs.zen-browser.packages."${system}".beta
    gimp
    gh
    yazi
    signal-cli
    signal-desktop
    libertinus
    ungoogled-chromium
    alacritty
    ghostty
    zip
    ast-grep
    nmap
    libreoffice
    yaru-theme
    bibata-cursors
    typst
  ];

  # Add missing dynamic libs (do not include in environment.systemPackages)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ sqlite ];

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # Use nightly if there are ever issues with stable
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  # ZSH
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;
  users.users.patrick.shell = pkgs.zsh;

  # Dictionary word list (used with nvim)
  environment.wordlist = {
    enable = true;
    lists = {
      WORDLIST = [ "${pkgs.scowl}/share/dict/words.txt" ];
    };
  };
}
