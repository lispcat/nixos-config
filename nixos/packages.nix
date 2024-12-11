{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # basics
    home-manager
    vim
    neovim
    wget
    htop
    curl
    git
    emacs

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

    # fun
    hyfetch
    uwufetch

  ];

  # unfree
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];
}
