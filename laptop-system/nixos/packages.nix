{ pkgs, pkgs-stable, inputs, ... }:

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
      unicode-math lualatex-math xits mathtools enumitem
      preprint minted upquote lineno underscore;
  });

  # custom-lua-language-server = pkgs.lua-language-server.overrideAttrs (oldAttrs: {
  #   installPhase = oldAttrs.installPhase + ''
  #   # Create symlink in share directory that gets linked to system
  #   mkdir -p "$out/share/lua-libs"
  #   ln -s "$out/share/lua-language-server/main.lua" "$out/share/lua-libs/main.lua"
  # '';
  # });

in {

  environment.systemPackages = with pkgs; [

    ## pivotal
    home-manager

    ## emacs
    emacs-with-pkgs  # defined above
    # emacs29-pgtk

    ## tex
    tex

    ghostscript
    # (ghostscript.overrideAttrs (oldAttrs: {
    #   version = "10.05.1";
    #   src = fetchurl {
    #     url = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10051/ghostscript-10.05.1.tar.xz";
    #     sha256 = "sha256-IvK9yhXCiDDJcVzdxcKW6maJi/2rC2BKTgvP6wOvbK0=";
    #   };
    # }))

    ## basics
    vim
    neovim
    git
    wget
    curl
    zip

    tree
    fzf
    # strace

    ## desktop applications
    river-classic
    keepassxc
    # pkgs-stable.calibre
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
    signal-desktop
    # wireshark
    pkgs-stable.milkytracker
    goattracker
    furnace
    # pkgs-stable.openmsx
    boops
    # mixxx
    # temp fix for mixxx till 2.6
    (mixxx.overrideAttrs (oldAttrs: {
      version = "2.5-bleeding";
      src = fetchFromGitHub {
        owner = "mixxxdj";
        repo = "mixxx";
        rev = "16d57ca6f7496103d2a1376ceafcff823bc31fa0";
        hash = "sha256-qea93tb1uTXwJeJpPYbXemQpBZBPos1WXR/bKgXNjUc=";
      };
    }))
    kdePackages.kdenlive
    ani-cli

    ## desktop programs
    alacritty
    kitty
    mpv
    feh
    pavucontrol
    networkmanagerapplet
    w3m # for emacs-w3m
    xfce.thunra


    ## desktop tools
    mako      # notification daemon
    libnotify # notify-send
    wlsunset  # color temperature
    sway-contrib.grimshot
    bemenu
    wbg
    wl-clipboard-rs
    # wmenu
    alsa-utils  # provides amixer, aplay
    brightnessctl
    playerctl
    wlr-which-key # which-key functionality
    swaylock
    swayidle
    lswt
    xwayland
    waylock
    fuzzel      # app launcher
    waybar      # taskbar
    hyprpaper    # wallpapers
    hyprpicker   # color-picker
    kooha
    hyprland-per-window-layout

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
    latexminted # for org export code coloring

    ## cli tools
    gnumake
    trash-cli
    unzip
    exiftool
    ripgrep
    fd
    findutils
    vorbis-tools  # for vorbiscomment
    poppler-utils  # for pdftotext
    colordiff
    tldr

    # script tools
    # espeak
    acpi
    jmtpfs

    ## dev
    gcc  # $CC ?
    valgrind
    # quilt
    pkg-config
    libxkbcommon
    clang-tools
    devenv
    ghc

    cargo  # for rustic commands
    cargo-modules
    cargo-binstall
    rustc
    rustfmt
    rustPackages.clippy
    rust-analyzer  # breaks lsp-mode if in devshell?
    lua-language-server
    jdt-language-server
    haskell-language-server
    jdk
    nixd
    typst
    # python3Full
    # inputs.rustowl-flake.packages.${system}.rustowl

    # zig

    ## nixos tools
    # vulnix
    nix-output-monitor

    ## fun
    hyfetch
    uwufetch

    (ly.overrideAttrs (oldAttrs: {
      version = "1.3.0";
      src = fetchFromGitHub {
        owner = "fairyglade";
        repo = "ly";
        rev = "4bc405f2397006e643c5be128443518ae3b8e96a";
        hash = "sha256-xnaiunAt0teNFBJMHppn1etO8pOsgqbxjBkYhvbELP0=";
      };
    }))
  ];

  fonts.packages = with pkgs; [
    # mono
    fira-code
    hack-font
    uw-ttyp0
    jetbrains-mono
    maple-mono.truetype
    pkgs-stable.iosevka
    (iosevka.override {
      set = "Custom";
      privateBuildPlan = ''
        [buildPlans.IosevkaCustom]
        family = "Iosevka Custom"
        spacing = "normal"
        serifs = "sans"
        noCvSs = true
        exportGlyphNames = false

          [buildPlans.IosevkaCustom.ligations]
          inherits = "dlig"

        [buildPlans.IosevkaCustom.weights.Regular]
        shape = 400
        menu = 400
        css = 400

        [buildPlans.IosevkaCustom.weights.Bold]
        shape = 700
        menu = 700
        css = 700

        [buildPlans.IosevkaCustom.slopes.Upright]
        angle = 0
        shape = "upright"
        menu = "upright"
        css = "normal"

        [buildPlans.IosevkaCustom.slopes.Italic]
        angle = 9.4
        shape = "italic"
        menu = "italic"
        css = "italic"
      '';
    })

    aporetic
    nerd-fonts.iosevka

    # variable
    vollkorn
    recursive
    xits-math
    liberation_ttf

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
