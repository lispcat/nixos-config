{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # basics
    vim
    neovim
    wget
    htop
    curl
    git
    emacs
    gnumake
    home-manager

    alacritty

  ];
}
