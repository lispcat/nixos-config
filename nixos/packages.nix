{ pkgs, lib, ... }:

let
  
  # base-emacs = pkgs.emacs29-pgtk;
  # emacs-with-pkgs =
  #   (pkgs.emacsPackagesFor base-emacs).emacsWithPackages (epkgs: [
  #     epkgs.vterm
  #   ]);
  
in {
  
  environment.systemPackages = with pkgs; [
    # basics
    home-manager
    
    vim
    neovim
    
    # emacs-with-pkgs  # defined above
    emacs29-pgtk

    git
    wget
    curl

    tree
    fzf
    strace

    # desktop applications
    keepassxc
    calibre
    firefox
    librewolf
    ungoogled-chromium
    kdePackages.kdeconnect-kde
    krita
    gimp
    libreoffice-fresh hunspell hunspellDicts.en-us-large
    obs-studio
    vesktop
    mtpaint # also look into other minimal paint apps
    anki

    # desktop programs
    alacritty
    mpv
    feh
    pavucontrol

    # desktop tools
    mako
    wlsunset
    sway-contrib.grimshot
    bemenu
    wbg
    wl-clipboard-rs
    wmenu
    alsa-utils  # provides amixer, aplay
    brightnessctl
    playerctl
    
    # cli applications
    tmux
    btop
    htop

    # cli programs
    ffmpeg
    yt-dlp

    # cli tools
    gnumake
    trash-cli

    # script tools
    espeak

    # dev
    quilt

    # nixos tools
    vulnix

    # fun
    hyfetch
    uwufetch

  ];

  fonts.packages = with pkgs; [
    # mono
    fira-code
    hack-font
    liberation_ttf
    # var
    
    # bitmap
    tamzen
    # latex
    libertinus
    # japanese
    ipaexfont
    # symbols
    font-awesome
    nerd-fonts.symbols-only
  ];


}
