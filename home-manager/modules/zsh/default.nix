{ ... }:

{
  # later make a shells dir and in default.nix, place user.${user}.defaultShell in there.
  programs.zsh = {
    enable = true;

    autosuggestion = {
      enable = true;
    };
    history = {
      save = 10000;
      size = 10000;
    };

    sessionVariables = {

      NIXOS_OZONE_WL = "1";  # enable native wayland on chromium/electron

      LC_COLLATE = "C";
      # CC = "gcc";
      VISUAL = "emacsclient";
      EDITOR = "emacsclient";
      PATH = "$PATH:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/Scripts";
      XDG_CURRENT_DESKTOP = "dwl";
      XDG_SESSION_TYPE = "wayland";
      RTC_USE_PIPEWIRE = "true";
      SDL_VIDEODRIVER = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      CLUTTER_BACKEND = "wayland";
      ELM_ENGINE = "wayland";
      ECORE_EVAS_ENGINE = "wayland";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      ANKI_WAYLAND = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      # WLR_NO_HARDWARE_CURSORS = "1";
      # WLR_DRM_NO_ATOMIC = "1";
      # QT_STYLE_OVERRIDE = "kvantum";
    };

    shellAliases = {

      em = "emacsclient -c -a ''";
      l = "ls -p --color = auto";
      ls = "ls -p --color = auto";
      la = "ls -a --color = auto";
      ll = "ls -lh --color = auto";
      lla = "ls -lha --color = auto";
      rm = "rm -i";
      ts = "trash";
      b = "cd ..";
      p = "cd -";
      
      iping = "ping gnu.org";
      recursive-find = "grep -rnw . -e";
    
    };

    initExtra = ''
      export GPG_TTY=$(tty)
      gpg-connect-agent updatestartuptty /bye >/dev/null

      [[ $- == *i* ]] && [ -z "$TMUX" ] && tmux new-session -A -s default
    '';
  };
}
