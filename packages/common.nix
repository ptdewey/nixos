{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
}
