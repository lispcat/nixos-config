{ config, ... }:

{
  programs.zsh = {
    enable = true;

    autosuggestion = {
      enable = true;
    };
    history = {
      save = 10000;
      size = 10000;
    };
    loginExtra = ''
      export GPG_TTY=$TTY
      ${config.programs.gpg.package}/bin/gpg-connect-agent updatestartuptty /bye > /dev/null
    '';

    sessionVariables = {
      PATH = "$PATH:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/Scripts";
      
      # CC = "gcc";
      LC_COLLATE = "C";
      EDITOR = "emacsclient";
      VISUAL = "emacsclient";
      
      XDG_CURRENT_DESKTOP = "dwl";
      XDG_SESSION_TYPE = "wayland";
      
      ANKI_WAYLAND = "1";
      CLUTTER_BACKEND = "wayland";
      ECORE_EVAS_ENGINE = "wayland";
      ELM_ENGINE = "wayland";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";  # enable native wayland on chromium/electron
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      
      RTC_USE_PIPEWIRE = "true";
      # WLR_NO_HARDWARE_CURSORS = "1";
      # WLR_DRM_NO_ATOMIC = "1";
      # QT_STYLE_OVERRIDE = "kvantum";
    };

    shellAliases = {
      em = "emacsclient -c -a ''";
      l = "ls -p --color=auto";
      ls = "ls -p --color=auto";
      la = "ls -a --color=auto";
      ll = "ls -lh --color=auto";
      lla = "ls -lha --color=auto";
      rm = "rm -i";
      ts = "trash";
      b = "cd ..";
      p = "cd -";
      
      iping = "ping gnu.org";
      recursive-find = "grep -rnw . -e";
    };
  };
}
