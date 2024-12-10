{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # necessary
    home-manager
    
    # basics
    vim
    neovim
    wget
    htop
    curl
    git
    emacs

    # cli tools
    gnumake

    # desktop tools
    alacritty

  ];
}
