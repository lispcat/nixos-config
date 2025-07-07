{ pkgs, pkgs-stable, lib, ... }:

let

  base-emacs = pkgs.emacs30-pgtk;
  emacs-with-pkgs =
    (pkgs.emacsPackagesFor base-emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.jinx
    ]);

  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of
      preview newunicodechar cm-super fontspec
      unicode-math lualatex-math xits mathtools enumitem;
  });

in {

  environment.systemPackages = with pkgs; [

    ## pivotal
    home-manager

    ## emacs
    emacs-with-pkgs  # defined above
    # emacs29-pgtk

    ## tex
    tex

    (ghostscript.overrideAttrs (oldAttrs: {
      version = "10.05.1";
      src = fetchurl {
        url = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10051/ghostscript-10.05.1.tar.xz";
        sha256 = "sha256-IvK9yhXCiDDJcVzdxcKW6maJi/2rC2BKTgvP6wOvbK0=";
      };
    }))

    ## basics
    vim
    neovim
    git
    wget
    curl

    tree
    fzf
    # strace

    ## desktop applications
    river
    keepassxc
    calibre
    firefox
    librewolf
    ungoogled-chromium
    # kdePackages.kdeconnect-kde
    krita
    gimp
    libreoffice-fresh hunspell hunspellDicts.en-us-large
    obs-studio
    vesktop
    # mtpaint # also look into other minimal paint apps
    anki
    # signal-desktop
    # wireshark
    milkytracker
    furnace
    pkgs-stable.openmsx

    ## desktop programs
    alacritty
    mpv
    feh
    pavucontrol
    # networkmanagerapplet

    ## desktop tools
    mako
    wlsunset
    sway-contrib.grimshot
    bemenu
    wbg
    wl-clipboard-rs
    # wmenu
    alsa-utils  # provides amixer, aplay
    brightnessctl
    playerctl
    wlr-which-key
    swaylock
    swayidle
    lswt
    xwayland
    waylock
    fuzzel

    ## cli applications
    tmux
    btop
    htop
    glances
    nethogs
    # mdbook

    ## cli programs
    ffmpeg
    yt-dlp
    croc

    ## cli tools
    gnumake
    trash-cli
    unzip
    exiftool
    ripgrep
    vorbis-tools  # for vorbiscomment
    poppler_utils  # for pdftotext
    colordiff

    # script tools
    # espeak
    acpi

    ## dev
    gcc  # $CC ?
    valgrind
    # quilt
    pkg-config
    libxkbcommon
    clang-tools

    cargo  # for rustic commands
    cargo-modules
    rustc
    rustfmt
    rustPackages.clippy
    rust-analyzer  # breaks lsp-mode if in devshell?

    # zig

    ## nixos tools
    # vulnix

    ## fun
    hyfetch
    uwufetch

  ];

  fonts.packages = with pkgs; [
    # mono
    fira-code
    hack-font
    liberation_ttf
    uw-ttyp0
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
    # nerdfonts
    # (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})

  ];


}
