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

  # customWlroots = pkgs.wlroots.overrideAttrs (oldAttrs: {
  #   src = pkgs.fetchFromGitLab {
  #     domain = "gitlab.freedesktop.org";
  #     owner = "tokyo4j";
  #     repo = "wlroots";
  #     rev = "fix-maximized-window-scrollbar";
  #     hash = "sha256-qo3Shi/M+nJ3wTStkq/vScmIYYCPK3GQtRCYi/E/bmw=";  # Put real hash here
  #   };
  # });

  # customSwayUnwrapped = pkgs.sway-unwrapped.overrideAttrs (oldAttrs: {
  #   buildInputs = builtins.map (pkg:
  #     if (pkg.pname or null) == "wlroots" then
  #       customWlroots.override { inherit (oldAttrs) enableXWayland; }
  #     else pkg
  #   ) oldAttrs.buildInputs;
  #   # Also need to update nativeBuildInputs if wlroots is there
  #   nativeBuildInputs = builtins.map (pkg: 
  #     if (pkg.pname or null) == "wlroots" then
  #       customWlroots.override { inherit (oldAttrs) enableXWayland; }
  #     else pkg
  #   ) (oldAttrs.nativeBuildInputs or []);
  # });



in {

  # test
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     wlroots = prev.wlroots.overrideAttrs (oldAttrs: {
  #       src = prev.fetchFromGitLab {
  #         owner = "tokyo4j";
  #         repo = "wlroots";
  #         rev = "fix-maximized-window-scrollbar";
  #         hash = "sha256-qo3Shi/M+nJ3wTStkq/vScmIYYCPK3GQtRCYi/E/bmw";
  #       };
  #     });
  #   })
  # ];

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     wlroots = prev.wlroots.overrideAttrs (oldAttrs: {
  #       src = prev.fetchFromGitLab {
  #         domain = "gitlab.freedesktop.org";  # add this if it's on freedesktop
  #         owner = "tokyo4j";
  #         repo = "wlroots";
  #         rev = "fix-maximized-window-scrollbar";
  #         hash = "";
  #       };

  #       sway = prev.sway.overrideAttrs (oldAttrs: {
  #         name = "sway-custom-wlroots";
  #       });

  #       # # Force sway to rebuild by changing it slightly
  #       # sway = prev.sway.overrideAttrs (oldAttrs: {
  #       #   # This forces a rebuild since it changes the derivation
  #       #   buildInputs = oldAttrs.buildInputs;
  #       # });
  #     });
  #   })
  # ];
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     wlroots = throw "OVERLAY IS RUNNING!";
  #   })
  # ];


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

    ## desktop programs
    alacritty
    kitty
    mpv
    feh
    pavucontrol
    networkmanagerapplet
    w3m # for emacs-w3m
    xfce.thunar

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
    poppler_utils  # for pdftotext
    colordiff
    tldr

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

    ## fun
    hyfetch
    uwufetch

    ## temp

    # (sway.overrideAttrs (oldAttrs: {
    #       buildInputs = map
    #         (pkgs.wlroots.overrideAttrs (oldAttrs: {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "swaywm";
    #       repo = "wlroots";
    #       rev = "your-commit-hash-here";
    #       sha256 = "0000000000000000000000000000000000000000000000000000";
    #     };
    #   });
    # )
    #         oldAttrs.buildInputs;
    #     }))

    # (sway.overrideAttrs: {
    #   wlroots = pkgs.wlroots.overrideAttrs (oldAttrs: {
    #     src = pkgs.fetchFromGitLab {
    #       owner = "tokyo4j";
    #       repo = "wlroots";
    #       rev = "fix-maximized-window-scrollbar";
    #       sha256 = lib.fakeSha256; # use lib.fakeSha256 or update after first build
    #     };
    #   });
    # })

    # (sway.overrideAttrs (oldAttrs: rec {
    #   buildInputs = builtins.map (pkg:
    #     if (pkg.pname or null) == "wlroots" then
    #       pkg.overrideAttrs (wlrOld: {
    #         src = fetchFromGitHub {
    #           owner = "tokyo4j";
    #           repo = "wlroots";
    #           rev = "fix-maximized-window-scrollbar";
    #           hash = "";
    #         };
    #       })
    #     else pkg
    #   ) oldAttrs.buildInputs;
    # }))

    # (sway.override (old: {
    #   wlroots = wlroots.overrideAttrs (oldAttrs: {
    #     src = fetchFromGitHub {
    #       owner = "swaywm";
    #       repo = "wlroots";
    #       rev = "your-commit-hash-here";
    #       hash = "sha256-0000000000000000000000000000000000000000000000000000";
    #     };
    #   });
    # }))

    # (sway.override {
    #   wlroots = wlroots.overrideAttrs (oldAttrs: {
    #     src = fetchFromGitHub {
    #       owner = "swaywm";
    #       repo = "wlroots";
    #       rev = "your-commit-hash-here";
    #       hash = "sha256-0000000000000000000000000000000000000000000000000000";
    #     };
    #   });
    # })

    # sway
    # pkgs.sway
    # pkgs.sway

    # (sway.overrideAttrs (oldAttrs: {
    #   buildInputs = builtins.map (pkg: 
    #     if (pkg.pname or null) == "wlroots" then
    #       (wlroots.override { inherit (oldAttrs) enableXWayland; }).overrideAttrs (wlrOld: {
    #         src = fetchFromGitLab {
    #           domain = "gitlab.freedesktop.org";
    #           owner = "tokyo4j";
    #           repo = "wlroots";
    #           rev = "fix-maximized-window-scrollbar";
    #           hash = "";
    #         };
    #       })
    #     else pkg
    #   ) oldAttrs.buildInputs;
    # }))
    # (pkgs.sway.overrideAttrs (oldAttrs: {
    #   buildInputs = builtins.map (pkg: 
    #     if (pkg.pname or null) == "wlroots" then
    #       (pkgs.wlroots.override { 
    #         enableXWayland = oldAttrs.enableXWayland or true; 
    #       }).overrideAttrs (wlrOld: {
    #         src = pkgs.fetchFromGitLab {
    #           domain = "gitlab.freedesktop.org";
    #           owner = "tokyo4j";
    #           repo = "wlroots";
    #           rev = "fix-maximized-window-scrollbar";
    #           hash = "";
    #         };
    #       })
    #     else pkg
    #   ) oldAttrs.buildInputs;
    # }))
    # (pkgs.sway.overrideAttrs (oldAttrs: {
    #   buildInputs = builtins.map (pkg: 
    #     if (pkg.pname or null) == "wlroots" then
    #       (pkgs.wlroots.override { 
    #         enableXWayland = oldAttrs.enableXWayland or true; 
    #       }).overrideAttrs (wlrOld: {
    #         src = pkgs.fetchFromGitLab {
    #           domain = "gitlab.freedesktop.org";
    #           owner = "tokyo4j";
    #           repo = "wlroots";
    #           rev = "fix-maximized-window-scrollbar";
    #           hash = "";
    #         };
    #       })
    #     else pkg
    #   ) (oldAttrs.buildInputs or []);
    
    #   propagatedBuildInputs = builtins.map (pkg: 
    #     if (pkg.pname or null) == "wlroots" then
    #       (pkgs.wlroots.override { 
    #         enableXWayland = oldAttrs.enableXWayland or true; 
    #       }).overrideAttrs (wlrOld: {
    #         src = pkgs.fetchFromGitLab {
    #           domain = "gitlab.freedesktop.org";
    #           owner = "tokyo4j";
    #           repo = "wlroots";
    #           rev = "fix-maximized-window-scrollbar";
    #           hash = "";
    #         };
    #       })
    #     else pkg
    #   ) (oldAttrs.propagatedBuildInputs or []);
    # }))

    # (pkgs.sway.override {
    #   sway-unwrapped
    #   =
    #     customSwayUnwrapped;
    # })


    # (pkgs.sway.overrideAttrs (oldAttrs: 
    #   builtins.trace "Available attrs: ${builtins.toString (builtins.attrNames oldAttrs)}" {}
    # ))

    # (pkgs.sway.overrideAttrs (oldAttrs: 
    #   builtins.trace "OVERRIDE CALLED, buildInputs length: ${toString (builtins.length oldAttrs.buildInputs)}"
    #     {
    #       buildInputs = builtins.map (pkg: 
    #         builtins.trace "Checking package: ${pkg.pname or "no-pname"}"
    #           (if (pkg.pname or null) == "wlroots" then
    #             (builtins.trace "FOUND WLROOTS, OVERRIDING"
    #               (pkgs.wlroots.override { 
    #                 enableXWayland = oldAttrs.enableXWayland or true; 
    #               }).overrideAttrs (wlrOld: {
    #                 src = pkgs.fetchFromGitLab {
    #                   domain = "gitlab.freedesktop.org";
    #                   owner = "tokyo4j";
    #                   repo = "wlroots";
    #                   rev = "fix-maximized-window-scrollbar";
    #                   hash = "";
    #                 };
    #               }))
    #            else pkg)
    #       ) oldAttrs.buildInputs;
    #     }
    # ))

    (pkgs.sway.override { sway-unwrapped = customSwayUnwrapped; })


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
