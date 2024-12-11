{ pkgs, lib, ... }:

let
  
  base-emacs = pkgs.emacs29-pgtk;
  emacs-with-pkgs =
    (pkgs.emacsPackagesFor base-emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]);
  
in {
  
  environment.systemPackages = with pkgs; [
    # basics
    home-manager
    
    vim
    neovim
    
    emacs-with-pkgs  # defined above

    git
    wget
    curl

    tree
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

  # unfree
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];
}
