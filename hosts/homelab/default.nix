{ user, config, lib, inputs, ... }:

{
  ## Hardware Configuration
  imports = [
    ./hardware-configuration.nix
    ./packages-temp.nix # TODO: move these
  ];

  ## Flags
  # (no need to specify config prefix, because that's the
  # final state of the ENTIRE flake config)

  ## Home Flags
  home-manager.users.${user}.features = {
    # audio
    mpd.enable = false;
    # cron
    cron-hyprpaper.enable = false;
    cron-low-bat.enable = false;
    # dev
    git.enable = true;
    dev-env.enable = true;
    tmux.enable = true;
    gpg.enable = true;
    # dotfiles
    dotfiles.enable = true;
    # shells
    zsh.enable = true;
    # themes
    app-theme-def.enable = true;
    # xkb
    fcitx.enable = false;
  };

  ## System Flags
  features = {
    # global
    global.enable = true;
    # applications
    virtualization.enable = false;
    flatpak.enable = false;
    gtk-portal.enable = false;
    wlr-portal.enable = false;
    # firejail
    firejail.enable = true;
    # games
    games.enable = true;
    # hardware
    laptop-power.enable = false;
    # misc
    nix-ld.enable = false;
    # networking
    mullvad.enable = false;
    bluetooth.enable = false;
    dns-over-https.enable = false;
    # renoise
    renoise.enable = false;
    # wayland
    hyprland.enable = false;
    # zsh
    zsh.enable = true;
  };

  ## Host-specific configs
  boot = {
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };
}
