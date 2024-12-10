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
    home-manager

    alacritty
    dwl

  ];
}
