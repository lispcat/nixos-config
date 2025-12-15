{ user, config, lib, inputs, ... }:

{
  ## Hardware Configuration
  imports = [
    ./hardware-configuration.nix
    ./hardware-tweaks.nix
    ./packages-temp.nix # TODO: move these
  ];

  ## Flags
  # (no need to specify config prefix, because that's the
  # final state of the ENTIRE flake config)

  ## Home Flags
  home-manager.users.${user}.features = {
    # audio
    mpd.enable = true;
    pro-audio.enable = true;
    # cron
    cron-hyprpaper.enable = true;
    cron-low-bat.enable = true;
    # dev
    git.enable = true;
    dev-env.enable = true;
    tmux.enable = false;
    gpg.enable = true;
    # dotfiles
    dotfiles.enable = true;
    # shells
    zsh.enable = true;
    # themes
    app-theme-def.enable = true;
    # xkb
    fcitx.enable = true;
  };

  ## System Flags
  features = {
    # global
    global.enable = true;
    # applications
    virtualization.enable = true;
    flatpak.enable = false;
    gtk-portal.enable = false;
    wlr-portal.enable = false;
    # firejail
    firejail.enable = true;
    # games
    games.enable = true;
    # hardware
    laptop-power.enable = true;
    # misc
    nix-ld.enable = false;
    # networking
    mullvad.enable = false;
    bluetooth.enable = false;
    dns-over-https.enable = false;
    # renoise
    renoise.enable = true;
    # wayland
    hyprland.enable = true;
    # zsh
    zsh.enable = true;
  };

  ## Host-specific configs
  boot = {
    kernel.sysctl = { "vm.swappiness" = lib.mkForce 1; };
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };

}
