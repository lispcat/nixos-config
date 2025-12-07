{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./user.nix
  ];

  environment.systemPackages = with pkgs; [

    ### Basic ###

    home-manager
    vim
    git
    tree
    fzf
    fd
    trash-cli
    neovim
    alacritty
    mpv
    btop
    htop
    glances
    nethogs
    ffmpeg
    yt-dlp
    croc
    exiftool
    ripgrep
    tldr
    # findutils

    ### Applications ###

    librewolf

  ];
}
