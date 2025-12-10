{ lib, mkFeature, ... }:

{
  imports = [
    (mkFeature "zsh" "Enable zsh" {
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
          PATH = "$PATH:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/Scripts";

          # CC = "gcc";
          LC_COLLATE = "C";
          EDITOR = "emacsclient";
          VISUAL = "emacsclient";

          # XDG_CURRENT_DESKTOP = "river";
          XDG_CURRENT_DESKTOP = "Hyprland";
          XDG_SESSION_TYPE = "wayland";

          ANKI_WAYLAND = "1";
          # CLUTTER_BACKEND = "wayland";
          # ECORE_EVAS_ENGINE = "wayland";
          # ELM_ENGINE = "wayland";
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

          # WAYLAND_DEBUG = "1";

          ## Fcitx input related
          GLFW_IM_MODULE = "fcitx";
          XMODIFIERS = "@im=fcitx";
          GTK_IM_MODULE = "";
          # GTK_IM_MODULE = "fcitx";
          # GTK_IM_MODULE = "wayland";

          QT_IM_MODULE = "fcitx";
          QT_IM_MODULES = "fcitx;wayland;ibus";

          LSP_USE_PLISTS = "true"; # emacs lsp-booster
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

        initContent = lib.mkOrder 550 ''
      # autosuggestion text color
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'

      # completion
      autoload -U compinit; compinit
      zstyle ':completion:*' menu select
    '';
      };


      #  misc dev

      programs.direnv = {
        enable = true;
        # nixOptions = ["keep-outputs" "keep-derivations"];  # Optional but recommended
      };

      services.lorri.enable = true;
    })
  ];
}
